import 'package:car_service/business%20logics/firebase_functions.dart';
import 'package:car_service/controllers/loading_controller.dart';
import 'package:car_service/data%20models/fixed_lists.dart';
import 'package:car_service/screens/home_for_client.dart';
import 'package:car_service/widgets/general%20widgets/bottom_sheet_modal.dart';
import 'package:car_service/widgets/general%20widgets/custom_textfield.dart';
import 'package:car_service/widgets/general%20widgets/loading_overlay.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class ServiceCreationUi extends StatelessWidget {

  late LoadingController loadingController;

  ServiceCreationUi({super.key, required this.loadingController});

  @override
  Widget build(BuildContext context) {

    RxBool shouldShowLoadingOverlay = false.obs;
    TextEditingController carNameController = TextEditingController(), serviceController = TextEditingController(), dropOffDateTimePicker = TextEditingController();
    BottomSheetModal bottomSheetModal = BottomSheetModal();

    return Obx(() => Stack(
      children: [
        SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.0,vertical: 11),
                  child: GestureDetector(
                      onTap: () {
                        bottomSheetModal.showBottomSheetModal(FixedLists().listOfCars, context, false, carNameController);
                      },
                      child: CustomTextfield(hint: "enter car name", controller: carNameController, tag: "car name", iconData: CupertinoIcons.car, enabled: false,)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.0),
                  child: GestureDetector(
                      onTap: () {
                        bottomSheetModal.showBottomSheetModal(FixedLists().listOfServices, context, true, serviceController);
                      },
                      child: CustomTextfield(hint: "pick services", controller: serviceController, tag: "all services", iconData: CupertinoIcons.settings, enabled: false,)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 11),
                  child: GestureDetector(
                      onTap: () async {
                        DateTime? dateTime = await showOmniDateTimePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                          DateTime(1600).subtract(const Duration(days: 3652)),
                          lastDate: DateTime.now().add(
                            const Duration(days: 3652),
                          ),
                          is24HourMode: false,
                          isShowSeconds: false,
                          minutesInterval: 1,
                          secondsInterval: 1,
                          borderRadius: const BorderRadius.all(Radius.circular(16)),
                          constraints: const BoxConstraints(
                            maxWidth: 350,
                            maxHeight: 650,
                          ),
                          transitionBuilder: (context, anim1, anim2, child) {
                            return FadeTransition(
                              opacity: anim1.drive(
                                Tween(
                                  begin: 0,
                                  end: 1,
                                ),
                              ),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 200),
                          barrierDismissible: true,
                          selectableDayPredicate: (dateTime) {
                            print(dateTime);
                            // Disable 25th Feb 2023
                            if (dateTime == DateTime(2023, 2, 25)) {
                              return false;
                            } else {
                              return true;
                            }
                          },
                        );
                        dropOffDateTimePicker.text = dateTime.toString();
                      },
                      child: CustomTextfield(hint: "23rd August, 2007", controller: dropOffDateTimePicker, tag: "drop-off date", iconData: CupertinoIcons.calendar, enabled: false,)),
                ),
                Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: GestureDetector(
                    onTap: () async {
                      shouldShowLoadingOverlay.value = true;
                      await FirebaseFunctions().addServiceToCloud(carNameController, serviceController, dropOffDateTimePicker);
                      loadingController.updateShouldShowLoadingOverlay();
                    },
                    child: Container(
                      width: Get.size.width * .75,
                      height: AppBar().preferredSize.height * .89,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(
                        child: Text("schedule service(s)",
                          style: TextStyle(
                              height: 0,
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: Get.size.width * .045
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(11,0,11,11),
                  child: GestureDetector(
                    onTap: () async {
                      loadingController.updateShouldShowLoadingOverlay();
                    },
                    child: Container(
                      width: Get.size.width * .75,
                      height: AppBar().preferredSize.height * .89,
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Center(
                        child: Text("cancel",
                          style: TextStyle(
                              height: 0,
                              fontFamily: "SF-Pro",
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: Get.size.width * .045
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
            visible: shouldShowLoadingOverlay.value,
            child: const LoadingOverlay())
      ],
    ));
  }
}
