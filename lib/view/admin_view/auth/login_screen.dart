import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/components/custom_outlineButton.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/view/admin_view/screen/adHome_screen.dart';
import 'package:msbazaar/view_model/shared_preference.dart';
import 'package:provider/provider.dart';

import '../../../utils/GoogleSignIn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferenceProvider sharedPreferenceProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 42, left: 8),
                child: Row(
                  children: [
                    CustmIconButton(
                      color: Colors.red,
                      iconColor: Colors.white,
                      iconData: Icons.arrow_back,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    Text(
                      'Login',
                      style: CustomTextStyle.heading1,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'img/Ms.png',
                    height: 70,
                    width: 70,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18.0, left: 8),
                    child: Text(
                      'Bazaar',
                      style: TextStyle(fontSize: 35, color: Colors.blue),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  'Login to create an account to get more functionality'),
              const SizedBox(
                height: 70,
              ),
              CustmOutlinedButton(
                title: 'Google Login',
                borderColor: Colors.red,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      });
                  GoogleSignUtils().signInWithGoogle(context).then((value) {
                    sharedPreferenceProvider.getAdmin;
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdHomeScreen()),
                        (route) => false);
                  });
                },
                textColor: Colors.black,
              ),
              CustmOutlinedButton(
                title: 'Facebook',
                borderColor: Colors.blue,
                textColor: Colors.black,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
