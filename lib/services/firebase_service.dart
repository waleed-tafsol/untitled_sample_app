import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled_sample_app/models/base_response_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;
  int? _resendToken;

  BaseResponseModel _baseResponseModel = BaseResponseModel();

  // Future<String> upLoadImageFile(
  //     {required CroppedFile mFileImage, required String fileName}) async {
  //   final Reference storageReference = FirebaseStorage.instance.ref().child(
  //       navigatorKey.currentContext!
  //           .read<AuthViewModel>()
  //           .getAuthResponse
  //           .data!
  //           .sId!);
  //   // Create a reference to "mountains.jpg"
  //   final mountainsRef = storageReference.child("$fileName.jpg");
  //   mountainsRef.putFile(File(mFileImage.path));
  //   String url = await mountainsRef.getDownloadURL();
  //   return url;
  // }

  Future<BaseResponseModel> verifyPhoneNumber(String phoneNumber) async {
    final completer = Completer<BaseResponseModel>();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) {
          completer.complete(
            BaseResponseModel(
              isSuccess: true,
              message: phoneAuthCredential.toString(),
            ),
          );
        },
        verificationFailed: (authException) {
          completer.complete(
            BaseResponseModel(
              isSuccess: false,
              message: authException.toString(),
            ),
          );
        },
        codeSent: (verificationId, resendCode) {
          _verificationId = verificationId;
          _resendToken = resendCode;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
          completer.complete(
            BaseResponseModel(
              isSuccess: true,
              message: verificationId.toString(),
            ),
          );
        },
        forceResendingToken: _resendToken,
      );

      return await completer.future;
    } on FirebaseAuthException catch (e) {
      return BaseResponseModel(
        isSuccess: false,
        message: e.message ?? 'Unknown error',
      );
    } catch (e) {
      return BaseResponseModel(
        isSuccess: false,
        message: 'Unexpected error: $e',
      );
    }
  }

  Future<BaseResponseModel> verifySmsCode(String smsCode) async {
    try {
      if (_verificationId == null) {
        return BaseResponseModel(
          isSuccess: false,
          message: 'No verification in progress',
        );
      }

      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      // Sign in the user with the credential
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      return BaseResponseModel(
        isSuccess: true,
        message: userCredential.toString(),
      );
    } on FirebaseAuthException catch (e) {
      return BaseResponseModel(
        isSuccess: false,
        message: 'Verification failed',
      );
    } catch (e) {
      return BaseResponseModel(
        isSuccess: false,
        message: 'Unexpected error: $e',
      );
    }
  }
}
