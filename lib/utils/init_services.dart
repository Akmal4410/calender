import 'package:calender/data/data_source/my_calendar_data_source.dart';
import 'package:calender/data/repositories/my_calendar_repo_impl.dart';
import 'package:calender/domain/repositories/i_my_calendar_repo.dart';
import 'package:calender/domain/use_cases/get_my_calendar.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:get/get.dart';

Future<void> initServices() async {
  Get.put(DeviceCalendarPlugin());
  //Authentication
  Get.put<MyCalendarDataSource>(RemoteMyCalendarDataSource(Get.find()));
  Get.put<IMyCalendarRepo>(
      MyCalendarRepoImpl(Get.find<MyCalendarDataSource>()));
  Get.put<GetMyCalendar>(GetMyCalenderImpl(Get.find<IMyCalendarRepo>()));
}
