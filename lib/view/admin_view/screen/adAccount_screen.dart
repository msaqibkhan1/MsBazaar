import 'package:flutter/material.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/utils/GoogleSignIn.dart';
import 'package:msbazaar/utils/another_flushbar.dart';
import 'package:msbazaar/view/selection_screen.dart';
import 'package:msbazaar/view_model/shared_preference.dart';
import 'package:provider/provider.dart';

class AdAccountScreen extends StatelessWidget {
  const AdAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SharedPreferenceProvider sharedPreferenceProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Guest',
                          style: CustomTextStyle.heading1,
                        ),
                        Text('Pakistan', style: CustomTextStyle.greyText),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.settings,
                    color: Colors.red,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10.0, right: 0, top: 20, bottom: 10),
                child: Column(
                  children: [

                    customContainer('Notifications',
                        Icons.notifications_none_outlined, () {}),
                    customContainer(
                        'Orders', Icons.book_online_outlined, () {}),
                    customContainer('Get help', Icons.help_outline, () {}),
                    customContainer('About app', Icons.error_outline, () {}),
                    customContainer('Logout', Icons.logout_outlined,
                        () {
                      GoogleSignUtils().signOutGoogle(context).then((value)  {
                        AnotherFlushbar.anotherFlushbar(context, 'SignOut Successful');
                        sharedPreferenceProvider.getAdminORUser;
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SelectionScreen()),
                                (route) => false);
                      });
                     })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget customContainer(String title, IconData iconData, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          color: Colors.grey.shade100,
          child: Row(
            children: [
              Icon(
                iconData,
                color: Colors.red,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                title,
                style: CustomTextStyle.bottomNavigation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
