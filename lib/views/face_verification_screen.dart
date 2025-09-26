import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import '../view_models/driver_documents_view_model.dart';

class FaceVerificationScreen extends StatefulWidget {
  const FaceVerificationScreen({super.key});

  @override
  State<FaceVerificationScreen> createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen> with WidgetsBindingObserver {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  
  // Face detection variables
  late FaceDetector _faceDetector;
  bool _isFaceDetected = false;
  bool _isFaceCentered = false;
  bool _isProcessing = false;
  bool _faceDetectionEnabled = true;
  int _consecutiveFailures = 0;
  Timer? _faceDetectionTimer;
  List<Face> _detectedFaces = [];
  
  // Error handling and state management
  String? _errorMessage;
  bool _hasError = false;
  int _retryCount = 0;
  static const int _maxRetries = 3;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeApp();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    switch (state) {
      case AppLifecycleState.paused:
        _pauseFaceDetection();
        break;
      case AppLifecycleState.resumed:
        _resumeFaceDetection();
        break;
      case AppLifecycleState.detached:
        _stopFaceDetection();
        break;
      default:
        break;
    }
  }

  void _pauseFaceDetection() {
    _faceDetectionTimer?.cancel();
    _cameraController?.pausePreview();
  }

  void _resumeFaceDetection() {
    if (_isCameraInitialized && _faceDetectionEnabled) {
      _cameraController?.resumePreview();
      _startFaceDetection();
    }
  }

  void _stopFaceDetection() {
    _faceDetectionTimer?.cancel();
  }

  Future<void> _initializeApp() async {
    try {
      await _initializeFaceDetector();
      await _initializeCamera();
    } catch (e) {
      _handleError('Failed to initialize app: $e');
    }
  }

  void _handleError(String message) {
    print('Error: $message');
    if (mounted) {
      setState(() {
        _hasError = true;
        _errorMessage = message;
      });
    }
  }

  void _clearError() {
    if (mounted) {
      setState(() {
        _hasError = false;
        _errorMessage = null;
      });
    }
  }

  Future<void> _retryInitialization() async {
    if (_retryCount >= _maxRetries) {
      _handleError('Maximum retry attempts reached. Please restart the app.');
      return;
    }

    _retryCount++;
    _clearError();
    
    try {
      await _initializeApp();
      _retryCount = 0; // Reset on success
    } catch (e) {
      _handleError('Retry $_retryCount failed: $e');
    }
  }

  Future<void> _initializeFaceDetector() async {
    try {
      final options = FaceDetectorOptions(
        enableContours: true,
        enableLandmarks: true,
        enableClassification: true,
        enableTracking: true,
        minFaceSize: 0.1,
        performanceMode: FaceDetectorMode.accurate,
      );
      _faceDetector = FaceDetector(options: options);
      print('Face detector initialized successfully');
    } catch (e) {
      print('Face detector initialization error: $e');
      _handleError('Face detector initialization failed: $e');
      rethrow;
    }
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      
      if (_cameras.isEmpty) {
        throw Exception('No cameras available on this device');
      }

      final frontCamera = _cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => _cameras.first,
      );

      // Try different image formats and resolutions
      final imageFormats = [
        ImageFormatGroup.bgra8888,
        ImageFormatGroup.yuv420,
        ImageFormatGroup.nv21,
      ];

      final resolutions = [
        ResolutionPreset.medium,
        ResolutionPreset.low,
        ResolutionPreset.high,
      ];

      bool cameraInitialized = false;
      
      for (final resolution in resolutions) {
        for (final format in imageFormats) {
          try {
            _cameraController = CameraController(
              frontCamera,
              resolution,
              enableAudio: false,
              imageFormatGroup: format,
            );

            await _cameraController!.initialize();
            cameraInitialized = true;
            print('Camera initialized with format: $format, resolution: $resolution');
            break;
          } catch (e) {
            print('Failed to initialize camera with format $format, resolution $resolution: $e');
            await _cameraController?.dispose();
            _cameraController = null;
          }
        }
        if (cameraInitialized) break;
      }

