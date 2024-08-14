import 'package:flutter/material.dart';
import 'package:msbazaar/models/data_model.dart';
import 'package:msbazaar/res/components/addTo_cart.dart';
import '../text_style.dart';

class CustomContainer extends StatefulWidget {
  final DataModel dataModel;
  final VoidCallback onTap;

  const CustomContainer(
      {super.key, required this.onTap, required this.dataModel});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: widget.onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15)),
            height: 210,
            width: 163,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.dataModel.name,
                          style: CustomTextStyle.heading1),
                      Text(
                        widget.dataModel.unit,
                        style: CustomTextStyle.greyText,
                      ),
                      Text(
                        widget.dataModel.price.toString(),
                        style: CustomTextStyle.heading1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40, bottom: 7),
                  child: SizedBox(
                      height: 110,
                      width: 130,
                      child: Image.network(widget.dataModel.image)),
                ),
              ],
            ),
          ),
          AddToCart(
            cartShopName: widget.dataModel.shopName,
            cartId: widget.dataModel.id,
            cartImage: widget.dataModel.image,
            cartName: widget.dataModel.name,
            cartPrice: widget.dataModel.price,
            cartUnit: widget.dataModel.unit,
            detailScreen: false,
          ),
        ],
      ),
    );
  }
}
