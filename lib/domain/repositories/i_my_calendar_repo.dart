import 'package:calender/domain/models/calender_event.dart';
import 'package:device_calendar/device_calendar.dart';

abstract class IMyCalendarRepo {
  Future<Map<String, List<Calendar>>> loadCalender();
  Future<List<String>> getSelectedCalendars();
  Future<void> addOrRemoveFromCalendars(bool? value, String calendarName);
  Future<List<MyCalendarEvent>> getDataSource();
  Future<void> addToCalendar(
      MyCalendarEvent calenderEvent, String selectedCalendarId);
}
