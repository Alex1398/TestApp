import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModels/otp_vm.dart';
import '../widgets/otp/otp_header.dart';
import '../services/device_characteristics.dart';
import '../widgets/otp/otp_body.dart';

class OtpScreen extends StatelessWidget {
  static const routeName = '/otp-screen';

  final String phone;
  final String dialCode;

  const OtpScreen({
    Key key,
    @required this.dialCode,
    @required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: DeviceCharacteristics.height * 0.05,
              bottom: DeviceCharacteristics.height * 0.05,
              left: DeviceCharacteristics.width * 0.05,
              right: DeviceCharacteristics.width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const OtpHeader(),
                ChangeNotifierProvider.value(
                  value: OtpVm(),
                  child: OtpBody(dialCode: dialCode, phone: phone),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
