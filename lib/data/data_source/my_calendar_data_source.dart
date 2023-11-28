import 'package:calender/data/data_source/my_calendar_event_mapper.dart';
import 'package:calender/domain/models/calender_event.dart';
import 'package:calender/utils/contants/secrets.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MyCalendarDataSource {
  Future<Map<String, List<Calendar>>> loadCalender();
  Future<List<String>> getSelectedCalendars();
  Future<void> addOrRemoveFromCalendars(bool? value, String calendarName);
  Future<List<MyCalendarEvent>> getDataSource();
  Future<void> addToCalendar(
      MyCalendarEvent calenderEvent, String selectedCalendarId);
}

class RemoteMyCalendarDataSource extends MyCalendarDataSource {
  final DeviceCalendarPlugin _deviceCalendarPlugin;

  RemoteMyCalendarDataSource(this._deviceCalendarPlugin);

  Location _currentLocation = getLocation('America/Detroit');

  Future setCurentLocation() async {
    String timezone = 'America/Detroit';
    try {
      timezone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      debugPrint('Could not get the local timezone');
    }
    _currentLocation = getLocation(timezone);
    setLocalLocation(_currentLocation);
  }

  @override
  Future<void> addToCalendar(
    MyCalendarEvent calenderEvent,
    String selectedCalendarId,
  ) async {
    setCurentLocation();
    final eventToCreate = Event(
      selectedCalendarId,
      title: calenderEvent.subject,
      allDay: calenderEvent.isAllDay,
      start: TZDateTime.from(calenderEvent.start, _currentLocation),
      end: TZDateTime.from(calenderEvent.end, _currentLocation),
    );

    final createEventResult =
        await _deviceCalendarPlugin.createOrUpdateEvent(eventToCreate);

    if (createEventResult?.isSuccess ?? false) {
    } else {}
  }

  @override
  Future<Map<String, List<Calendar>>> loadCalender() async {
    final Map<String, List<Calendar>> map = {};
    try {
      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      final calendars = calendarsResult.data?.toList() ?? [];
      await setCalendarIds(calendars);
      calendars.fold(map, (previousValue, calendar) {
        if (calendar.accountType == "LOCAL") {
          List<Calendar> calenderList = map[calendar.name] ?? [];
          calenderList.add(calendar);
          map[calendar.name ?? ''] = calenderList;
          return map;
        } else if (calendar.accountType == "com.osp.app.signin") {
          List<Calendar> calenderList = map[calendar.name] ?? [];
          calenderList.add(calendar);
          map[calendar.name ?? ''] = calenderList;
          return map;
        } else {
          List<Calendar> calenderList = map[calendar.accountName] ?? [];
          calenderList.add(calendar);
          map[calendar.accountName ?? ''] = calenderList;
          return map;
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return map;
  }

  @override
  Future<void> addOrRemoveFromCalendars(
      bool? value, String calendarName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final selectedCalendars = await getSelectedCalendars();
      if (value != null && value) {
        selectedCalendars.add(calendarName);
        prefs.setStringList(Secrets.selectedCalendars, selectedCalendars);
        await getSelectedCalendars();
      } else {
        selectedCalendars.remove(calendarName);
        prefs.setStringList(Secrets.selectedCalendars, selectedCalendars);
        await getSelectedCalendars();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<List<String>> getSelectedCalendars() async {
    List<String> selectedValues = [];
    try {
      final prefs = await SharedPreferences.getInstance();
      selectedValues = prefs.getStringList(Secrets.selectedCalendars) ?? [];
    } catch (e) {
      debugPrint(e.toString());
    }
    return selectedValues;
  }

  @override
  Future<List<MyCalendarEvent>> getDataSource() async {
    List<MyCalendarEvent> calendarEvents = [];
    try {
      final calendarIds = await getCalendarIds();
      for (var calendarId in calendarIds) {
        final params = RetrieveEventsParams(
          startDate: DateTime(2000),
          endDate: DateTime(2100),
        );

        final datas =
            await _deviceCalendarPlugin.retrieveEvents(calendarId, params);
        List<Event> events = datas.data ?? [];
        final myCalendarEvents = events
            .map((event) => MyCalendarEventMapper.fromEvent(event))
            .toList();
        calendarEvents.addAll(myCalendarEvents);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return calendarEvents;
  }

  Future<List<String>> getCalendarIds() async {
    List<String> calenderIds = [];
    try {
      final prefs = await SharedPreferences.getInstance();
      calenderIds = prefs.getStringList(Secrets.calendarIds) ?? [];
    } catch (e) {
      debugPrint(e.toString());
    }
    return calenderIds;
  }

  Future<void> setCalendarIds(List<Calendar> calendarList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> calenderIds = [];
      for (var calendar in calendarList) {
        calenderIds.add(calendar.id ?? '');
      }
      await prefs.setStringList(Secrets.calendarIds, calenderIds);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
