import 'package:flutter/material.dart';

class ConnectYourWalletHeader extends StatelessWidget {
  const ConnectYourWalletHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.arrow_back),
            SizedBox(
              width: 10,
            ),
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
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const FittedBox(
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
