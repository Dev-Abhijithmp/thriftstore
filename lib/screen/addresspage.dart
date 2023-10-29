import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:thriftstore/add/functions.dart';
import 'package:thriftstore/widgets.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController addcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Adress"),
        backgroundColor: mainColor,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                maxLines: 3,
                controller: addcontroller,
                decoration: const InputDecoration(
                    label: Text("address"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    if (addcontroller.text.isEmpty) {
                      showdialogue('warning', 'please enter address', context);
                    } else {
                      changeAddress(FirebaseAuth.instance.currentUser!.uid,
                              addcontroller.text)
                          .then((value) {
                        if (value["status"] == "success") {
                          addcontroller.clear();
                          showdialogue('', 'success', context);
                        }
                      });
                    }
                  },
                  child: const Text("submit")),
            )
          ]),
    );
  }
}
