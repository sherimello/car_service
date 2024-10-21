import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetModal {
  showBottomSheetModal(List<SelectedListItem> _listOfCities, dynamic context, bool b, TextEditingController controller) {
    DropDownState(
      heightOfBottomSheet: Get.size.height,
      DropDown(
        isDismissible: true,
        bottomSheetTitle: const Text(
          "cities",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        maxSelectedItems: _listOfCities.length,
        clearButtonChild: const Text(
          'Clear',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _listOfCities ?? [],
        onSelected: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
            }
          }
          Get.snackbar("selection", list.toString(), backgroundColor: Colors.white);
          controller.text = list.toString();
        },
        enableMultipleSelection: b,
      ),
    ).showModal(context);
  }
}
