import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/device_characteristics.dart';
import '../widgets/connect_your_wallet/connect_your_wallet_header.dart';
import '../widgets/connect_your_wallet/connect_your_wallet_body.dart';
import '../viewModels/connect_your_wallet_vm.dart';

class ConnectYourWalletScreen extends StatelessWidget {
  static const routeName = '/connect-your-wallet-screen';

  const ConnectYourWalletScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: DeviceCharacteristics.height * 0.05,
            bottom: DeviceCharacteristics.height * 0.05,
            left: DeviceCharacteristics.width * 0.05,
            right: DeviceCharacteristics.width * 0.05,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ConnectYourWalletHeader(),
              ChangeNotifierProvider.value(
                value: ConnectYourWallerVM(),
                child: const ConnectYourWalletBody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
