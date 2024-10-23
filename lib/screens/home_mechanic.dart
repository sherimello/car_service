import 'package:car_service/business%20logics/firebase_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/home/order_card.dart';

int i = 0;

class HomeMechanic extends StatelessWidget {
  const HomeMechanic({super.key});

  @override
  Widget build(BuildContext context) {
    var size = Get.size;

    RxList<Object?> ordersList = [].obs;
    List<String> userIDs = [],
        orderIDs = [];
    FirebaseFunctions firebaseFunctions = Get.put(FirebaseFunctions());

    RxString carName = "toyota".obs;
    TextStyle ts = TextStyle(
        height: 0,
        fontFamily: "Rounded_Elegance",
        fontSize: size.width * .067,
        fontWeight: FontWeight.w900,
        color: Colors.white.withOpacity(.55));


    firebaseFunctions.fetchOrderDataOfAllUser(ordersList, userIDs, orderIDs);

    List<Widget> orders() {
      List<Widget> w = [];
      for (dynamic d in ordersList.reversed) {
        w.add(GestureDetector(
          onTap: () {
            firebaseFunctions.updateStatus(
                "ready to pick up", orderIDs[i].toString(), userIDs[i]);
          },
          child: OrderCard(
              color: d["status"].toString() == "in queue"
                  ? Colors.red
                  : d["status"].toString() == "ongoing"
                  ? Colors.orangeAccent
                  : Colors.green,
              carName: d['car_name']
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", ""),
              status: d["status"].toString(),
              iconData: d["status"].toString() == "in queue"
                  ? CupertinoIcons.arrow_2_squarepath
                  : d["status"].toString() == "ongoing"
                  ? CupertinoIcons.arrow_swap
                  : CupertinoIcons.arrow_turn_right_up,
              service: d["services"]
                  .toString()
                  .replaceAll("[", "")
                  .replaceAll("]", "")),
        ));
        i++;
      }
      return w;
    }

    return Obx(() =>
        Scaffold(
          appBar: AppBar(
            title: Text("headlights", style: ts),
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
          ),
          backgroundColor: Colors.black,
          body: SafeArea(
            child: ordersList.isEmpty ? const SizedBox() : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 21, vertical: 21),
                  child: Text.rich(
                      TextSpan(
                          children: [
                            WidgetSpan(child: Icon(
                              Icons.task_alt, color: Colors.white,),
                                alignment: PlaceholderAlignment.middle),
                            TextSpan(
                                text: "your to-do(s)",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: size.width * .045,
                                    fontFamily: "SF-Pro"
                                )
                            )
                          ]
                      )
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: ordersList.length,
                      itemBuilder: (context, index) {
                        Map<Object?, Object?> order = ordersList[index] as Map<
                            Object?,
                            Object?>;
                        return GestureDetector(
                          onTap: () {
                            Get.bottomSheet(Padding(
                              padding: const EdgeInsets.all(21.0),
                              child: Container(decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(41),
                                  color: Colors.white
                              ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    order["status"] != "in queue" ? Padding(
                                      padding: const EdgeInsets.fromLTRB(21,21,21,5.5),
                                      child: GestureDetector(
                                        onTap: () {
                                          ordersList.clear();
                                          firebaseFunctions.updateStatus("in queue", orderIDs[index], userIDs[index]);
                                          Navigator.pop(context);
                                        },
                                        child: SizedBox(
                                          width: size.width,
                                          child: Text.rich(
                                              TextSpan(
                                                  children: [
                                                    WidgetSpan(child: Icon(
                                                      CupertinoIcons.arrow_2_squarepath,
                                                      color: Colors.red,),
                                                        alignment: PlaceholderAlignment
                                                            .middle),
                                                    TextSpan(
                                                      text: "  in queue",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.w900,
                                                        fontSize: size.width * .045
                                                      )
                                                    )
                                                  ]
                                              )
                                          ),
                                        ),
                                      ),
                                    ) : const SizedBox(),
                                    order["status"] != "ongoing" ? Padding(
                                      padding: EdgeInsets.fromLTRB(21,order["status"] != "ongoing" ? 5.5 : 21,21,order["status"] != "ongoing" ? 21 : 5.5),
                                      child: GestureDetector(
                                        onTap: () {
                                          ordersList.clear();
                                          firebaseFunctions.updateStatus("ongoing", orderIDs[index], userIDs[index]);
                                          Navigator.pop(context);
                                        },
                                        child: SizedBox(
                                          width: size.width,
                                          child: Text.rich(
                                              TextSpan(
                                                  children: [
                                                    WidgetSpan(child: Icon(
                                                      CupertinoIcons.arrow_swap,
                                                      color: Colors.orange,),
                                                        alignment: PlaceholderAlignment
                                                            .middle),
                                                    TextSpan(
                                                      text: "  ongoing",
                                                      style: TextStyle(
                                                        color: Colors.orange,
                                                        fontWeight: FontWeight.w900,
                                                        fontSize: size.width * .045
                                                      )
                                                    )
                                                  ]
                                              )
                                          ),
                                        ),
                                      ),
                                    ) : const SizedBox(),
                                    order["status"] != "ready to pick up" ? Padding(
                                      padding: const EdgeInsets.fromLTRB(21,5.5,21,21),
                                      child: GestureDetector(
                                        onTap: () async {
                                          ordersList.clear();
                                          firebaseFunctions.updateStatus("ready to pick up", orderIDs[index], userIDs[index]);
                                          Navigator.pop(context);
                                        },
                                        child: SizedBox(
                                          width: size.width,
                                          child: Text.rich(
                                              TextSpan(
                                                  children: [
                                                    const WidgetSpan(child: Icon(
                                                      CupertinoIcons.arrow_turn_right_up,
                                                      color: Colors.green,),
                                                        alignment: PlaceholderAlignment
                                                            .middle),
                                                    TextSpan(
                                                      text: "  ready to pick up",
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight: FontWeight.w900,
                                                        fontSize: size.width * .045
                                                      )
                                                    )
                                                  ]
                                              )
                                          ),
                                        ),
                                      ),
                                    ) : const SizedBox(),
                                  ],
                                ),
                              ),
                            ));
                          },
                          child: OrderCard(
                              color: order["status"].toString() == "in queue"
                                  ? Colors.red
                                  : order["status"].toString() == "ongoing"
                                  ? Colors.orangeAccent
                                  : Colors.green,
                              carName: order['car_name']
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", ""),
                              status: order["status"].toString(),
                              iconData: order["status"].toString() == "in queue"
                                  ? CupertinoIcons.arrow_2_squarepath
                                  : order["status"].toString() == "ongoing"
                                  ? CupertinoIcons.arrow_swap
                                  : CupertinoIcons.arrow_turn_right_up,
                              service: order["services"]
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", "")),
                        );
                      }),
                )
                // Column(
                //   children: orders(),
                // )
              ],
            ),
          ),
        ));
  }
}
