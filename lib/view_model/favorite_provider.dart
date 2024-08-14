import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msbazaar/models/data_model.dart';

class FavoriteProvider with ChangeNotifier {

  bool favorite = false;

  setFavorite() {
    favorite = !favorite;
    notifyListeners();
  }

  addToFavorite(DataModel dataModel) {
    FirebaseFirestore.instance
        .collection('favorite')
        .doc('mskhan')
        .collection('favorite_Data')
        .doc(dataModel.id)
        .set({
      'id': dataModel.id,
      'name': dataModel.name,
      'price': dataModel.price,
      'category': dataModel.category,
      'shopName': dataModel.shopName,
      'description': dataModel.description,
      'unit': dataModel.unit,
      'favorite': true,
      'image': dataModel.image,
    });
  }

  favoriteDataExist(DataModel dataModel) {
    FirebaseFirestore.instance.collection('favorite').doc('mskhan')
        .collection('favorite_Data').doc(dataModel.id).get()
        .then((value) {
      if (value.exists){
        favorite = value.get('favorite');
        notifyListeners();
      }
      else{
        favorite = false;
        notifyListeners();
      }
    });
  }

  removeFavoriteData(DataModel dataModel){
    FirebaseFirestore.instance.collection('favorite').doc('mskhan')
        .collection('favorite_Data').doc(dataModel.id).delete();
  }
}
