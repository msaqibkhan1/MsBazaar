import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/components/custom_flatButton.dart';
import 'package:msbazaar/res/mediaQuery_size.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/utils/customTextField.dart';
import 'package:msbazaar/view/user_view/checkOut_screen.dart';
import 'package:msbazaar/view_model/data_provider.dart';
import 'package:provider/provider.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({super.key});

  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  var controller = TextEditingController();
  late DataProvider dataProvider;

  @override
  Widget build(BuildContext context) {
    dataProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustmFlatButton(
            title: 'Save Address',
            color: Colors.redAccent,
            textColor: Colors.white,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CheckOutScreen()));
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 20, top: 10),
                child: Row(
                  children: [
                    CustmIconButton(
                        color: Colors.redAccent,
                        iconColor: Colors.white,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        iconData: Icons.arrow_back),
                    SizedBox(
                      width: MqSize.mqWidth(0.03, context),
                    ),
                    Text(
                      'New Address',
                      style: CustomTextStyle.heading1,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 12),
                child: Row(
                  children: [
                    customButton('Apartment', Icons.apartment, 0),
                    customButton('Home', Icons.home, 1),
                    customButton('Office', Icons.work, 2)
                  ],
                ),
              ),
              dataProvider.selectIndex == 1
                  ? CustmTextField.custmTextField(
                      hintText: 'House',
                      color: Colors.blue,
                      textInputType: TextInputType.text,
                      controller: controller)
                  : CustmTextField.custmTextField(
                      hintText: 'Building Name',
                      color: Colors.blue,
                      textInputType: TextInputType.text,
                      controller: controller),
              dataProvider.selectIndex == 0
                  ? Row(
                      children: [
                        Expanded(
                          child: CustmTextField.custmTextField(
                              hintText: 'Apt. no',
                              color: Colors.blue,
                              textInputType: TextInputType.number,
                              controller: controller),
                        ),
                        Expanded(
                          child: CustmTextField.custmTextField(
                              hintText: 'Floor',
                              color: Colors.blue,
                              textInputType: TextInputType.number,
                              controller: controller),
                        ),
                      ],
                    )
                  : dataProvider.selectIndex == 1
                      ? CustmTextField.custmTextField(
                          hintText: 'Floor (optional)',
                          color: Colors.blue,
                          textInputType: TextInputType.text,
                          controller: controller)
                      : Row(
                          children: [
                            Expanded(
                              child: CustmTextField.custmTextField(
                                  hintText: 'Company',
                                  color: Colors.blue,
                                  textInputType: TextInputType.number,
                                  controller: controller),
                            ),
                            Expanded(
                              child: CustmTextField.custmTextField(
                                  hintText: 'Floor',
                                  color: Colors.blue,
                                  textInputType: TextInputType.number,
                                  controller: controller),
                            ),
                          ],
                        ),
              CustmTextField.custmTextField(
                  hintText: 'Street',
                  color: Colors.blue,
                  textInputType: TextInputType.text,
                  controller: controller),
              CustmTextField.custmTextField(
                  hintText: 'Additional directions (optional)',
                  color: Colors.blue,
                  textInputType: TextInputType.text,
                  controller: controller),
              CustmTextField.custmTextField(
                  hintText: 'Phone number',
                  color: Colors.blue,
                  textInputType: TextInputType.text,
                  controller: controller),
              CustmTextField.custmTextField(
                  hintText: 'Address label (optional)',
                  color: Colors.blue,
                  textInputType: TextInputType.text,
                  controller: controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget customButton(String title, IconData iconData, int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          dataProvider.indexChanger(index);
        },
        child: Container(
          padding:
              const EdgeInsets.only(left: 12, top: 7, bottom: 7, right: 12),
          decoration: BoxDecoration(
            color: dataProvider.selectIndex == index
                ? Colors.redAccent
                : Colors.blueGrey.shade100,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(
                iconData,
                size: 20,
                color: dataProvider.selectIndex == index
                    ? Colors.white
                    : Colors.black,
              ),
              SizedBox(
                width: MqSize.mqWidth(0.005, context),
              ),
              Text(
                title,
                style: TextStyle(
                    color: dataProvider.selectIndex == index
                        ? Colors.white
                        : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
