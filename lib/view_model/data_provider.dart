import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:msbazaar/models/data_model.dart';
import 'package:msbazaar/models/shop_model.dart';

class DataProvider with ChangeNotifier {
  DataModel? dataModel;
  ShopModel? shopModel;
  ShopModel? shopData;

  //data retrieve
  List<DataModel> newDataList = [];

  fetchGetData() async {
    List<DataModel> dataList = [];
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('fruits').get();
    for (var element in data.docs) {
      dataModel = DataModel(
          name: element.get('name'),
          unit: element.get('unit'),
          price: element.get('price'),
          image: element.get('image'),
          favorite: element.get('favorite'),
          category: element.get('category'),
          description: element.get('description'),
          shopName: element.get('shopName'),
          id: element.get('id'));
      dataList.add(dataModel!);
    }
    newDataList = dataList;
    notifyListeners();
  }

  //data get
  List<DataModel> get getData {
    return newDataList;
  }

  // Shop Data
  List<ShopModel> newShopDataList = [];

  fetchShopData() async {
    List<ShopModel> shopDataList = [];
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('shops').get();

    for (var e in data.docs) {
      shopModel = ShopModel(
          deliveryTime: e.get('deliveryTime'),
          items: e.get('items'),
          shopName: e.get('shopName'),
          shopImage: e.get('shopImage'),
          deliveryPrice: e.get('deliveryPrice'));
      shopDataList.add(shopModel!);
    }
    newShopDataList = shopDataList;
    notifyListeners();
  }

  List<ShopModel> get getShopData {
    return newShopDataList;
  }

  //OwnerShop
  List<ShopModel> shopDataList = [];

  fetchShopOwnerData() async {
    List<ShopModel> newShopDataList = [];
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('shopsOwner')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('data')
        .get();

    for (var e in data.docs) {
      shopModel = ShopModel(
        deliveryTime: e.get('deliveryTime'),
        items: e.get('items'),
        shopName: e.get('shopName'),
        shopImage: e.get('shopImage'),
        deliveryPrice: e.get('deliveryPrice'),
      );
      newShopDataList.add(shopModel!);
    }
    shopDataList = newShopDataList;
    notifyListeners();
  }

  List<ShopModel> get getShopOwnerData {
    return shopDataList;
  }

  // TabBar Index Change
  int selectIndex = 0;

  indexChanger(int index) {
    selectIndex = index;
    notifyListeners();
  }

  //Search value assign
  String isSearch = '';

  setSearchValue(String value) {
    isSearch = value;
    notifyListeners();
  }

  //Set Greeting
  DateTime time = DateTime.now();

  setGreeting() {
    time = DateTime.now();
    Timer.periodic(const Duration(seconds: 5), (Timer t) => notifyListeners());
    return time.hour >= 5 && time.hour < 12
        ? 'Good Morning'
        : time.hour >= 12 && time.hour < 18
            ? 'Good Afternoon'
            : time.hour >= 18
                ? 'Good Evening'
                : 'Good Evening';
  }
}
