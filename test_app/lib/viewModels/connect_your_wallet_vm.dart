import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/otp_screen.dart';
import '../widgets/dialogs/custom_dialog.dart';

class ConnectYourWallerVM with ChangeNotifier {
  String _countryCode;
  var phoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String get countryCode => _countryCode;

  set setCountryCode(String newVal) {
    _countryCode = newVal;
    //  notifyListeners();
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return '';
    }
  }

  String validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return '';
  }

  void trySubmit(BuildContext context) {
    final isValid = formKey.currentState.validate();

    // Close soft keyboard
    FocusScope.of(context).unfocus();

    if (isValid) {
      formKey.currentState.save();
    }
  }

  String validator(BuildContext context, String value) {
    String mobile = validateMobile(value);
    String email = validateEmail(value);
    if (mobile.isNotEmpty && email.isNotEmpty) {
      if (value.contains(RegExp(r'[a-zA-Z]'))) {
        return email;
      }
      return mobile;
    }

    if (email.isEmpty) {
      sendEmail(context, value);
    }

    if (mobile.isEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            dialCode: _countryCode,
            phone: value,
          ),
        ),
      );
    }

    return null;
  }

  Widget bottomTextWidget() {
    return RichText(
      text: const TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(text: 'By signing up I agree to Zedfi\'s '),
          TextSpan(
            text: 'Privacy Policy ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: ' and\n'),
          TextSpan(
            text: 'Terms of Use ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: 'and allow Zedfi to use your information\n for future '),
          TextSpan(
            text: 'Marketing Purposes.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<String> signinWithEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: ActionCodeSettings(
          url: "https://test1298.page.link/",
          androidPackageName: "com.example.app",
          handleCodeInApp: true,
          androidMinimumVersion: "21",
          androidInstallApp: true,
        ),
      );

      return 'success';
    } catch (err) {
      var message = 'An error occured, please check your credentials!';

      if (err.message != null) {
        message = err.message;
      }
      return message;
    }
  }

  void sendEmail(BuildContext context, String value) async {
    String resp = await signinWithEmail(value);
    if (resp != 'success') {
      showCupertinoDialog(
        context: context,
        builder: (context) => CustomDialog(title: 'Error', message: resp),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (context) =>
            const CustomDialog(title: 'Success', message: 'Email success send'),
      );
    }
  }
}
