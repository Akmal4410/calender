import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderController extends GetxController {
  final CalendarController calenderController = CalendarController();

  @override
  void dispose() {
    calenderController.dispose();
    super.dispose();
  }

  void changeView(CalendarView newView) {
    calenderController.view = newView;
    Get.back();
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calenderController.view == CalendarView.month &&
        calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      calenderController.view = CalendarView.day;
    } else if ((calenderController.view == CalendarView.week ||
            calenderController.view == CalendarView.workWeek) &&
        calendarTapDetails.targetElement == CalendarElement.viewHeader) {
      calenderController.view = CalendarView.day;
    }
  }
}
