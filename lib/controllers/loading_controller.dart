import 'package:get/get.dart';

class LoadingController extends GetxController {
  RxBool shouldShowLoadingOverlay = false.obs;

  updateShouldShowLoadingOverlay() {
    shouldShowLoadingOverlay.value = !shouldShowLoadingOverlay.value;
  }

}