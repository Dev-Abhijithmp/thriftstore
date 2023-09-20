import 'package:flutter/material.dart';

class Loadingpage extends StatelessWidget {
  const Loadingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: CircularProgressIndicator(
                color: Colors.green,
              )),
        ));
  }
}
