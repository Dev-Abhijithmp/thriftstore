import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thriftstore/widgets.dart';

import '../add/add_data.dart';
import 'ordersucces.dart';

class Payment extends StatefulWidget {
  late final String uid;
  late final List<String> itemids;
  late final List<String> urls;
  late final List<String> sizes;
  late final int totalamount;
  late final List<Map<String, dynamic>> priceandcount;
  late final List<String> mainids;
  Payment(
      {Key? key,
      required this.uid,
      required this.itemids,
      required this.priceandcount,
      required this.sizes,
      required this.totalamount,
      required this.urls,
      required this.mainids})
      : super(key: key);

  @override
  _PaymentState createState() => _PaymentState(
      uid: uid,
      itemids: itemids,
      urls: urls,
      sizes: sizes,
      totalamount: totalamount,
      priceandcount: priceandcount,
      mainids: mainids);
}

String? _month;
String? _year;
TextEditingController _cardNumberController = TextEditingController();
TextEditingController _cvvcontroller = TextEditingController();

class _PaymentState extends State<Payment> {
  late final String uid;
  late final List<String> itemids;
  late final List<String> urls;
  late final List<String> sizes;
  late final int totalamount;
  late final List<Map<String, dynamic>> priceandcount;
  late final List<String> mainids;
  _PaymentState(
      {required this.uid,
      required this.itemids,
      required this.priceandcount,
      required this.sizes,
      required this.totalamount,
      required this.urls,
      required this.mainids});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        backgroundColor: mainColor,
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.30,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: mainColor.withOpacity(0.7),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    hintText: 'Card Number',
                    hintStyle: TextStyle(
                      color: Colors.blue.shade400,
                    ),
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 16,
                ),
                Row(
                  children: [
                    DropdownButton<String>(
                      items: [
                        const DropdownMenuItem<String>(
                          child: Text("01"),
                          value: "01",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("02"),
                          value: "02",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("03"),
                          value: "03",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("04"),
                          value: "04",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("05"),
                          value: "05",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("06"),
                          value: "06",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("07"),
                          value: "07",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("08"),
                          value: "08",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("09"),
                          value: "09",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("10"),
                          value: "10",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("11"),
                          value: "11",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("12"),
                          value: "12",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _month = value!;
                        });
                      },
                      hint: const Text("Select month"),
                      value: _month,
                    ),
                    DropdownButton<String>(
                      items: [
                        const DropdownMenuItem<String>(
                          child: Text("22"),
                          value: "22",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("23"),
                          value: "23",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("24"),
                          value: "24",
                        ),
                        const DropdownMenuItem<String>(
                          child: Text("25"),
                          value: "25",
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _year = value!;
                        });
                      },
                      hint: const Text("Select year"),
                      value: _year,
                    ),
                  ],
                ),
                TextField(
                  controller: _cvvcontroller,
                  decoration: InputDecoration(
                    hintText: 'CVV',
                    hintStyle: TextStyle(
                      color: Colors.blue.shade400,
                    ),
                    border: InputBorder.none,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  maxLength: 3,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (_month == null ||
                  _year == null ||
                  _cardNumberController.text.length != 16 ||
                  _cvvcontroller.text.length != 3) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Please fill all the fields'),
                      actions: [
                        ElevatedButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                if (_month == "06" &&
                    _year == "22" &&
                    _cvvcontroller.text == "123" &&
                    _cardNumberController.text == "1234567890123456") {
                  Map<String, dynamic> flag = await addorder(uid, itemids, urls,
                      sizes, totalamount, mainids, "prepaid", priceandcount);

                  if (flag['status'] == 'success') {
                    for (var item in itemids) {
                      await FirebaseFirestore.instance
                          .collection('user')
                          .doc(uid)
                          .collection('cart')
                          .doc(item)
                          .delete();
                    }
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Ordersucces(
                                  totalamount: totalamount,
                                )));
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text('Error'),
                              content: Text(flag['status']),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("ok"))
                              ],
                            ));
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content:
                            const Text('Please select correct month and year'),
                        actions: [
                          ElevatedButton(
                            child: const Text('Ok'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            child: Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Center(
                child: Text(
                  'Pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
