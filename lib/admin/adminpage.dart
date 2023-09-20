import 'package:flutter/material.dart';
import 'package:thriftstore/admin/viewstaff.dart';
import 'package:thriftstore/authentication/authenticate.dart';

class Adminpage extends StatelessWidget {
  const Adminpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ViewProducts()));
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              child: const Center(
                child: Text("view products"),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              signout();
            },
            child: Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.green,
              ),
              child: const Center(
                child: Text("Logout "),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
