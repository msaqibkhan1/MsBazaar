import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/components/custom_outlineButton.dart';
import 'package:msbazaar/utils/customTextField.dart';
import 'package:msbazaar/view_model/upload_provider.dart';
import 'package:provider/provider.dart';
import '../../../res/text_style.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late UploadProvider uploadProvider;
  ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    uploadProvider = Provider.of(context);
    return Scaffold(
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
                        'Upload Data',
                        style: CustomTextStyle.appBar,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                CustmTextField.custmTextField(
                    hintText: 'Name',
                    color: Colors.blue,
                    textInputType: TextInputType.text,
                    controller: uploadProvider.nameController),
                CustmTextField.custmTextField(
                    hintText: 'Price',
                    color: Colors.red,
                    textInputType: TextInputType.number,
                    controller: uploadProvider.priceController),
                CustmTextField.custmTextField(
                    hintText: 'Value',
                    color: Colors.blue,
                    textInputType: TextInputType.text,
                    controller: uploadProvider.unitController),
                CustmTextField.custmTextField(
                    hintText: 'description',
                    color: Colors.red,
                    textInputType: TextInputType.text,
                    controller: uploadProvider.descriptionController),
                // custmTextField('ShopName', Colors.blue),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 18.0),
                      child: Row(
                        children: [
                          Text('Category'),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      uploadProvider.galleryImage();
                    },
                    child: Container(
                        height: 240,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                        child: uploadProvider.image == null
                            ? const Center(
                                child: Icon(
                                Icons.add,
                                color: Colors.red,
                                size: 35,
                              ))
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(File(uploadProvider.image!)),
                              )),
                  ),
                ),
                CustmOutlinedButton(
                    textColor:Colors.black,
                    title: uploadProvider.isUploading == true
                        ? 'Uploading'
                        : 'Upload',
                    borderColor: Colors.blue,
                    onTap: () {
                      uploadProvider.uploadData(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