      if (!cameraInitialized) {
        throw Exception('Failed to initialize camera with any format or resolution');
      }

      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
        _startFaceDetection();
      }
    } catch (e) {
      print('Camera initialization error: $e');
      _handleError('Camera initialization failed: $e');
      rethrow;
    }
  }

  Future<void> _captureImage(DriverDocumentsViewModel viewModel) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile image = await _cameraController!.takePicture();
      final success = await viewModel.captureIdentityImageWithGenerator(File(image.path));

      if (success && mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      print('Image capture error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to capture image: $e')),
      );
    }
  }

  void _startFaceDetection() {
    // Start face detection timer - run every 1 second
    _faceDetectionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _captureAndProcessImage();
    });
  }

  Future<void> _captureAndProcessImage() async {
    if (!mounted || _isProcessing || !_faceDetectionEnabled || _cameraController == null) return;

    try {
      // Capture a single image for face detection
      final XFile image = await _cameraController!.takePicture();
      final File imageFile = File(image.path);
      
      if (await imageFile.exists()) {
        await _processImageForFaceDetection(imageFile);
        // Clean up the temporary image file
        try {
          await imageFile.delete();
        } catch (e) {
          print('Warning: Could not delete temporary image file: $e');
        }
      } else {
        print('Warning: Captured image file does not exist');
      }
    } catch (e) {
      print('Error capturing image for face detection: $e');
      _consecutiveFailures++;
      
      // Disable face detection after too many failures
      if (_consecutiveFailures >= 10) {
        print('Too many consecutive failures, disabling face detection');
        _faceDetectionEnabled = false;
        if (mounted) {
          setState(() {
            _isFaceDetected = true; // Allow capture
            _isFaceCentered = true;
          });
        }
      }
    }
  }

  Future<void> _processImageForFaceDetection(File imageFile) async {
    if (!mounted || _isProcessing || !_faceDetectionEnabled) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      // Create InputImage from file
      final inputImage = InputImage.fromFile(imageFile);
      
      final List<Face> faces = await _faceDetector.processImage(inputImage);
      
      // Reset failure counter on success
      _consecutiveFailures = 0;
      
      if (mounted) {
        setState(() {
          _detectedFaces = faces;
          _isFaceDetected = faces.isNotEmpty;
          if (_isFaceDetected) {
            _isFaceCentered = _isFaceInCenterFromFile(faces.first, imageFile);
          } else {
            _isFaceCentered = false;
          }
          _isProcessing = false;
        });
      }
    } catch (e) {
      print('Face detection error: $e');
      _consecutiveFailures++;
      
      // Disable face detection after too many failures
      if (_consecutiveFailures >= 10) {
        print('Too many consecutive failures, disabling face detection');
        _faceDetectionEnabled = false;
        setState(() {
          _isFaceDetected = true; // Allow capture
          _isFaceCentered = true;
        });
      }
      
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    } 
  }


  bool _isFaceInCenterFromFile(Face face, File imageFile) {
    final faceRect = face.boundingBox;
    
    // For file-based face detection, we'll use a simpler approach
    // since we don't have direct access to image dimensions
    final faceSize = faceRect.width * faceRect.height;
    
    // Check if face is reasonably sized and positioned
    return faceSize > 1000 && faceSize < 100000; // Reasonable face size range
  }


  @override
  void dispose() {
    try {
      WidgetsBinding.instance.removeObserver(this);
      _faceDetectionTimer?.cancel();
      _cameraController?.dispose();
      _faceDetector.close();
    } catch (e) {
      print('Error during dispose: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6B46C1), // Purple background like in the image
      body: ChangeNotifierProvider(
        create: (BuildContext context)=> DriverDocumentsViewModel(),
        child: Consumer<DriverDocumentsViewModel>(
          builder: (context, viewModel, child) {
            // Show error screen if there's an error
            if (_hasError) {
              return _buildErrorScreen();
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    // Camera Preview
                    Positioned.fill(
                      child: _buildCameraPreview(),
                    ),

                    // Face Frame Overlay
                    Positioned.fill(
                      child: _buildFaceFrameOverlay(),
                    ),

                    // Face Landmarks Overlay
                    Positioned.fill(
                      child: _buildFaceLandmarksOverlay(),
                    ),

                    // Header
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: _buildHeader(),
                    ),

                    // Instructions - Responsive positioning
                    Positioned(
                      top: constraints.maxHeight * 0.12,
                      left: 0,
                      right: 0,
                      child: _buildInstructions(),
                    ),

                    // Capture Button
                    Positioned(
                      bottom: constraints.maxHeight * 0.08,
                      left: 0,
                      right: 0,
                      child: _buildCaptureButton(viewModel),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildErrorScreen() {
    return Container(
      color: const Color(0xFF6B46C1),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 64.sp,
              ),
              SizedBox(height: 24.h),
              Text(
                'Something went wrong',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                _errorMessage ?? 'An unexpected error occurred',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _retryCount < _maxRetries ? _retryInitialization : null,
                    icon: const Icon(Icons.refresh),
                    label: Text('Retry (${_retryCount}/$_maxRetries)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6B46C1),
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraPreview() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final aspectRatio = _cameraController!.value.aspectRatio;

        // Ensure aspect ratio is valid
        if (aspectRatio <= 0) {
          return Container(
            color: Colors.black,
            child: Center(child: Text('Camera not ready')),
          );
        }

        return SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxWidth / aspectRatio,
          child: CameraPreview(_cameraController!),
        );
      },
    );
  }

  Widget _buildFaceFrameOverlay() {
    return CustomPaint(
      painter: FaceFramePainter(
        isFaceDetected: _isFaceDetected,
        isFaceCentered: _isFaceCentered,
        isProcessing: _isProcessing,
      ),
      child: Container(),
    );
  }

  Widget _buildFaceLandmarksOverlay() {
    if (!_isFaceDetected || _detectedFaces.isEmpty) {
      return Container();
    }

    return CustomPaint(
      painter: FaceLandmarksPainter(
        faces: _detectedFaces,
        isFaceCentered: _isFaceCentered,
      ),
      child: Container(),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24.sp,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Selfie',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 40.w), // Balance the close button
          ],
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.55,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isFaceDetected && _isFaceCentered)
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 32,
                )
              else if (_isFaceDetected && !_isFaceCentered)
                const Icon(
                  Icons.warning_amber,
                  color: Colors.orange,
                  size: 32,
                )
              else
                const Icon(
                  Icons.face_retouching_natural,
                  color: Colors.white,
                  size: 32,
                ),
              SizedBox(height: 12.h),
              Flexible(
                child: Text(
                  _isFaceDetected && _isFaceCentered
                      ? 'Perfect! Face detected'
                      : _isFaceDetected && !_isFaceCentered
                          ? 'Center your face in the oval'
                          : 'Position your face in the oval',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8.h),
              Flexible(
                child: Text(
                  _isFaceDetected && _isFaceCentered
                      ? 'Ready to capture'
                      : _isFaceDetected && !_isFaceCentered
                          ? 'Move your face to the center'
                          : 'Make sure your face is centered and well-lit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14.sp,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCaptureButton(DriverDocumentsViewModel viewModel) {
    final bool canCapture = _isFaceDetected && _isFaceCentered;
    
    return Center(
      child: GestureDetector(
        onTap: canCapture ? () => _captureImage(viewModel) : null,
        child: Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: canCapture ? Colors.white : Colors.white.withOpacity(0.3),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Icon(
            canCapture ? Iconsax.camera : Iconsax.camera_slash,
            color: canCapture ? const Color(0xFF6B46C1) : Colors.grey,
            size: 32.sp,
          ),
        ),
      ),
    );
  }
}

class FaceFramePainter extends CustomPainter {
  final bool isFaceDetected;
  final bool isFaceCentered;
  final bool isProcessing;

  FaceFramePainter({
    required this.isFaceDetected,
    required this.isFaceCentered,
    required this.isProcessing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radiusX = size.width * 0.32;
    final double radiusY = size.height * 0.20;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Create oval path for the face frame
    final Path ovalPath = Path()
      ..addOval(Rect.fromCenter(
        center: center,
        width: radiusX * 2,
        height: radiusY * 2,
      ));

    // Draw dark overlay with oval cutout
    final Paint overlayPaint = Paint()..color = Colors.black.withOpacity(0.3);
    
    // Create a path that covers the entire screen
    final Path fullScreenPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create the cutout by subtracting the oval from the full screen
    final Path cutoutPath = Path.combine(
      PathOperation.difference,
      fullScreenPath,
      ovalPath,
    );

    // Draw the dark overlay with cutout
    canvas.drawPath(cutoutPath, overlayPaint);

    // Determine border color based on face detection state
    Color borderColor;
    if (isFaceDetected && isFaceCentered) {
      borderColor = Colors.green;
    } else if (isFaceDetected && !isFaceCentered) {
      borderColor = Colors.orange;
    } else {
      borderColor = Colors.white;
    }

    // Draw border around the oval frame
    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawOval(
      Rect.fromCenter(
        center: center,
        width: radiusX * 2,
        height: radiusY * 2,
      ),
      borderPaint,
    );

  }

  @override
  bool shouldRepaint(covariant FaceFramePainter oldDelegate) {
    return oldDelegate.isFaceDetected != isFaceDetected ||
           oldDelegate.isFaceCentered != isFaceCentered;
  }
}

class FaceLandmarksPainter extends CustomPainter {
  final List<Face> faces;
  final bool isFaceCentered;

  FaceLandmarksPainter({
    required this.faces,
    required this.isFaceCentered,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final face in faces) {
      _drawFaceLandmarks(canvas, face, size);
    }
  }

  void _drawFaceLandmarks(Canvas canvas, Face face, Size size) {
    final paint = Paint()
      ..color = isFaceCentered ? Colors.green : Colors.orange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = (isFaceCentered ? Colors.green : Colors.orange).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    // Draw face contour
    if (face.contours[FaceContourType.face] != null) {
      final contour = face.contours[FaceContourType.face]!;
      _drawContour(canvas, contour, paint, size);
    }

    // Draw left eye
    if (face.landmarks[FaceLandmarkType.leftEye] != null) {
      final leftEye = face.landmarks[FaceLandmarkType.leftEye]!;
      _drawLandmark(canvas, leftEye, paint, fillPaint, size);
    }

    // Draw right eye
    if (face.landmarks[FaceLandmarkType.rightEye] != null) {
      final rightEye = face.landmarks[FaceLandmarkType.rightEye]!;
      _drawLandmark(canvas, rightEye, paint, fillPaint, size);
    }

    // Draw nose
    if (face.landmarks[FaceLandmarkType.noseBase] != null) {
      final nose = face.landmarks[FaceLandmarkType.noseBase]!;
      _drawLandmark(canvas, nose, paint, fillPaint, size);
    }

    // Draw mouth
    if (face.landmarks[FaceLandmarkType.bottomMouth] != null) {
      final mouth = face.landmarks[FaceLandmarkType.bottomMouth]!;
      _drawLandmark(canvas, mouth, paint, fillPaint, size);
    }

    // Draw left ear
    if (face.landmarks[FaceLandmarkType.leftEar] != null) {
      final leftEar = face.landmarks[FaceLandmarkType.leftEar]!;
      _drawLandmark(canvas, leftEar, paint, fillPaint, size);
    }

    // Draw right ear
    if (face.landmarks[FaceLandmarkType.rightEar] != null) {
      final rightEar = face.landmarks[FaceLandmarkType.rightEar]!;
      _drawLandmark(canvas, rightEar, paint, fillPaint, size);
    }

    // Draw left cheek
    if (face.landmarks[FaceLandmarkType.leftCheek] != null) {
      final leftCheek = face.landmarks[FaceLandmarkType.leftCheek]!;
      _drawLandmark(canvas, leftCheek, paint, fillPaint, size);
    }

    // Draw right cheek
    if (face.landmarks[FaceLandmarkType.rightCheek] != null) {
      final rightCheek = face.landmarks[FaceLandmarkType.rightCheek]!;
      _drawLandmark(canvas, rightCheek, paint, fillPaint, size);
    }
  }

  void _drawContour(Canvas canvas, FaceContour contour, Paint paint, Size size) {
    final points = contour.points;
    if (points.isEmpty) return;

    final path = Path();
    path.moveTo(
      points.first.x * size.width,
      points.first.y * size.height,
    );

    for (int i = 1; i < points.length; i++) {
      path.lineTo(
        points[i].x * size.width,
        points[i].y * size.height,
      );
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawLandmark(Canvas canvas, FaceLandmark landmark, Paint paint, Paint fillPaint, Size size) {
    final point = landmark.position;
    final center = Offset(
      point.x * size.width,
      point.y * size.height,
    );

    // Draw a circle for the landmark
    canvas.drawCircle(center, 4.0, fillPaint);
    canvas.drawCircle(center, 4.0, paint);
  }

  @override
  bool shouldRepaint(covariant FaceLandmarksPainter oldDelegate) {
    return oldDelegate.faces != faces ||
           oldDelegate.isFaceCentered != isFaceCentered;
  }
}