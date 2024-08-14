import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msbazaar/models/shop_model.dart';
import 'package:msbazaar/utils/another_flushbar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../view/admin_view/screen/adHome_screen.dart';

class ShopProvider with ChangeNotifier {
  ShopModel? shopModel;
  String? shopImage;
  var newShopImage;
  TextEditingController shopNameController = TextEditingController();
  TextEditingController deliveryPriceController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  TextEditingController shopItemsController = TextEditingController();

  void createShop(context) {
    if (shopNameController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Shop Name');
    } else if (shopItemsController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Shop Items');
    } else if (deliveryTimeController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Delivery Time');
    } else if (deliveryPriceController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Delivery Price');
    } else if (newShopImage == '' || newShopImage == null) {
      AnotherFlushbar.anotherFlushbar(context, 'Please upload shop image');
    } else {
      FirebaseFirestore.instance
          .collection('shops')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({
        'shopName': shopNameController.text.trim(),
        'deliveryPrice': deliveryPriceController.text.trim(),
        'deliveryTime': deliveryTimeController.text.trim(),
        'items': shopItemsController.text.trim(),
        'shopImage': newShopImage,
      });
      FirebaseFirestore.instance
          .collection('shopsOwner')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('data')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({
        'shopName': shopNameController.text.trim(),
        'deliveryPrice': deliveryPriceController.text.trim(),
        'deliveryTime': deliveryTimeController.text.trim(),
        'items': shopItemsController.text.trim(),
        'shopImage': newShopImage,
      }).then((value) {
        shopNameController.text = '';
        shopItemsController.text = '';
        deliveryTimeController.text = '';
        deliveryPriceController.text = '';
        newShopImage = '';
        shopImage = null;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AdHomeScreen()),
            (Route<dynamic> route) => false);
      });
    }
  }

  void updateShop(context) {
    if (shopNameController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Shop Name');
    } else if (shopItemsController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Shop Items');
    } else if (deliveryTimeController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Delivery Time');
    } else if (deliveryPriceController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Delivery Price');
    } else if (newShopImage == '' || newShopImage == null) {
      AnotherFlushbar.anotherFlushbar(context, 'Please upload shop image');
    } else {
      FirebaseFirestore.instance
          .collection('shops')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'shopName': shopNameController.text.trim(),
        'deliveryPrice': deliveryPriceController.text.trim(),
        'deliveryTime': deliveryTimeController.text.trim(),
        'items': shopItemsController.text.trim(),
        'shopImage': newShopImage,
      });
      FirebaseFirestore.instance
          .collection('shopsOwner')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('data')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({
        'shopName': shopNameController.text.trim(),
        'deliveryPrice': deliveryPriceController.text.trim(),
        'deliveryTime': deliveryTimeController.text.trim(),
        'items': shopItemsController.text.trim(),
        'shopImage': newShopImage,
      }).then((value) {
        shopNameController.text = '';
        shopItemsController.text = '';
        deliveryTimeController.text = '';
        deliveryPriceController.text = '';
        newShopImage = '';
        shopImage = null;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const AdHomeScreen()),
            (Route<dynamic> route) => false);
      });
    }
  }

//upload Image to firebase
  void uploadImage(File file) async {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref =
        FirebaseStorage.instance.ref().child('shopImage').child('$time+jpg');
    await ref.putFile(file);
    newShopImage = await ref.getDownloadURL();
  }

  // Pick image from gallery
  galleryImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? img = await imagePicker.pickImage(source: ImageSource.gallery);
    shopImage = img!.path;
    notifyListeners();
    compressImage(img);
  }

  //Compress Image
  compressImage(XFile img) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
        img.path, targetPath,
        minHeight: 1080, minWidth: 1080, quality: 85);
    notifyListeners();
    uploadImage(File(result!.path));
  }

  // Shop Exist Or Not
  bool shopExit = false;

  getShopExist() {
    FirebaseFirestore.instance
        .collection('shops')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .get()
        .then((value) {
      if (value.exists) {
        shopExit = true;
        notifyListeners();
      }
    });
  }
}
