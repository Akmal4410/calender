import 'package:calender/presentation/features/add_event/add_event_controller.dart';
import 'package:get/get.dart';

class AddEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddEventController(Get.find()));
  }
}
