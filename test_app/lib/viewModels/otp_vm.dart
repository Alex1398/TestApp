import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../widgets/dialogs/custom_dialog.dart';

class OtpVm extends ChangeNotifier {
  String _verificationCode;

  String get verificationCode => _verificationCode;

  set setVerificationCode(String newVal) {
    _verificationCode = newVal;
    //  notifyListeners();
  }

  Future<void> verifyPhone(
      BuildContext context, String dialCode, String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '$dialCode$phone',
        verificationCompleted: (PhoneAuthCredential credential) {
          showCupertinoDialog(
            context: context,
            builder: (context) => const CustomDialog(
                title: 'Success', message: 'Success verify phone'),
          );
        },
        verificationFailed: (FirebaseAuthException e) {
          showCupertinoDialog(
            context: context,
            builder: (context) =>
                CustomDialog(title: 'Error', message: e.message),
          );
        },
        codeSent: (String verificationID, int resendToken) {
          _verificationCode = verificationID;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          _verificationCode = verificationID;
          notifyListeners();
        },
        timeout: const Duration(seconds: 120));
  }

  // Future<void> submit(BuildContext context, String pin) async {
  //   try {
  //     var userPhone = await FirebaseAuth.instance
  //         .linkWithCredential(PhoneAuthProvider.credential(
  //             verificationId: _verificationCode, smsCode: pin));

  //     if (userPhone.user != null) {
  //       showCupertinoDialog(
  //         context: context,
  //         builder: (context) =>
  //             const CustomDialog(title: 'Success', message: 'Success'),
  //       );
  //     }
  //   } catch (e) {
  //     showCupertinoDialog(
  //       context: context,
  //       builder: (context) =>
  //           const CustomDialog(title: 'Error', message: 'Unknow Error'),
  //     );
  //   }
  // }
}
