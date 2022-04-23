import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:test_app/viewModels/otp_vm.dart';

import '../../services/device_characteristics.dart';
import '../dialogs/custom_dialog.dart';

class OtpBody extends StatefulWidget {
  final String phone;
  final String dialCode;

  const OtpBody({
    Key key,
    @required this.dialCode,
    @required this.phone,
  }) : super(key: key);

  @override
  State<OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<OtpBody> with WidgetsBindingObserver {
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    // addPostFrameCallback() which is called after the first build, there you can use the context
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<OtpVm>(context, listen: false)
          .verifyPhone(context, widget.dialCode, widget.phone);
    });
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var otpVm = Provider.of<OtpVm>(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: PinPut(
            fieldsCount: 6,
            withCursor: true,
            textStyle: const TextStyle(fontSize: 20.0, color: Colors.white),
            focusNode: _pinPutFocusNode,
            controller: _pinPutController,
            submittedFieldDecoration: pinPutDecoration,
            selectedFieldDecoration: pinPutDecoration,
            followingFieldDecoration: pinPutDecoration,
            pinAnimationType: PinAnimationType.fade,
            // onSubmit: (pin) async {
            //   await otpVm.submit(context, pin);
            // },
          ),
        ),
        // TextButton(
        //   onPressed: () async {
        //     await otpVm.verifyPhone(context, widget.dialCode, widget.phone);
        //   },
        //   child: const Text(
        //     'Verify',
        //     style: TextStyle(
        //       color: Colors.blue,
        //       fontSize: 15,
        //       decoration: TextDecoration.underline,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
