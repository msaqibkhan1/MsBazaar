import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:msbazaar/models/cart_model.dart';

class ViewCartProvider with ChangeNotifier {
  addToCartData({required String cartShopName, cartPrice,cartImage,cartUnit,cartName,cartId,required int quantityCount}) {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('yourCart')
        .doc(cartId)
        .set({
      'cartId': cartId,
      'cartName': cartName,
      'cartPrice': cartPrice,
      'cartUnit': cartUnit,
      'cartShopName': cartShopName,
      'cartImage': cartImage,
      'count': quantityCount,
      'isAdd':true,
    });
  }

  //Update Cart
  updateCartData({required String cartId,required int quantityCount}) {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('yourCart')
        .doc(cartId)
        .update({
      // 'cartId': dataModel.id,
      // 'cartName': dataModel.name,
      // 'cartPrice': dataModel.price,
      // 'cartUnit': dataModel.unit,
      // 'cartShopName': dataModel.shopName,
      // 'cartImage': dataModel.image,
       'count':quantityCount,
     // 'isAdd':true,
    });
  }

  //Cart Item Exist or Not
  // existCartData({required DataModel dataModel}) {
  //   FirebaseFirestore.instance
  //       .collection('cart')
  //       .doc('mskhan')
  //       .collection('yourCart')
  //       .doc(dataModel.id)
  //       .get()
  //       .then((value) {
  //     if (value.exists) {
  //       isCartTrue = value.get(
  //         'isAdd'
  //       );
  //       notifyListeners();
  //     } else {
  //       isCartTrue = false;
  //       notifyListeners();
  //     }
  //   });
  // }

  // Fetch Cart Data
  List<CartModel> cartList = [];

  fetchCartData() async {
    List<CartModel> newCartList = [];
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('yourCart')
        .get();
    for (var i in data.docs) {
      CartModel cartModel = CartModel(
          cartId: i.get('cartId'),
          cartImage: i.get('cartImage'),
          cartName: i.get('cartName'),
          cartPrice: i.get('cartPrice'),
          cartShopName: i.get('cartShopName'),
          cartUnit: i.get('cartUnit'), count: i.get('count'));
      newCartList.add(cartModel);
    }
    cartList = newCartList;
    notifyListeners();
  }

  List<CartModel> get getCartData {
    return cartList;
  }

  //Cart item Delete
  deleteCartItem(cartId) {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('yourCart')
        .doc(cartId)
        .delete();
    notifyListeners();
  }

  //Cart Delete After Order
  deleteCart() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('yourCart')
        .doc()
        .delete();
  }
}
