import 'package:flutter/material.dart';
import 'package:msbazaar/view_model/data_provider.dart';
import 'package:provider/provider.dart';

import '../mediaQuery_size.dart';

class PayWith extends StatefulWidget {
  final int index;
  final String title, image;
  final double imageSize;

  const PayWith(
      {super.key,
      required this.imageSize,
      required this.index,
      required this.image,
      required this.title});

  @override
  State<PayWith> createState() => _PayWithState();
}

class _PayWithState extends State<PayWith> {
  @override
  void initState() {
    // TODO: implement initState
    DataProvider initDataProvider = Provider.of(context, listen: false);
    initDataProvider.selectIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
          dataProvider.indexChanger(widget.index);
        },
        child: Container(
          height: MqSize.mqHeight(0.065, context),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue)),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Row(
              children: [
                dataProvider.selectIndex == widget.index
                    ? const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.done,
                          size: 18,
                          color: Colors.white,
                        ),
                      )
                    : const CircleAvatar(
                        radius: 12,
                      ),
                SizedBox(width: MqSize.mqWidth(0.016, context)),
                SizedBox(
                    height: MqSize.mqHeight(widget.imageSize, context),
                    child: Image.asset(widget.image)),
                SizedBox(
                  width: MqSize.mqWidth(0.028, context),
                ),
                Text(widget.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
