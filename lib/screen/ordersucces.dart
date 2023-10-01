import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftstore/widgets.dart';

class Ordersucces extends StatelessWidget {
  late final int totalamount;
  Ordersucces({Key? key, required this.totalamount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: Colors.green.shade700,
            ),
           const  SizedBox(height: 15,),
            Text(
              "₹" + totalamount.toString(),
              style: GoogleFonts.lato(color: Colors.white, fontSize: 40),
            ),
            SizedBox(height: 20,),
            Text(
              "your order has been placed successfully",
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
