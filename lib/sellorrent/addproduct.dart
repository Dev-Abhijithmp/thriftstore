// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/add/functions.dart';
import 'package:thriftstore/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String type;
  AddProduct({Key? key, required this.type}) : super(key: key);

  @override
  AddProductState createState() => AddProductState();
}

TextEditingController pricecontroller = TextEditingController();
TextEditingController controlleraddress = TextEditingController();
TextEditingController controllerdistrict = TextEditingController();
TextEditingController controllernum = TextEditingController();
TextEditingController namecontroller = TextEditingController();
bool isloading = false;
File? _pickedImage;
bool loading = false;
bool show = true;

class AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    void pickImagecamera() async {
      final picker = ImagePicker();
      XFile? pickedImage =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 5);
      File? pickedImageFile;
      pickedImage == null
          ? pickedImageFile = null
          : pickedImageFile = File(pickedImage.path);

      setState(() {
        _pickedImage = pickedImageFile;
      });
      // widget.imagePickFn(pickedImageFile);
    }

    void removeImage() {
      setState(() {
        _pickedImage = null;
      });
    }

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
            ),
            child: Container(
              margin: EdgeInsets.only(right: 30, top: 60, left: 40),
              alignment: Alignment.center,
              child: Text("Add product",
                  style: GoogleFonts.blackHanSans(
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                      textStyle: TextStyle(color: Colors.white))),
            )),
        Container(
            height: 180,
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border.all(color: mainColor)),
            child: _pickedImage == null
                ? const Text("")
                : Image.file(
                    _pickedImage!,
                    fit: BoxFit.contain,
                  )),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                pickImagecamera();
              },
              child: Container(
                width: 120,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: mainColor),
                child: const Center(child: Text("Add image")),
              ),
            ),
            InkWell(
              onTap: () {
                removeImage();
              },
              child: Container(
                width: 120,
                height: 35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: mainColor),
                child: const Center(
                  child: Text("remove image"),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            TextFormField(
              controller: pricecontroller,
              decoration: InputDecoration(labelText: "Enter price of product"),
            ),
          ]),
        ),
        SizedBox(
          height: 10,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: DropdownButtonFormField<String>(
        //     decoration: InputDecoration(labelText: 'Donation Weight Type:'),
        //     value: donationweight,
        //     icon: const Icon(Icons.monitor_weight),
        //     iconSize: 24,
        //     elevation: 16,
        //     style: const TextStyle(color: Colors.deepPurple),
        //     onChanged: (String? newValue1) {
        //       setState(() {
        //         donationweight = newValue1!;
        //       });
        //     },
        //     items: <String>['1-10kg', '10-30kg', '30-50kg', '50 above']
        //         .map<DropdownMenuItem<String>>((String value) {
        //       return DropdownMenuItem<String>(
        //         value: value,
        //         child: Text(value),
        //       );
        //     }).toList(),
        //   ),
        // ),

        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            TextFormField(
              controller: controlleraddress,
              decoration: InputDecoration(labelText: "Enter Your Address"),
            ),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            TextFormField(
              controller: controllerdistrict,
              decoration: InputDecoration(labelText: "Enter your district"),
            ),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(children: [
            TextFormField(
              controller: controllernum,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.phone,
              maxLength: 10,
              decoration:
                  InputDecoration(labelText: "Enter Your Mobile Number"),
            ),
          ]),
        ),
        SizedBox(
          height: 20,
        ),
        isloading == false
            ? InkWell(
                onTap: () async {
                  if (controlleraddress.text == "" ||
                      controllerdistrict.text == "" ||
                      pricecontroller.text == "" ||
                      controllernum.text.length < 10) {
                    showdialogue("Error", "Fill all the fields", context);
                  } else {
                    isloading = true;
                    Map<String, String> flag = await addproduct(
                        type: widget.type,
                        url: "",
                        name: namecontroller.text,
                        price: pricecontroller.text,
                        address: controlleraddress.text,
                        district: controllerdistrict.text,
                        phone: controllernum.text);
                    if (flag['status'] == 'success') {
                      showdialogue("success", "success", context);
                      setState(() {
                        isloading = false;
                      });
                    } else {
                      setState(() {
                        isloading = false;
                        showdialogue("Error", flag['status']!, context);
                      });
                    }
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  height: 40,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: mainColor,
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 6,
                          color: Colors.grey.shade300)
                    ],
                  ),
                  child: Text(
                    "submit",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
            : Container(
                alignment: Alignment.center,
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: mainColor,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 20),
                        blurRadius: 6,
                        color: Colors.grey.shade300)
                  ],
                ),
                child: Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ])),
    );
  }
}
