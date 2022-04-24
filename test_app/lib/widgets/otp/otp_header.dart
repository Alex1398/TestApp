import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  const OtpHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'We\'ve sent you a code',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Enter confirmation code below',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
