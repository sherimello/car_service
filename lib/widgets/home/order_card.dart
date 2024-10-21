import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderCard extends StatelessWidget {

  final Color color;
  final String carName, status, service;
  final IconData iconData;

  const OrderCard({super.key, required this.color, required this.carName, required this.status, required this.iconData, required this.service});

  @override
  Widget build(BuildContext context) {

    var size = Get.size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(21.0, 5.5,21,5.5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: size.width * .157,
              height: size.width * .157,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000),
                color: color,
              ),
              child: Icon(iconData, color: Colors.white,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$carName ($service)", overflow: TextOverflow.fade, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: size.width * .045),),
                  Text(status, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: size.width * .035),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
