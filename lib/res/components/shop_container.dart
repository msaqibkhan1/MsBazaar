import 'package:flutter/material.dart';
import 'package:msbazaar/res/AppColor.dart';
import 'package:msbazaar/res/text_style.dart';

class ShopContainer extends StatefulWidget {
  final String shopName, deliveryTime, items, shopImage, deliveryPrice;
  final VoidCallback onTap;

  const ShopContainer(
      {super.key,
      required this.shopName,
      required this.deliveryTime,
      required this.items,
      required this.shopImage,
      required this.deliveryPrice,
      required this.onTap});

  @override
  State<ShopContainer> createState() => _ShopContainerState();
}

class _ShopContainerState extends State<ShopContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 20, top: 5, bottom: 5),
        child: SizedBox(
          height: 110,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  //color: const Color(0xffe5e5e5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.shopImage,
                      fit: BoxFit.cover,
                      height: 90,
                      width: 90,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    widget.shopName,
                    style: CustomTextStyle.heading1,
                  ),
                  Text(
                    widget.items,
                    style: TextStyle(color: AppColor.greyColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  const Text('⭐ 4.5(100+)', style: TextStyle(fontSize: 13)),
                  Row(
                    children: [
                      Text('🕓 Within ${widget.deliveryTime} mins',
                          style: const TextStyle(fontSize: 12)),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        '🛵 ',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text('${widget.deliveryPrice}-Rs Delivery',
                          style: const TextStyle(fontSize: 11))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
