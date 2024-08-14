import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/components/custom_flatButton.dart';
import 'package:msbazaar/res/components/payWith_button.dart';
import 'package:msbazaar/res/mediaQuery_size.dart';
import 'package:msbazaar/res/text_style.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Row(
                  children: [
                    CustmIconButton(
                        color: Colors.red,
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        iconData: Icons.arrow_back),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Checkout',
                            style: CustomTextStyle.heading1,
                          ),
                          const Text('Ms khan'),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MqSize.mqHeight(0.04, context),
              ),
              const Row(
                children: [Text('Name: '), Text('Unknown')],
              ),
              const Text('Address: '),
              const Row(
                children: [Text('Mobile: '), Text('3430438394849')],
              ),
              SizedBox(
                height: MqSize.mqHeight(0.01, context),
              ),
              Container(
                height: MqSize.mqHeight(0.06, context),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue)),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '     🛵  20 min',
                      style: CustomTextStyle.heading1,
                    )),
              ),
              SizedBox(
                height: MqSize.mqHeight(0.05, context),
              ),
              Text(
                'Pay with',
                style: CustomTextStyle.banner,
              ),
              const PayWith(
                title: 'Credit Card',
                index: 1,
                image: 'img/card.png',
                imageSize: 0.045,
              ),
              const PayWith(
                title: 'Cash',
                index: 2,
                image: 'img/icon.png',
                imageSize: 0.062,
              ),
              SizedBox(
                height: MqSize.mqHeight(0.06, context),
              ),
              Text(
                'Payment Summary',
                style: CustomTextStyle.banner,
              ),
              custmRow('Subtotal', 150),
              custmRow('Delivery Fee', 60),
              custmRow('Service Fee', 20),
              custmRow('Total Amount', 230),
              custmRow('Pay by Cash', 230),
              const Expanded(child: SizedBox()),
              CustmFlatButton(
                  title: 'Place Order',
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  onTap: () {})
            ],
          ),
        ),
      ),
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
