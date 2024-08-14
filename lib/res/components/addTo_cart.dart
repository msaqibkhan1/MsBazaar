import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msbazaar/view/user_view/authentication.dart';
import 'package:provider/provider.dart';

import '../../view_model/viewCart_provider.dart';

class AddToCart extends StatefulWidget {
  final String cartName, cartImage, cartId, cartPrice, cartShopName, cartUnit;
  final bool detailScreen;

  const AddToCart({
    super.key,
    required this.cartShopName,
    required this.cartPrice,
    required this.cartImage,
    required this.cartUnit,
    required this.cartName,
    required this.cartId,
    required this.detailScreen,
  });

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  void initState() {
    // TODO: implement initState
    existCartData();
    super.initState();
  }

  bool isCartTrue = false;
  int count = 1;

  existCartData() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('yourCart')
        .doc(widget.cartId)
        .get()
        .then((value) => {
              if (mounted)
                {
                  if (value.exists)
                    {
                      isCartTrue = value.get('isAdd'),
                      count = value.get('count'),
                      setState(() {}),
                    }
                  else
                    {
                      isCartTrue = false,
                      setState(() {}),
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    ViewCartProvider viewCartProvider = Provider.of(context);
    return isCartTrue == false
        ? widget.detailScreen == true
            ? InkWell(
                onTap: () {
                  if (FirebaseAuth.instance.currentUser?.email == null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AuthenticationScreen()));
                  } else {
                    isCartTrue = true;
                    viewCartProvider.addToCartData(
                        quantityCount: count,
                        cartShopName: widget.cartShopName,
                        cartId: widget.cartId,
                        cartImage: widget.cartImage,
                        cartName: widget.cartName,
                        cartPrice: widget.cartPrice,
                        cartUnit: widget.cartUnit);
                    setState(() {});
                  }
                },
                child: Container(
                  height: 45,
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add To Cart',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.shopping_cart_outlined,
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Positioned(
                left: 115,
                top: 140,
                child: InkWell(
                  onTap: () {
                    if (FirebaseAuth.instance.currentUser?.email == null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AuthenticationScreen()));
                    } else {
                      isCartTrue = true;
                      viewCartProvider.addToCartData(
                          quantityCount: count,
                          cartShopName: widget.cartShopName,
                          cartId: widget.cartId,
                          cartImage: widget.cartImage,
                          cartName: widget.cartName,
                          cartPrice: widget.cartPrice,
                          cartUnit: widget.cartUnit);
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    height: 40,
                    width: 50,
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ),
              )
        : widget.detailScreen == true
            ? Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        setState(() {
                          if (count > 1) {
                            count--;
                            viewCartProvider.updateCartData(
                                quantityCount: count, cartId: widget.cartId);
                          } else {
                            viewCartProvider.deleteCartItem(widget.cartId);
                            setState(() {
                              isCartTrue = false;
                            });
                          }
                        });
                      },
                      child: SizedBox(
                        height: 40,
                        width: 45,
                        child: Center(
                          child: count == 1
                              ? const Icon(Icons.delete)
                              : const Text(
                                  '-',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                        ),
                      ),
                    ),
                    Text(
                      count.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        setState(() {
                          count++;
                        });
                        viewCartProvider.updateCartData(
                            cartId: widget.cartId, quantityCount: count);
                      },
                      child: const SizedBox(
                        height: 40,
                        width: 45,
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Positioned(
                left: 0,
                top: 168,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          setState(() {
                            if (count > 1) {
                              count--;
                              viewCartProvider.updateCartData(
                                  quantityCount: count, cartId: widget.cartId);
                            } else {
                              viewCartProvider.deleteCartItem(widget.cartId);
                              setState(() {
                                isCartTrue = false;
                              });
                            }
                          });
                        },
                        child: SizedBox(
                          height: 40,
                          width: 45,
                          child: Center(
                            child: count == 1
                                ? const Icon(Icons.delete)
                                : const Text(
                                    '-',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  ),
                          ),
                        ),
                      ),
                      Text(
                        count.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          setState(() {
                            count++;
                          });
                          viewCartProvider.updateCartData(
                              cartId: widget.cartId, quantityCount: count);
                        },
                        child: const SizedBox(
                          height: 40,
                          width: 45,
                          child: Center(
                            child: Text(
                              '+',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}
