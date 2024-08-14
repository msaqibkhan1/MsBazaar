import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/custom_outlineButton.dart';
import 'package:msbazaar/res/components/shop_container.dart';
import 'package:msbazaar/view/admin_view/update/update_shop.dart';
import 'package:msbazaar/view/admin_view/update/update_value.dart';
import 'package:msbazaar/view_model/data_provider.dart';
import 'package:provider/provider.dart';

import '../../../res/components/customIcon_button.dart';
import '../../../res/components/custom_container.dart';
import '../../../res/text_style.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late DataProvider dataProvider;

  @override
  void initState() {
    // TODO: implement initState
    DataProvider dataProvider = Provider.of(context, listen: false);
    dataProvider.fetchGetData();
    dataProvider.fetchShopOwnerData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dataProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, left: 10, right: 0, bottom: 10),
                  child: Row(
                    children: [
                      CustmIconButton(
                        color: Colors.blue,
                        iconColor: Colors.white,
                        iconData: Icons.arrow_back,
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Update Data',
                        style: CustomTextStyle.appBar,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                getShopData(),
                CustmOutlinedButton(
                    textColor: Colors.black,
                    title: 'Update Shop',
                    borderColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateShop(
                                    shopModel: dataProvider.shopData!,
                                  )));
                    }),
                allData(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget allData() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 10,
          mainAxisExtent: 210,
        ),
        children: dataProvider.getData.map((e) {
          return CustomContainer(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateValue(
                            name: e.name,
                            description: e.description,
                            image: e.image,
                            price: e.price,
                            value: e.unit,
                            id: e.id,
                          )));
            },
            dataModel: e,
          );
        }).toList(),
      ),
    );
  }

  Widget getShopData() {
    return Column(
        children: dataProvider.getShopOwnerData.map((e) {
      dataProvider.shopData = e;
      return ShopContainer(
        shopName: e.shopName,
        deliveryTime: e.deliveryTime,
        items: e.items,
        shopImage: e.shopImage,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdateShop(shopModel: e)));
        },
        deliveryPrice: e.deliveryPrice,
      );
    }).toList());
  }
}
