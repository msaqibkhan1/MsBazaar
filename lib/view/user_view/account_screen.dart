import 'package:flutter/material.dart';
import 'package:msbazaar/res/mediaQuery_size.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/utils/GoogleSignIn.dart';
import 'package:msbazaar/view/selection_screen.dart';
import 'package:msbazaar/view/user_view/basket/basket_screen.dart';
import 'package:msbazaar/view_model/shared_preference.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10.0),
                    //   child: Container(
                    //     height: 50,
                    //     color: Colors.grey.shade100,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             const Icon(
                    //               CupertinoIcons.arrow_right_arrow_left,
                    //               color: Colors.red,
                    //               size: 21,
                    //             ),
                    //             const SizedBox(
                    //               width: 20,
                    //             ),
                    //             Text(
                    //               "Dark/Light",
                    //               style: CustomTextStyle.bottomNavigation,
                    //             ),
                    //           ],
                    //         ),
                    //         Switch(value: v, onChanged: (v) {})
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    customContainer('Your Orders', Icons.book_online_outlined,
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BasketScreen()));
                    }),
                    customContainer('Notifications',
                        Icons.notifications_none_outlined, () {}),
                    customContainer('Get help', Icons.help_outline, () {}),
                    customContainer('About app', Icons.error_outline, () {}),
                    customContainer('Logout as user', Icons.logout_outlined,
                        () {
                      GoogleSignUtils().signOutGoogle(context);
                      sharedPreferenceProvider.getAdminORUser;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectionScreen()),
                          (route) => false);
                    }),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              Center(
                child: SizedBox(
                    height: MqSize.mqHeight(0.08, context),
                    width: MqSize.mqWidth(0.09, context),
                    child: Image.asset('img/sign.png')),
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
