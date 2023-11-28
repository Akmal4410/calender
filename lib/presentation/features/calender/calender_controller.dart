import 'package:calender/domain/models/calender_event.dart';
import 'package:calender/domain/use_cases/get_my_calendar.dart';
import 'package:calender/utils/routes/app_routes.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderController extends GetxController {
  CalenderController(this._getMyCalendar);

  final CalendarController calenderController = CalendarController();
  final GetMyCalendar _getMyCalendar;

  Rx<Map<String, List<Calendar>>> calenders = Rx({});
  Rx<List<String>> selectedValues = Rx([]);
  Rx<List<MyCalendarEvent>> calendarEvents = Rx([]);

  Future<void> getSelectedCalendars() async {
    final lists = await _getMyCalendar.getSelectedCalendars();
    selectedValues(lists);
  }

  Future<void> addOrRemoveFromCalendars(
      bool? value, String calendarName) async {
    await _getMyCalendar.addOrRemoveFromCalendars(value, calendarName);
    await getSelectedCalendars();
  }

  Future<void> getDataSource() async {
    final datas = await _getMyCalendar.getDataSource();
    calendarEvents(datas);
  }

  @override
  void onInit() async {
    await getSelectedCalendars();
    await getDataSource();
    final datas = await _getMyCalendar.loadCalender();
    calenders(datas);
    super.onInit();
  }

  @override
  void dispose() {
    calenderController.dispose();
    super.dispose();
  }

  void changeView(CalendarView newView) {
    calenderController.view = newView;
    Get.back();
  }

  void gotoAddEvent() {
    Get.toNamed(AppRoutes.kAddEvent);
  }
}
