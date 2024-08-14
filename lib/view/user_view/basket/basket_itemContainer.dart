import 'package:flutter/material.dart';
import 'package:msbazaar/models/cart_model.dart';
import 'package:msbazaar/res/components/addTo_cart.dart';
import 'package:msbazaar/res/mediaQuery_size.dart';
import 'package:msbazaar/res/text_style.dart';

class BasketItemContainer extends StatelessWidget {
  final CartModel cartModel;

  const BasketItemContainer({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 5, bottom: 5),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    height: 80,
                    width: 80,
                    child: Image.network(cartModel.cartImage)),
                SizedBox(
                  width: MqSize.mqWidth(0.02, context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      cartModel.cartName,
                      style: CustomTextStyle.heading1,
                    ),
                    Text(
                      cartModel.cartUnit,
                      style: CustomTextStyle.greyText,
                    ),
                    SizedBox(
                      height: 34,
                      child: AddToCart(
                          cartShopName: cartModel.cartShopName,
                          cartId: cartModel.cartId,
                          cartImage: cartModel.cartImage,
                          cartName: cartModel.cartName,
                          cartPrice: cartModel.cartPrice,
                          cartUnit: cartModel.cartUnit,
                          detailScreen: true),
                    )
                  ],
                ),
              ],
            ),
            Text(
              cartModel.cartPrice,
              style: CustomTextStyle.heading1,
            )
          ],
        ),
      ),
    );
  }
}
