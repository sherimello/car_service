import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopCard extends StatelessWidget {
  const TopCard({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    return Padding(
      padding: const EdgeInsets.all(21.0),
      child: Opacity(
        opacity: .67,
        child: Container(
          width: size.width,
          // height: size.width * .5,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(45)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 17.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("50% off on all services till",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: size.width * .045, fontFamily: "SF-Pro"),
                ),
                Text("29th November",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: size.width * .065, fontFamily: "SF-Pro"),
                ),
                SizedBox(
                    width: size.width * .55,
                    height: size.width * .25,
                    child: Wrap(
                      children: [
                        Image.asset("assets/images/car.gif",
                          width: size.width * .55,
                          height: size.width * .25,),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
