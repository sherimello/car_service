import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: const Center(
          child: CircularProgressIndicator(color: Colors.white,),
        ),
      ),
    );
  }
}
