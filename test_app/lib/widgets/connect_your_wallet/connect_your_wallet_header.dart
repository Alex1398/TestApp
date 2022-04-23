import 'package:flutter/material.dart';

class ConnectYourWalletHeader extends StatelessWidget {
  const ConnectYourWalletHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Connect your wallet',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'we\'ll send you a confirmation code',
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
