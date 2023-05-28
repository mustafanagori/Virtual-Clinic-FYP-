import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    update();
  }
}
