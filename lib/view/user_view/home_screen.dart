import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/view/user_view/basket/basket_screen.dart';
import 'package:msbazaar/view_model/data_provider.dart';
import 'package:provider/provider.dart';

import '../../utils/getData_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DataProvider dataProvider;

  List filterList = [];
  bool isFilterList = false;
  List searchList = [];

  @override
  void initState() {
    // TODO: implement initState
    DataProvider initDataProvider = Provider.of(context, listen: false);
    initDataProvider.fetchGetData();
    initDataProvider.selectIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    dataProvider = Provider.of<DataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: 10.0, left: 5, bottom: 15),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.waving_hand,
                        color: Colors.yellow,
                        size: 29,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                return Text(
                                  value.setGreeting(),
                                  style: CustomTextStyle.appBarGrey,
                                );
                              }),
                              Text(
                                'Ms khan',
                                style: CustomTextStyle.appBar,
                              ),
                            ],
                          ),
                        ),
                      ),
                      FirebaseAuth.instance.currentUser?.email !=null ?
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BasketScreen()));
                        },
                        child: const Icon(
                          Icons.shopping_cart_outlined,
                          color: Colors.red,
                        ),
                      ):
                      InkWell(
                        onTap: () {
                        },
                        child: const Icon(
                          Icons.notifications_active,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 12.0, right: 12, top: 5),
                          child: Icon(Icons.search),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) {
                              searchList.clear();
                              dataProvider.setSearchValue(value);
                              if (isFilterList == true) {
                                for (var i in filterList) {
                                  if (i.name
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase())) {
                                    searchList.add(i);
                                  }
                                }
                              } else {
                                if (dataProvider.isSearch != '') {
                                  for (var i in dataProvider.getData) {
                                    if (i.name
                                        .toLowerCase()
                                        .contains(value.trim().toLowerCase())) {
                                      searchList.add(i);
                                    }
                                  }
                                }
                              }
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: 'Restaurants, foods, drinks'),
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 12.0, right: 12, top: 5),
                          child: Icon(Icons.swap_calls),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      customTabs(
                        'All',
                        0,
                        'All',
                      ),
                      customTabs('Fruits', 1, 'fruits'),
                      customTabs('Vegetable', 2, 'vegetable'),
                      customTabs('Bakery', 3, 'bakery'),
                      customTabs('Fast-food', 4, 'fast-food'),
                      customTabs('Drinks', 5, 'drinks'),
                      customTabs('Medicine', 6, 'medicine'),
                    ],
                  ),
                ),
                Consumer<DataProvider>(builder: (context, value, child) {
                  return value.isSearch == ''
                      ? isFilterList == false
                          ? Column(
                              children: [
                                banner(),
                                GetDataWidget()
                                    .getShopListData(value.getData, context),
                              ],
                            )
                          : filterList.isEmpty
                              ? SizedBox(
                                  height: 250,
                                  child: Center(
                                      child: Text(
                                    'No Item Found 😔',
                                    style: CustomTextStyle.heading1,
                                  )))
                              : GetDataWidget()
                                  .getShopListData(filterList, context)
                      : GetDataWidget().getShopListData(searchList, context);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  // int selectedIndex = 0;

  customTabs(String title, int index, String filterName) {
    return Consumer<DataProvider>(builder: (context, value, child) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 5.0, right: 10, bottom: 20, top: 10),
        child: InkWell(
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            filterList.clear();
            value.indexChanger(index);
            if (value.selectIndex == 0) {
              isFilterList = false;
            } else {
              isFilterList = true;
              for (var i in dataProvider.getData) {
                if (i.category
                    .toLowerCase()
                    .contains(filterName.trim().toLowerCase())) {
                  filterList.add(i);
                }
              }
            }
          },
          child: Padding(
            padding:
                const EdgeInsets.only(top: 2.0, right: 2, bottom: 2, left: 2),
            child: value.selectIndex == index
                ? Column(
                    children: [
                      Center(
                          child: Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      )),
                      Container(
                        height: 2.5,
                        width: 25.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ),
      );
    });
  }

  Widget banner() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
      child: Stack(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 180,
              width: 235,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Colors.black),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    topRight: Radius.circular(10)),
                child: Image.network(
                  'https://i.pinimg.com/736x/ce/25/65/ce2565b0eb5ef8dcbcf11d0ee1024de3.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 180,
              width: 175,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(80)),
                  color: Color(0xffe5e5e5)),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, left: 16, right: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ms khan',
                      style: CustomTextStyle.italicBanner,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Khan',
                      style: CustomTextStyle.banner,
                    ),
                    const Text(
                      'its me Ms khan',
                    ),
                    const Text(
                      'its me Ms khan',
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    Center(
                        child: Text(
                      'its me Ms khan',
                      style: CustomTextStyle.heading1,
                    )),
                  ],
                ),
              ),
              // child: ClipRRect(
              //     b orderRadius: const BorderRadius.only(
              //         bottomLeft: Radius.circular(10),
              //         topLeft: Radius.circular(10),
              //         topRight: Radius.circular(80)),
              //     child: Image.network(
              //       'https://resize.indiatvnews.com/en/resize/newbucket/1200_-/2023/06/nature-1686808887.jpg',
              //       fit: BoxFit.cover,
              //     )),
            ),
          )
        ],
      ),
    );
  }
}
