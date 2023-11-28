import 'package:calender/data/data_source/my_calendar_data_source.dart';
import 'package:calender/domain/models/calender_event.dart';
import 'package:calender/domain/repositories/i_my_calendar_repo.dart';
import 'package:device_calendar/device_calendar.dart';

class MyCalendarRepoImpl implements IMyCalendarRepo {
  MyCalendarRepoImpl(this._myCalendarDataSource);

  final MyCalendarDataSource _myCalendarDataSource;

  @override
  Future<void> addToCalendar(
      MyCalendarEvent calenderEvent, String selectedCalendarId) {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, List<Calendar>>> loadCalender() {
    return _myCalendarDataSource.loadCalender();
  }

  @override
  Future<List<String>> getSelectedCalendars() {
    return _myCalendarDataSource.getSelectedCalendars();
  }

  @override
  Future<void> addOrRemoveFromCalendars(bool? value, String calendarName) {
    return _myCalendarDataSource.addOrRemoveFromCalendars(value, calendarName);
  }

  @override
  Future<List<MyCalendarEvent>> getDataSource() {
    return _myCalendarDataSource.getDataSource();
  }
}
