import 'package:car_service/business%20logics/firebase_functions.dart';
import 'package:car_service/widgets/home/order_card.dart';
import 'package:car_service/widgets/home/order_card_for_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    int orderIndex = 0;
    var size = Get.size;
    RxList<Object?> ordersList = [].obs;
    RxList<Object?> assigneeIDs = [].obs, orderIDs = [].obs, mechanics = [].obs, mechanicUIDs = [].obs;
    FirebaseFunctions firebaseFunctions = Get.put(FirebaseFunctions());

    firebaseFunctions.fetchOrderDataOfAllUsers(ordersList, assigneeIDs, orderIDs, mechanicUIDs);
    firebaseFunctions.fetchAllMechanics(mechanics);

    TextStyle ts = TextStyle(
        height: 0,
        fontFamily: "Rounded_Elegance",
        fontSize: size.width * .067,
        fontWeight: FontWeight.w900,
        color: Colors.white.withOpacity(.55));

    return Obx(() => Scaffold(
      appBar: AppBar(
        title: Text("headlights", style: ts),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 21),
              child: Text.rich(TextSpan(children: [
                const WidgetSpan(
                    child: Icon(
                      Icons.request_page_outlined,
                      color: Colors.white,
                    ),
                    alignment: PlaceholderAlignment.middle),
                TextSpan(
                    text: "  all service requests",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: size.width * .045,
                        fontFamily: "SF-Pro"))
              ])),
            ),
            assigneeIDs.isEmpty ? const SizedBox() : Expanded(
              child: ListView.builder(
                  itemCount: ordersList.length,
                  itemBuilder: (context, index) {
                    Map<Object?, Object?> order =
                    ordersList[index] as Map<Object?, Object?>;

                    return GestureDetector(
                      onTap: () {
                        orderIndex = index;
                        Get.bottomSheet(
                          Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(41)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(11.0),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(11),
                                  itemCount: mechanics.length,
                                  itemBuilder: (context, index) {

                                    String mechanic = mechanics[index].toString();

                                    return  Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(0,21,21,21),
                                          child: Text.rich(TextSpan(children: [
                                            const WidgetSpan(
                                                child: Icon(
                                                  Icons.all_inclusive_sharp,
                                                  color: Colors.black,
                                                ),
                                                alignment: PlaceholderAlignment.middle),
                                            TextSpan(
                                                text: "  all mechanics",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w900,
                                                    fontSize: size.width * .045,
                                                    fontFamily: "SF-Pro"))
                                          ])),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: GestureDetector(
                                            onTap: () async {
                                              print(index);
                                              await firebaseFunctions.assignMechanic(orderIDs[orderIndex].toString(), mechanic.substring(mechanic.indexOf("uid: ") + 5));
                                              // ordersList.clear();
                                              // firebaseFunctions.fetchOrderDataOfAllUsers(ordersList, assigneeIDs, orderIDs, mechanicUIDs);
                                              firebaseFunctions.reloadAsigneeData(assigneeIDs, mechanicUIDs);
                                              Navigator.pop(context);
                                            },
                                            child: Text("${index + 1}. ${mechanic.substring(mechanic.indexOf("name: ") + 6, mechanic.indexOf(", services:"))} (${mechanic.substring(mechanic.indexOf("phone: ") + 7, mechanic.indexOf(", name:"))})",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: size.width * 0.045,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black54
                                            ),
                                            ),
                                          ),
                                        ),
                                        // const Divider(),
                                      ],
                                    );
                                  },
                                )
                                ),
                              ),
                          ),
                          );
                      },
                      child: OrderCardForAdmin(
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
                              .replaceAll("]", ""),
                      assignedTo: assigneeIDs[index].toString(),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
