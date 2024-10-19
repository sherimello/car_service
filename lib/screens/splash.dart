import 'dart:async';

import 'package:car_service/widgets/login%20widgets/login_register_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    RxBool shouldShowHeadlights = false.obs, shouldShowLoginUI = false.obs;

    Timer timer = Timer(const Duration(seconds: 1), () {
      shouldShowHeadlights.value = true;
    });

    Timer timer2 = Timer(const Duration(seconds: 5), () {
      shouldShowLoginUI.value = true;
      shouldShowHeadlights.value = false;
    });

    double getTextWidth(String text, TextStyle style) {
      final textSpan = TextSpan(text: text, style: style);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: double.infinity);
      return textPainter.width;
    }

    double getTextHeight(String text, TextStyle style) {
      final textSpan = TextSpan(text: text, style: style);
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: double.infinity);
      return textPainter.height;
    }

    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: shouldShowHeadlights.value ? 1 : 0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeOut,
                    child: Image.asset(
                      "assets/images/headlights.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 555),
                    curve: Curves.linearToEaseOut,
                    left: shouldShowLoginUI.value
                        ? 17
                        : size.width * .5 -
                            getTextWidth(
                                    "headlights",
                                    TextStyle(
                                        height: 0,
                                        fontFamily: "Rounded_Elegance",
                                        fontSize: size.width * .067,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white.withOpacity(.55))) *
                                .5,
                    bottom: shouldShowLoginUI.value
                        ? size.height - (getTextHeight(
                        "headlights",
                        TextStyle(
                            height: 0,
                            fontFamily: "Rounded_Elegance",
                            fontSize: size.width * .067,
                            fontWeight: FontWeight.w900,
                            color: Colors.white.withOpacity(.55))) + 51)
                        : 17,
                    child: Text(
                      "headlights",
                      style: TextStyle(
                          height: 0,
                          fontFamily: "Rounded_Elegance",
                          fontSize: size.width * .067,
                          fontWeight: FontWeight.w900,
                          color: Colors.white.withOpacity(.55)),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: shouldShowLoginUI.value ? 1 : 0,
                    duration: const Duration(seconds: 2),
                    curve: Curves.linearToEaseOut,
                    child: LoginRegisterUi(),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
