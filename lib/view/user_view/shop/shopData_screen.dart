import 'package:flutter/material.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/utils/getData_widget.dart';
import 'package:msbazaar/view_model/data_provider.dart';
import 'package:provider/provider.dart';

class ShopDataScreen extends StatefulWidget {
  final List<dynamic> shopList;
  final String shopName;

  const ShopDataScreen(
      {super.key, required this.shopList, required this.shopName});

  @override
  State<ShopDataScreen> createState() => _ShopDataScreenState();
}

class _ShopDataScreenState extends State<ShopDataScreen> {
  List filterList = [];
  bool isFilterList = false;
  late DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    dataProvider = Provider.of(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          widget.shopName,
                          style: CustomTextStyle.appBar,
                        ),
                      ),
                      Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 20,
                          ))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      customTabs('All', 0, 'All'),
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
                  return isFilterList == false
                      ? GetDataWidget()
                          .getShopListData(widget.shopList, context)
                      : filterList.isEmpty
                          ? SizedBox(
                              height: 250,
                              child: Center(
                                  child: Text(
                                'No Item Found 😔',
                                style: CustomTextStyle.heading1,
                              )))
                          : GetDataWidget()
                              .getShopListData(filterList, context);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  customTabs(String title, int index, String filterName) {
    return Consumer<DataProvider>(
      builder: (context, value, child) {
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
                for (var i in widget.shopList) {
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
      },
    );
  }
}
