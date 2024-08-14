import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/shop_container.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/view/user_view/shop/shopData_screen.dart';
import 'package:msbazaar/view_model/data_provider.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  late DataProvider dataProvider;
  String isSearch = '';
  List searchList = [];
  List shopList = [];

  @override
  Widget build(BuildContext context) {
    dataProvider = Provider.of(context);
    dataProvider.fetchShopData();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 25, bottom: 15),
                child: Text(
                  'Shops',
                  style: CustomTextStyle.appBar,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, bottom: 15, right: 25, left: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12, top: 5),
                        child: Icon(Icons.search),
                      ),
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              searchList.clear();
                              isSearch = value;
                              if (isSearch != '') {
                                for (var i in dataProvider.getShopData) {
                                  if (i.shopName
                                      .toLowerCase()
                                      .contains(value.trim().toLowerCase())) {
                                    searchList.add(i);
                                  }
                                }
                              }
                            });
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: 'Restaurants,Shop'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12, top: 5),
                        child: Icon(Icons.swap_calls),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: isSearch == ''
                    ? getShopsData(dataProvider.getShopData)
                    : getShopsData(searchList),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getShopsData(List<dynamic> dataList) {
    return Column(
      children: dataList.map((e) {
        return ShopContainer(
          shopName: e.shopName,
          deliveryTime: e.deliveryTime,
          items: e.items,
          shopImage: e.shopImage,
          deliveryPrice: e.deliveryPrice,
          onTap: () {
            shopList.clear();
            for (var i in dataProvider.getData) {
              if (i.shopName.toLowerCase().contains(e.shopName.toLowerCase())) {
                shopList.add(i);
              }
            }
            setState(() {});
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ShopDataScreen(
                          shopList: shopList,
                          shopName: e.shopName,
                        )));
          },
        );
      }).toList(),
    );
  }
}
