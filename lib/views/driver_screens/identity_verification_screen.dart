import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_buttons.dart';
import '../../utils/custom_font_style.dart';
import '../../view_models/driver_registration_view_model.dart';
import '../../widgets/custom_progress_indicator.dart';

class IdentityVerificationScreen extends StatefulWidget {
  const IdentityVerificationScreen({super.key});

  @override
  State<IdentityVerificationScreen> createState() => _IdentityVerificationScreenState();
}

class _IdentityVerificationScreenState extends State<IdentityVerificationScreen> {
  CameraController? _cameraController;
  late List<CameraDescription> _cameras;
  bool _isCameraInitialized = false;
  bool _isFrontCamera = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        final frontCamera = _cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => _cameras.first,
        );

        _cameraController = CameraController(
          frontCamera,
          ResolutionPreset.medium,
          enableAudio: false,
        );

        await _cameraController!.initialize();

        if (mounted) {
          setState(() {
            _isCameraInitialized = true;
          });
        }
      }
    } catch (e) {
      print('Camera initialization error: $e');
    }
  }

  Future<void> _switchCamera() async {
    if (_cameraController == null) return;

    setState(() {
      _isCameraInitialized = false;
    });

    await _cameraController!.dispose();

    final newCamera = _cameras.firstWhere(
          (camera) => camera.lensDirection == (_isFrontCamera ? CameraLensDirection.back : CameraLensDirection.front),
      orElse: () => _cameras.first,
    );

    _cameraController = CameraController(
      newCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    setState(() {
      _isCameraInitialized = true;
      _isFrontCamera = !_isFrontCamera;
    });
  }

  Future<void> _captureImage(DriverRegistrationViewModel viewModel) async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    try {
      final XFile image = await _cameraController!.takePicture();

      // Process the captured image
      final success = await viewModel.processCapturedImage(File(image.path));

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

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Widget _buildCameraPreview() {
    if (!_isCameraInitialized || _cameraController == null) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(CustomColors.primaryColor),
              ),
              SizedBox(height: 16.h),
              Text(
                'Initializing Camera...',
                style: TextStyle(
                  color: CustomColors.whiteColor,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: _cameraController!.value.aspectRatio,
      child: CameraPreview(_cameraController!),
    );
  }

  Widget _buildFaceCutoutOverlay() {
    return Center(
      child: Container(
        width: 280.w,
        height: 350.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.primaryColor,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
          children: [
            // Semi-transparent overlay around the cutout
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.srcOut,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ),
              ),
            ),

            // Border with corner indicators
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.primaryColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Stack(
                children: [
                  // Top-left corner
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: CustomColors.primaryColor, width: 4),
                          left: BorderSide(color: CustomColors.primaryColor, width: 4),
                        ),
                      ),
                    ),
                  ),

                  // Top-right corner
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: CustomColors.primaryColor, width: 4),
                          right: BorderSide(color: CustomColors.primaryColor, width: 4),
                        ),
                      ),
                    ),
                  ),

                  // Bottom-left corner
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: CustomColors.primaryColor, width: 4),
                          left: BorderSide(color: CustomColors.primaryColor, width: 4),
                        ),
                      ),
                    ),
                  ),

                  // Bottom-right corner
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: CustomColors.primaryColor, width: 4),
                          right: BorderSide(color: CustomColors.primaryColor, width: 4),
                        ),
                      ),
                    ),
                  ),

                  // Center guidance
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.user,
                          size: 48.sp,
                          color: CustomColors.primaryColor.withValues(alpha: 0.8),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Align your face within the frame',
                          style: TextStyle(
                            color: CustomColors.primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Make sure your face is clearly visible',
                          style: TextStyle(
                            color: CustomColors.whiteColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.blackColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Iconsax.arrow_left_2,
            color: CustomColors.whiteColor,
            size: 24.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Face Verification',
          style: TextStyle(
            color: CustomColors.whiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.camera,
              color: CustomColors.whiteColor,
              size: 24.sp,
            ),
            onPressed: _switchCamera,
          ),
        ],
      ),
      body: Consumer<DriverRegistrationViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              // Camera Preview
              _buildCameraPreview(),

              // Face Cutout Overlay
              _buildFaceCutoutOverlay(),

              // Bottom Controls
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        children: [
                          // Capture Button
                          Container(
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: CustomColors.whiteColor,
                                width: 4,
                              ),
                            ),
                            child: IconButton(
                              icon: Container(
                                width: 60.w,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CustomColors.whiteColor,
                                ),
                              ),
                              onPressed: () => _captureImage(viewModel),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Instructions
                          Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: CustomColors.primaryColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Iconsax.info_circle,
                                      size: 16.sp,
                                      color: CustomColors.primaryColor,
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Verification Tips',
                                      style: TextStyle(
                                        color: CustomColors.primaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  '• Ensure good lighting\n• Look directly at the camera\n• Keep your face centered\n• Remove glasses if possible\n• Maintain a neutral expression',
                                  style: TextStyle(
                                    color: CustomColors.whiteColor,
                                    fontSize: 12.sp,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          // Upload Progress (when uploading)
                          if (viewModel.getUpLoadingProfileImage > 0)
                            Container(
                              margin: EdgeInsets.only(top: 16.h),
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: CustomColors.primaryColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Iconsax.cloud_plus,
                                        size: 20.sp,
                                        color: CustomColors.primaryColor,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'Uploading Verification...',
                                        style: TextStyle(
                                          color: CustomColors.whiteColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 12.h),
                                  LinearProgressIndicator(
                                    value: viewModel.getUpLoadingProfileImage,
                                    backgroundColor: Colors.grey[800],
                                    valueColor: AlwaysStoppedAnimation<Color>(CustomColors.primaryColor),
                                    minHeight: 6.h,
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${(viewModel.getUpLoadingProfileImage * 100).toStringAsFixed(0)}%',
                                    style: TextStyle(
                                      color: CustomColors.whiteColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}