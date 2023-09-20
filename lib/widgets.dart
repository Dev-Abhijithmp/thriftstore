import 'package:flutter/material.dart';

showdialogue(String title, String content, context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("ok"),
              ),
            ],
          ));
}

const Color mainColor = Color.fromRGBO(239, 149, 149, 1);
