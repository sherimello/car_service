import 'package:car_service/controllers/loading_controller.dart';
import 'package:car_service/functions/general_functions/ui_essentials.dart';
import 'package:car_service/widgets/home/order_card.dart';
import 'package:car_service/widgets/home/service_creation_ui.dart';
import 'package:car_service/widgets/home/top_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;
    LoadingController loadingController = LoadingController();
    final DatabaseReference _database = FirebaseDatabase.instance.ref().child('orders').child("ePgUlO4DqXXhk69GTvd0i22JiOY2");
    RxList<Object?> ordersList = [].obs;



    void fetchData() async {
      final databaseReference = FirebaseDatabase.instance.ref().child("orders").child("ePgUlO4DqXXhk69GTvd0i22JiOY2");
      databaseReference.onValue.listen(
          (event) {
            event.snapshot.children.every((snapshot) {
              ordersList.add(snapshot.value);
              print(ordersList);
              return true;
            });
            print(event.snapshot.value.toString());
      });
    }

    TextStyle ts = TextStyle(
        height: 0,
        fontFamily: "Rounded_Elegance",
        fontSize: size.width * .067,
        fontWeight: FontWeight.w900,
        color: Colors.white.withOpacity(.55));

    fetchData();

    return Obx(() => Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: AppBar().preferredSize.height * 1.5,
              left: 0,
              right: 0,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: MediaQuery.of(context).padding.top,),
                    const TopCard(),
                    GestureDetector(
                      onTap: () {
                        loadingController.shouldShowLoadingOverlay.value = true;
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          width: loadingController.shouldShowLoadingOverlay.value ? size.width - 42 : size.width * .77,
                          height: loadingController.shouldShowLoadingOverlay.value ? size.height * .5 : AppBar().preferredSize.height * .89,
                          duration: const Duration(milliseconds: 555),
                          curve: Curves.linearToEaseOut,
                          decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(loadingController.shouldShowLoadingOverlay.value ? 55 : 100)),
                          child: Stack(
                            children: [
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 555),
                                curve: Curves.linearToEaseOut,
                                opacity: loadingController.shouldShowLoadingOverlay.value ? 0 : 1,
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
                                opacity: loadingController.shouldShowLoadingOverlay.value ? 1 : 0,
                                child: ServiceCreationUi(loadingController: loadingController,),
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
                    // FirebaseAnimatedList(query: _database,
                    // itemBuilder: (context, snapshot, animation, index) {
                    //   var val = snapshot.value as Map;
                    //   print(val);
                    //   return OrderCard(color: Colors.orange, carName: val['car_name'], status: val['status'], iconData: Icons.upload_file, service: "tire change");
                    // },
                    // ),

                    for(dynamic d in ordersList)
                      OrderCard(color: Colors.orange, carName: d['car_name'].toString(), status: d["status"].toString(), iconData: Icons.upload_file, service: d["services"].toString()),

                    // GestureDetector(
                    //   onTap: () {
                    //     fetchData();
                    //   },
                    //   child: const OrderCard(
                    //       color: Colors.green,
                    //       carName: "Toyota Corolla",
                    //       status: "ready to pick up",
                    //       iconData: CupertinoIcons.arrow_turn_right_up,
                    //       service: "paint job"),
                    // ),
                    // const OrderCard(
                    //     color: Colors.orangeAccent,
                    //     carName: "Tesla Cyber Truck",
                    //     status: "ongoing",
                    //     iconData: CupertinoIcons.arrow_swap,
                    //     service: "motor tuning"),
                    // const OrderCard(
                    //     color: Colors.redAccent,
                    //     carName: "BMW B6",
                    //     status: "in queue",
                    //     iconData: CupertinoIcons.arrow_2_squarepath,
                    //     service: "tire change"),
                  ],
                ),
              ),
            ),
            // ListView.builder(
            //     itemCount: ordersList.length,
            //     itemBuilder: (context, index) {
            //       Map<Object?, Object?> order = ordersList[index] as Map<Object?, Object?>;
            //
            //       return OrderCard(color: Colors.orange, carName: order['car_name'].toString(), status: order["status"].toString(), iconData: Icons.upload_file, service: order["services"].toString());
            //
            //     }),
            Positioned(
              left: 21,
              top: MediaQuery.of(context).padding.top +
                  AppBar().preferredSize.height * 1.5 * .5 -
                  UiEssentials().getTextHeight("headlights", ts) * .5,
              child: Text("headlights", style: ts),
            ),
          ],
        ),
      ),
    ));
  }

}
