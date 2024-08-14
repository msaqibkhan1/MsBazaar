import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msbazaar/utils/another_flushbar.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class UploadProvider with ChangeNotifier {
  bool isUploading = false;
  String? image;
  var newImage;

  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var unitController = TextEditingController();
  var descriptionController = TextEditingController();

  //Upload

  void uploadData(context) {
    if (nameController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Name');
    } else if (priceController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Price');
    } else if (unitController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Unit');
    } else if (descriptionController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Description');
    } else if (newImage == '' || newImage == null) {
      AnotherFlushbar.anotherFlushbar(context, 'Please Upload an Image');
    } else {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      FirebaseFirestore.instance.collection('fruits').doc(time).set({
        'id': time,
        'name': nameController.text.trim(),
        'price': priceController.text.trim(),
        'category': 'fruits',
        'shopName': 'Ms khan',
        'description': descriptionController.text.trim(),
        'unit': unitController.text.trim(),
        'favorite': false,
        'image': newImage,
      }).then((value) {
        nameController.text = '';
        priceController.text = '';
        descriptionController.text = '';
        unitController.text = '';
        newImage = '';
        image = null;
        notifyListeners();
        Navigator.pop(context);
      });
    }
  }

//Uploading image
  void uploadImage(File file) async {
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    final ref =
        FirebaseStorage.instance.ref().child('objectImages').child('$time+jpg');
    await ref.putFile(file);
    newImage = await ref.getDownloadURL();
  }

  //Selecting Image
  void galleryImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? img = await imagePicker.pickImage(source: ImageSource.gallery);
    image = img!.path;
    notifyListeners();
    compressImage(img);
  }

  //compressing image
  compressImage(XFile img) async {
    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';
    final result = await FlutterImageCompress.compressAndGetFile(
        img.path, targetPath,
        minHeight: 1080, minWidth: 1080, quality: 85);
    notifyListeners();
    uploadImage(File(result!.path));
  }

  // Update
  updateValue(context, String id) {
    if (nameController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Name');
    } else if (priceController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Price');
    } else if (unitController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Unit');
    } else if (descriptionController.text.trim() == '') {
      AnotherFlushbar.anotherFlushbar(context, 'Please enter Description');
    } else if (newImage == '' || newImage == null) {
      AnotherFlushbar.anotherFlushbar(context, 'Please Upload an Image');
    } else {
      FirebaseFirestore.instance.collection('fruits').doc(id).update({
        'name': nameController.text.trim(),
        'price': priceController.text.trim(),
        'category': 'fruits',
        'shopName': 'Ms khan',
        'description': descriptionController.text.trim(),
        'unit': unitController.text.trim(),
        'favorite': false,
        'image': newImage,
      }).then((value) {
        nameController.text = '';
        priceController.text = '';
        descriptionController.text = '';
        unitController.text = '';
        newImage = '';
        image = null;
        notifyListeners();
        Navigator.pop(context);
      });
    }
  }
}
