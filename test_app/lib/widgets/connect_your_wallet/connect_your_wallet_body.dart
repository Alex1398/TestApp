import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:provider/provider.dart';

import '../../screens/otp_screen.dart';
import '../../services/device_characteristics.dart';
import '../../viewModels/connect_your_wallet_vm.dart';

class ConnectYourWalletBody extends StatelessWidget {
  const ConnectYourWalletBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var connectYourWallerVm = Provider.of<ConnectYourWallerVM>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            CountryCodePicker(
              // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
              initialSelection: 'GB',
              countryFilter: const ['IT', 'FR', 'RO', 'GB'],
              showFlagDialog: true,
              comparator: (a, b) => b.name.compareTo(a.name),
              onInit: (code) =>
                  connectYourWallerVm.setCountryCode = code.dialCode,
              onChanged: (c) => connectYourWallerVm.setCountryCode = c.dialCode,
            ),
            Flexible(
              child: Form(
                key: connectYourWallerVm.formKey,
                child: TextFormField(
                  controller: connectYourWallerVm.phoneNumber,
                  decoration: const InputDecoration(
                    hintText: 'Phone number or email',
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    String mobile = connectYourWallerVm.validateMobile(value);
                    String email = connectYourWallerVm.validateEmail(value);
                    if (mobile.isNotEmpty && email.isNotEmpty) {
                      if (value.contains(RegExp(r'[a-zA-Z]'))) {
                        return email;
                      }
                      return mobile;
                    }

                    if (email.isEmpty) {
                      connectYourWallerVm.sendEmail(context, value);
                    }

                    if (mobile.isEmpty) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OtpScreen(
                              dialCode: connectYourWallerVm.countryCode,
                              phone: value),
                        ),
                      );
                    }

                    return null;
                  },
                ),
              ),
            )
          ],
        ),
        SizedBox(height: DeviceCharacteristics.height * 0.05),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              connectYourWallerVm.trySubmit(context);
            },
            child: const FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Continue',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(DeviceCharacteristics.width * 0.05),
              primary: const Color.fromARGB(231, 196, 234, 8),
            ),
          ),
        ),
        SizedBox(height: DeviceCharacteristics.height * 0.02),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: connectYourWallerVm.bottomTextWidget(),
        ),
      ],
    );
  }
}
