import 'package:calender/domain/models/calender_event.dart';
import 'package:device_calendar/device_calendar.dart';

class MyCalendarEventMapper {
  static MyCalendarEvent fromEvent(Event event) {
    DateTime? start = event.start?.millisecondsSinceEpoch != null
        ? DateTime.fromMillisecondsSinceEpoch(
            event.start!.millisecondsSinceEpoch)
        : null;

    DateTime? end = event.end?.millisecondsSinceEpoch != null
        ? DateTime.fromMillisecondsSinceEpoch(event.end!.millisecondsSinceEpoch)
        : null;
    return MyCalendarEvent(
      subject: event.title ?? '',
      start: start ?? DateTime.now(),
      end: end ?? DateTime.now(),
      isAllDay: event.allDay ?? false,
    );
  }
}
