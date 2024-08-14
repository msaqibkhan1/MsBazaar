import 'package:flutter/material.dart';
import 'package:msbazaar/res/components/customIcon_button.dart';
import 'package:msbazaar/res/mediaQuery_size.dart';
import 'package:msbazaar/res/text_style.dart';
import 'package:msbazaar/view/user_view/address/new_address.dart';
import 'package:msbazaar/view/user_view/checkOut_screen.dart';

class Address extends StatelessWidget {
  const Address({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 15, top: 12, bottom: 12),
          child: Column(
            children: [
              Row(
                children: [
                  CustmIconButton(
                      color: Colors.redAccent,
                      iconColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      iconData: Icons.arrow_back),
                  SizedBox(
                    width: MqSize.mqWidth(0.02, context),
                  ),
                  Expanded(
                      child: Text(
                    'Select Address',
                    style: CustomTextStyle.banner,
                  )),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NewAddress()));
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Add New',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w500),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: MqSize.mqHeight(0.03, context),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckOutScreen()));
                },
                child: Container(
                  height: MqSize.mqHeight(0.15, context),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Mskhan dfjkdfjdsk'),
                              Text('Floor,fdjfkd,djdskj'),
                              Text(
                                  'jdjfkdssdjf dkf kdfjdkf kdfjdkf kdf  jkf dfdk fdkf dfjdk jfdkf fdkfdkf df jdkfjs lkdjlklfjdskf kdfjdk dk d fkfdf'),
                              Text('Mobile:'),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Home',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(20),
                              onTap: () {},
                              child: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MqSize.mqHeight(0.02, context),
              ),
              addressContainer(
                  'Mskhan',
                  '034',
                  '6',
                  '45d',
                  'kdjkdkdf kfjd f fkdfjkd dkfjdk kfd fk fk fdkf dkfjd fdjk',
                  '0323249343434',
                  'Apartment',
                  context)
            ],
          ),
        ),
      ),
    );
  }

  Widget addressContainer(String houseName, aptNo, floor, street,
      additionalDirection, mobile, label, context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CheckOutScreen()));
      },
      child: Container(
        height: MqSize.mqHeight(0.15, context),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(houseName),
                    Text(aptNo + ' , ' + floor + ' , ' + street),
                    Text(additionalDirection),
                    Text('Mobile: $mobile'),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                        color: Colors.redAccent, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {},
                    child: const CircleAvatar(
                      radius: 20,
                      child: Icon(
                        Icons.edit,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                    ),
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
