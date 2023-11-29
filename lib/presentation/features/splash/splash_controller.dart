import 'package:calender/domain/use_cases/get_my_calendar.dart';
import 'package:calender/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_calendar/device_calendar.dart';

class SplashController extends GetxController {
  final DeviceCalendarPlugin _deviceCalendarPlugin;
  final GetMyCalendar _getMyCalendar;

  SplashController(this._deviceCalendarPlugin, this._getMyCalendar);
  RxBool isSuccess = RxBool(true);

  Future<void> loadCalendars() async {
    try {
      var arePermissionsGranted = await _deviceCalendarPlugin.hasPermissions();
      if (arePermissionsGranted.isSuccess) {
        arePermissionsGranted =
            await _deviceCalendarPlugin.requestPermissions();
        if (arePermissionsGranted.isSuccess) {
          _getMyCalendar.loadCalender();
          _getMyCalendar.getDataSource();
          Get.offAllNamed(AppRoutes.kCalender);
        } else {
          isSuccess(false);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
