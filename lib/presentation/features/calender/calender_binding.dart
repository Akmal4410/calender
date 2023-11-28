import 'package:calender/presentation/features/calender/calender_controller.dart';
import 'package:get/get.dart';

class CalenderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CalenderController(Get.find()));
  }
}
