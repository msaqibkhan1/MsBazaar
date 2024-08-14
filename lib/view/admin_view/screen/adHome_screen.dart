import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msbazaar/res/AppColor.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/utils/another_flushbar.dart';
import 'package:msbazaar/view/admin_view/screen/shop/create_shop.dart';
import 'package:msbazaar/view/admin_view/update/update_screen.dart';
import 'package:msbazaar/view/admin_view/upload/upload_screen.dart';
import 'package:msbazaar/view/admin_view/screen/adAccount_screen.dart';
import 'package:msbazaar/view_model/shop_provider.dart';
import 'package:provider/provider.dart';

class AdHomeScreen extends StatefulWidget {
  const AdHomeScreen({super.key});

  @override
  State<AdHomeScreen> createState() => _AdHomeScreenState();
}

class _AdHomeScreenState extends State<AdHomeScreen> {
  // bool shopExit = false;
  //
  // getShopExist() {
  //   FirebaseFirestore.instance
  //       .collection('shops')
  //       .doc(FirebaseAuth.instance.currentUser?.email)
  //       .get()
  //       .then((value) {
  //     if (mounted) {
  //       if (value.exists) {
  //         setState(() {
  //           shopExit = true;
  //         });
  //       }
  //     }
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ShopProvider initShopProvider = Provider.of(context, listen: false);
    initShopProvider.getShopExist();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.whiteColor,
      statusBarIconBrightness: Brightness.dark,
    ));
    ShopProvider shopProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.waving_hand,
                    color: Colors.yellow,
                    size: 29,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi,',
                          style: CustomTextStyle.greyText,
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser == null
                              ? 'Guest Manager'
                              : FirebaseAuth.instance.currentUser!.displayName
                                  .toString(),
                          style: CustomTextStyle.appBar,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AdAccountScreen()));
                    },
                    child: const SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.person,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 230,
                      mainAxisSpacing: 8),
                  children: shopProvider.shopExit == false
                      ? [
                          custmContainer('Create Shop', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CreateShop()));
                          }),
                        ]
                      : [
                          custmContainer('Upload', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UploadScreen()));
                          }),
                          custmContainer('Update', () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const UpdateScreen()));
                          }),
                          custmContainer('Orders', () {
                            AnotherFlushbar.anotherFlushbar(
                                context, 'Coming Soon');
                          }),
                          custmContainer('Banner-Ads', () {
                            AnotherFlushbar.anotherFlushbar(
                                context, 'Coming Soon');
                          }),
                        ],
                ),
              ),
              // InkWell(
              //   borderRadius: BorderRadius.circular(10),
              //   onTap: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const UpdateShop()));
              //   },
              //   child: Container(
              //     height: 210,
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       border: Border.all(color: Colors.red),
              //     ),
              //     child: const Center(
              //         child: Text(
              //       'Update Shop',
              //       style: TextStyle(
              //           fontSize: 18,
              //           color: Colors.blue,
              //           fontWeight: FontWeight.w500),
              //     )),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget custmContainer(String title, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
            child: Text(title,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.w500))),
      ),
    );
  }
}
