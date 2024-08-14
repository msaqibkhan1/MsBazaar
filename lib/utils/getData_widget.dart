import 'package:flutter/material.dart';
import '../res/components/custom_container.dart';
import '../view/user_view/detail_screen.dart';

class GetDataWidget {
  Widget getShopListData(List<dynamic> listName, BuildContext context) {
    return GridView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 10,
          mainAxisExtent: 210,
        ),
        children: listName.map((e) {
          return CustomContainer(
            onTap: () {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(dataModel: e)));
            },
            dataModel: e,
          );
        }).toList());
  }
}
