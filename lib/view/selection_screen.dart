import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/custom_outlineButton.dart';
import 'package:msbazaar/view/admin_view/auth/login_screen.dart';
import 'package:msbazaar/view/user_view/bottom_navigation.dart';
import 'package:msbazaar/view_model/shared_preference.dart';
import 'package:provider/provider.dart';

import '../res/text_style.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SharedPreferenceProvider sharedPreferenceProvider =
        Provider.of(context, listen: false);
    sharedPreferenceProvider.checkAdminORUser(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferenceProvider sharedPreferenceProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 22.0, bottom: 42, left: 8),
                child: Text(
                  'Selection',
                  style: CustomTextStyle.heading1,
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
                height: 100,
              ),
              CustmOutlinedButton(
                  textColor:Colors.black,
                  title: 'Owner',
                  borderColor: Colors.red,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                  }),
              CustmOutlinedButton(
                  textColor:Colors.black,
                  title: 'User',
                  borderColor: Colors.blue,
                  onTap: () {
                    sharedPreferenceProvider.getUser;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CustomNavigationBar()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
