import 'package:flutter/material.dart';
import 'package:thriftstore/widgets.dart';

class Loadingpage extends StatelessWidget {
  const Loadingpage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: mainColor,
          ),
        ));
  }
}
