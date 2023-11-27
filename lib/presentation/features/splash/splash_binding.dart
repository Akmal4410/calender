import 'package:calender/presentation/features/splash/splash_controller.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SplashController(DeviceCalendarPlugin()),
    );
  }
}
