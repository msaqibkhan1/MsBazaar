import 'dart:io';
import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/components/custom_outlineButton.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/utils/customTextField.dart';
import 'package:msbazaar/view_model/shop_provider.dart';
import 'package:provider/provider.dart';

class CreateShop extends StatefulWidget {
  const CreateShop({super.key});

  @override
  State<CreateShop> createState() => _CreateShopState();
}

class _CreateShopState extends State<CreateShop> {
  late ShopProvider shopProvider;

  @override
  Widget build(BuildContext context) {
    shopProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18),
          child: CustmOutlinedButton(
            textColor:Colors.black,
            title: 'Create Shop',
            borderColor: Colors.blue,
            onTap: () {
              shopProvider.createShop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, bottom: 20),
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
                        width: 20,
                      ),
                      Text(
                        'Create Shop',
                        style: CustomTextStyle.appBar,
                      ),
                    ],
                  ),
                ),
                CustmTextField.custmTextField(
                    hintText: 'ShopName',
                    color: Colors.red,
                    textInputType: TextInputType.text,
                    controller: shopProvider.shopNameController),
                CustmTextField.custmTextField(
                    hintText: 'ShopItems',
                    color: Colors.blue,
                    textInputType: TextInputType.text,
                    controller: shopProvider.shopItemsController),
                CustmTextField.custmTextField(
                    hintText: 'ShopDeliveryPrice',
                    color: Colors.red,
                    textInputType: TextInputType.text,
                    controller: shopProvider.deliveryPriceController),
                CustmTextField.custmTextField(
                    hintText: 'ShopDeliveryTime',
                    color: Colors.blue,
                    textInputType: TextInputType.text,
                    controller: shopProvider.deliveryTimeController),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      shopProvider.galleryImage();
                    },
                    child: Container(
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                        child: shopProvider.shopImage == null
                            ? const Center(
                                child: Icon(
                                Icons.add,
                                color: Colors.red,
                                size: 35,
                              ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    Image.file(File(shopProvider.shopImage!)),
                              )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
