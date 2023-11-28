import 'package:calender/domain/models/calender_event.dart';
import 'package:calender/domain/repositories/i_my_calendar_repo.dart';
import 'package:device_calendar/device_calendar.dart';

abstract class GetMyCalendar {
  Future<Map<String, List<Calendar>>> loadCalender();
  Future<List<String>> getSelectedCalendars();
  Future<void> addOrRemoveFromCalendars(bool? value, String calendarName);
  Future<List<MyCalendarEvent>> getDataSource();
  Future<void> addToCalendar(
      MyCalendarEvent calenderEvent, String selectedCalendarId);
}

class GetMyCalenderImpl extends GetMyCalendar {
  GetMyCalenderImpl(this._iMyCalendarRepo);

  final IMyCalendarRepo _iMyCalendarRepo;

  @override
  Future<Map<String, List<Calendar>>> loadCalender() {
    return _iMyCalendarRepo.loadCalender();
  }

  @override
  Future<void> addToCalendar(
      MyCalendarEvent calenderEvent, String selectedCalendarId) {
    return _iMyCalendarRepo.addToCalendar(calenderEvent, selectedCalendarId);
  }

  @override
  Future<List<String>> getSelectedCalendars() {
    return _iMyCalendarRepo.getSelectedCalendars();
  }

  @override
  Future<void> addOrRemoveFromCalendars(bool? value, String calendarName) {
    return _iMyCalendarRepo.addOrRemoveFromCalendars(value, calendarName);
  }

  @override
  Future<List<MyCalendarEvent>> getDataSource() {
    return _iMyCalendarRepo.getDataSource();
  }
}
