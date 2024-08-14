import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msbazaar/models/shop_model.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/components/custom_outlineButton.dart';
import 'package:msbazaar/view_model/shop_provider.dart';
import 'package:provider/provider.dart';
import '../../../res/text_style.dart';
import '../../../utils/customTextField.dart';

class UpdateShop extends StatefulWidget {
  final ShopModel shopModel;

  const UpdateShop({super.key, required this.shopModel});

  @override
  State<UpdateShop> createState() => _UpdateShopState();
}

class _UpdateShopState extends State<UpdateShop> {
  late ShopProvider shopProvider;
  ImagePicker imagePicker = ImagePicker();
  String? shopImage;

  @override
  void initState() {
    // TODO: implement initState
    ShopProvider initShopProvider = Provider.of(context, listen: false);
    initShopProvider.shopImage = null;
    shopImage = widget.shopModel.shopImage;
    initShopProvider.shopNameController.text = widget.shopModel.shopName;
    initShopProvider.shopItemsController.text = widget.shopModel.items;
    initShopProvider.deliveryPriceController.text =
        widget.shopModel.deliveryPrice;
    initShopProvider.deliveryTimeController.text =
        widget.shopModel.deliveryTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    shopProvider = Provider.of(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: CustmOutlinedButton(
            textColor:Colors.black,
            title: 'Update',
            borderColor: Colors.blue,
            onTap: () {
              if (shopProvider.shopImage == null) {
                setState(() {
                  shopProvider.newShopImage = shopImage;
                });
              }
              shopProvider.updateShop(context);
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
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
                        'Update Shop',
                        style: CustomTextStyle.appBar,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustmTextField.custmTextField(
                    hintText: 'Shop Name',
                    color: Colors.blue,
                    textInputType: TextInputType.text,
                    controller: shopProvider.shopNameController),
                CustmTextField.custmTextField(
                    hintText: 'Items',
                    color: Colors.red,
                    textInputType: TextInputType.text,
                    controller: shopProvider.shopItemsController),
                CustmTextField.custmTextField(
                    color: Colors.blue,
                    textInputType: TextInputType.number,
                    controller: shopProvider.deliveryTimeController,
                    hintText: 'Delivery Time'),
                CustmTextField.custmTextField(
                    hintText: 'Delivery Price',
                    color: Colors.red,
                    textInputType: TextInputType.number,
                    controller: shopProvider.deliveryPriceController),
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
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(shopImage!),
                              )
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
