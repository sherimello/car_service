import 'dart:async';

import 'package:car_service/business%20logics/firebase_functions.dart';
import 'package:car_service/controllers/loading_controller.dart';
import 'package:car_service/widgets/home/order_card.dart';
import 'package:car_service/widgets/home/service_creation_ui.dart';
import 'package:car_service/widgets/home/top_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeClient extends StatelessWidget {
  const HomeClient({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    LoadingController loadingController = LoadingController();

    RxList<Object?> ordersList = [].obs;

    FirebaseFunctions firebaseFunctions = Get.put(FirebaseFunctions());

    TextStyle ts = TextStyle(
        height: 0,
        fontFamily: "Rounded_Elegance",
        fontSize: size.width * .067,
        fontWeight: FontWeight.w900,
        color: Colors.white.withOpacity(.55));

    firebaseFunctions.fetchOrderDataOfIndividualUser(ordersList);

    return Obx(() => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(title: Text("headlights", style: ts),
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).padding.top,),
                    const TopCard(),
                    GestureDetector(
                      onTap: () {
                        loadingController.shouldShowLoadingOverlay.value =
                            true;
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          width: loadingController
                                  .shouldShowLoadingOverlay.value
                              ? size.width - 42
                              : size.width * .77,
                          height: loadingController
                                  .shouldShowLoadingOverlay.value
                              ? size.height * .5
                              : AppBar().preferredSize.height * .89,
                          duration: const Duration(milliseconds: 555),
                          curve: Curves.linearToEaseOut,
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(
                                  loadingController
                                          .shouldShowLoadingOverlay.value
                                      ? 55
                                      : 100)),
                          child: Stack(
                            children: [
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 555),
                                curve: Curves.linearToEaseOut,
                                opacity: loadingController
                                        .shouldShowLoadingOverlay.value
                                    ? 0
                                    : 1,
                                child: Center(
                                  child: Text(
                                    "create service request",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: size.width * .045),
                                  ),
                                ),
                              ),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 555),
                                curve: Curves.linearToEaseOut,
                                opacity: loadingController
                                        .shouldShowLoadingOverlay.value
                                    ? 1
                                    : 0,
                                child: ServiceCreationUi(
                                  loadingController: loadingController,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(21),
                      child: Text.rich(TextSpan(children: [
                        const WidgetSpan(
                            child: Icon(
                              Icons.sync,
                              color: Colors.white,
                            ),
                            alignment: PlaceholderAlignment.middle),
                        TextSpan(
                          text: " ongoing service(s):",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: size.width * .045),
                        )
                      ])),
                    ),
            
                    for (dynamic d in ordersList.reversed)
                      OrderCard(
                          color: d["status"].toString() == "in queue" ? Colors.red : d["status"].toString() == "ongoing" ? Colors.orangeAccent : Colors.green,
                          carName: d['car_name'].toString().replaceAll("[", "").replaceAll("]", ""),
                          status: d["status"].toString(),
                          iconData: d["status"].toString() == "in queue" ? CupertinoIcons.arrow_2_squarepath : d["status"].toString() == "ongoing" ? CupertinoIcons.arrow_swap : CupertinoIcons.arrow_turn_right_up,
                          service: d["services"].toString().replaceAll("[", "").replaceAll("]", "")),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
