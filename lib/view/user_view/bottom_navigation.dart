import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msbazaar/view/user_view/account_screen.dart';
import 'package:msbazaar/view/user_view/favorite_screen.dart';
import 'package:msbazaar/view/user_view/home_screen.dart';
import 'package:msbazaar/view/user_view/shop/shops_screen.dart';

import '../../res/AppColor.dart';
import '../../res/mediaQuery_size.dart';
import '../../res/text_style.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  var currentIndex = 0;
  final screen = FirebaseAuth.instance.currentUser?.email == null
      ? [const HomeScreen(), const ShopScreen(), const AccountScreen()]
      : [
          const HomeScreen(),
          const FavoriteScreen(),
          const ShopScreen(),
          const AccountScreen(),
        ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.whiteColor,
        unselectedItemColor: AppColor.greyColor,
        selectedItemColor: AppColor.mainColor,
        showUnselectedLabels: true,
        iconSize: MqSize.mqHeight(0.03, context),
        selectedLabelStyle: CustomTextStyle.bottomNavigation,
        unselectedFontSize: MqSize.mqHeight(.013, context),
        selectedFontSize: MqSize.mqHeight(.015, context),
        currentIndex: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: FirebaseAuth.instance.currentUser?.email == null
            ? const [
                BottomNavigationBarItem(
                    icon: Image(
                      image: AssetImage(
                        'img/Ms.png',
                      ),
                      height: 28,
                      width: 28,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.store), label: 'Shops'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Account'),
              ]
            : [
                const BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Home'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border), label: 'Favorite'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.store), label: 'Shops'),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Account'),
              ],
      ),
      body: screen[currentIndex],
    );
  }
}
