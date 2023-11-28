import 'dart:ui';
import 'package:calender/domain/models/calender_event.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<MyCalendarEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).start;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).end;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).subject;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).color;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  MyCalendarEvent _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final MyCalendarEvent meetingData;
    if (meeting is MyCalendarEvent) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
