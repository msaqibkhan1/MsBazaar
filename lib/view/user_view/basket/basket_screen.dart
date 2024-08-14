import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/components/custom_flatButton.dart';
import 'package:msbazaar/res/mediaQuery_size.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/view/user_view/address/address.dart';
import 'package:msbazaar/view/user_view/basket/basket_itemContainer.dart';
import 'package:msbazaar/view_model/viewCart_provider.dart';
import 'package:provider/provider.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {

  String basketShopName = '?';
  @override
  void initState() {
    // TODO: implement initState
    ViewCartProvider initViewCartProvider = Provider.of(context,listen:  false);
    initViewCartProvider.fetchCartData();
    super.initState();
  }
  late ViewCartProvider viewCartProvider;
  @override
  Widget build(BuildContext context) {
    viewCartProvider = Provider.of(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: MqSize.mqHeight(0.057, context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue)),
                  child: Center(
                    child: Text(
                      'Add Items',
                      style: CustomTextStyle.heading1,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: CustmFlatButton(
                title: 'Checkout',
                color: Colors.redAccent,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Address()));
                },
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 8, right: 8),
                child: Row(
                  children: [
                    CustmIconButton(
                        color: Colors.blue,
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        iconData: Icons.arrow_back),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Basket',
                          style: CustomTextStyle.banner,
                        ),
                        Text(
                          basketShopName,
                          style: CustomTextStyle.appBarGrey,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              retrieveBasketData(),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MqSize.mqHeight(0.2, context),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 17.0, top: 0, right: 8, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Payment Summary',
                        style: CustomTextStyle.banner,
                      ),
                      custmRow('Subtotal', 200),
                      custmRow('Delivery fee', 50),
                      custmRow('Service fee', 20),
                      custmRow('Total amount', 270),
                    ],
                  ),
                ),
              ),
              Container(
                height: MqSize.mqHeight(0.2, context),
                color: Colors.white,
                child: const Column(
                  children: [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  retrieveBasketData(){
    return Column(
      children: viewCartProvider.cartList.map((e){
        basketShopName = e.cartShopName;
        return BasketItemContainer(cartModel: e);
      }).toList(),
    );
  }

  Widget custmRow(String title, price) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text('RS $price'),
        ],
      ),
    );
  }
}
