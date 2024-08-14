import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:msbazaar/models/data_model.dart';
import 'package:msbazaar/res/components/addTo_cart.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/view/user_view/basket/basket_screen.dart';
import 'package:msbazaar/view_model/favorite_provider.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final DataModel dataModel;

  const DetailScreen({super.key, required this.dataModel});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FavoriteProvider initFavoriteProvider = Provider.of(context, listen: false);
    initFavoriteProvider.favoriteDataExist(widget.dataModel);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.grey.shade300,
        statusBarIconBrightness: Brightness.dark));
    FavoriteProvider favoriteProvider = Provider.of(context);
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Rs.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    widget.dataModel.price,
                    style: CustomTextStyle.heading1,
                  ),
                ],
              ),
              AddToCart(
                detailScreen: true,
                cartShopName: widget.dataModel.shopName,
                cartPrice: widget.dataModel.price,
                cartImage: widget.dataModel.image,
                cartUnit: widget.dataModel.unit,
                cartName: widget.dataModel.name,
                cartId: widget.dataModel.id,
              ),
              // Container(
              //   height: 45,
              //   width: 140,
              //   decoration: BoxDecoration(
              //       color: Colors.red, borderRadius: BorderRadius.circular(10)),
              //   child: const Padding(
              //     padding: EdgeInsets.all(8.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text(
              //           'Add To Cart',
              //           style: TextStyle(
              //               color: Colors.white, fontWeight: FontWeight.bold),
              //         ),
              //         Icon(
              //           Icons.shopping_cart_outlined,
              //           size: 20,
              //           color: Colors.white,
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(50)),
                        height: 400,
                        child: Center(
                          child: Image.network(
                            widget.dataModel.image,
                            height: 250,
                            width: 400,
                          ),
                        )),
                    Positioned(
                      left: 25,
                      top: 65,
                      child: CustmIconButton(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        iconColor: Colors.red,
                        color: Colors.white,
                        iconData: Icons.arrow_back,
                      ),
                    ),
                    Positioned(
                      left: 285,
                      top: 65,
                      child: CustmIconButton(
                        onTap: () {
                          favoriteProvider.setFavorite();
                          if (favoriteProvider.favorite == true) {
                            favoriteProvider.addToFavorite(widget.dataModel);
                          } else {
                            favoriteProvider
                                .removeFavoriteData(widget.dataModel);
                          }
                        },
                        iconColor: Colors.red,
                        color: Colors.white,
                        iconData: favoriteProvider.favorite == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                    ),
                    Positioned(
                      left: 335,
                      top: 65,
                      child: CustmIconButton(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BasketScreen()));
                        },
                        iconColor: Colors.red,
                        color: Colors.white,
                        iconData: Icons.shopping_cart_outlined,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25, top: 25, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.dataModel.name,
                            style: const TextStyle(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            widget.dataModel.unit,
                            style: CustomTextStyle.greyText,
                          ),
                          Text(
                            widget.dataModel.price,
                            style: CustomTextStyle.heading1,
                          ),
                        ],
                      ),
                      const Text('@ @ @ @ @ @'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, top: 0, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Description',
                        style: CustomTextStyle.heading1,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      SizedBox(
                        height: 200,
                        child: Text(
                          widget.dataModel.description,
                          style: CustomTextStyle.greyText,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Owner',
                          style: CustomTextStyle.heading1,
                        ),
                      ),
                      Center(
                        child: Text(
                          widget.dataModel.shopName,
                          style: CustomTextStyle.greyText,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Row(
//   children: [
//     Container(
//       height: 30,
//       width: 30,
//       decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(30)),
//       child: const Center(
//         child: Text(
//           '-',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     ),
//     const Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Text(
//         '2 kg',
//         style: TextStyle(
//             fontSize: 14, fontWeight: FontWeight.bold),
//       ),
//     ),
//     Container(
//       height: 30,
//       width: 30,
//       decoration: BoxDecoration(
//           color: Colors.red,
//           borderRadius: BorderRadius.circular(30)),
//       child: const Center(
//         child: Text(
//           '+',
//           style: TextStyle(fontSize: 24),
//         ),
//       ),
//     )
//   ],
// )
