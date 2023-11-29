import 'dart:convert';
import 'package:calender/data/mapper/my_calendar_event_mapper.dart';
import 'package:calender/domain/models/calender_event.dart';
import 'package:calender/utils/contants/secrets.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MyCalendarDataSource {
  Future<Map<String, List<Calendar>>> loadCalender();
  Future<List<String>> getSelectedCalendars();
  Future<void> addOrRemoveFromCalendars(String calendarName);
  Future<List<MyCalendarEvent>> getDataSource();
}

class RemoteMyCalendarDataSource extends MyCalendarDataSource {
  final DeviceCalendarPlugin _deviceCalendarPlugin;

  RemoteMyCalendarDataSource(this._deviceCalendarPlugin);

  @override
  Future<Map<String, List<Calendar>>> loadCalender() async {
    Map<String, List<Calendar>> calenderMap = {};
    try {
      final calendarsResult = await _deviceCalendarPlugin.retrieveCalendars();
      final calendars = calendarsResult.data?.toList() ?? [];
      await setCalendarIds(calendars);
      calenderMap = calendars.fold({}, (map, calendar) {
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
    return calenderMap;
  }

  @override
  Future<void> addOrRemoveFromCalendars(String calendarName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final selectedCalendars = await getSelectedCalendars();
      if (selectedCalendars.contains(calendarName)) {
        selectedCalendars.remove(calendarName);
        await prefs.setStringList(Secrets.selectedCalendars, selectedCalendars);
      } else {
        selectedCalendars.add(calendarName);
        await prefs.setStringList(Secrets.selectedCalendars, selectedCalendars);
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
      final selectedCalendars = await getSelectedCalendars();

      List<String> filteredIds = selectedCalendars
          .where((id) => calendarIds.containsKey(id))
          .map((id) => calendarIds[id]) // Map keys to values
          .toList()
          .cast();

      for (var calendarId in filteredIds) {
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

  Future<Map<String, dynamic>> getCalendarIds() async {
    Map<String, dynamic> idMaps = {};
    try {
      final prefs = await SharedPreferences.getInstance();
      final idMapsString = prefs.getString(Secrets.calendarIds);
      if (idMapsString != null) {
        idMaps = jsonDecode(idMapsString);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return idMaps;
  }

  Future<void> setCalendarIds(List<Calendar> calendarList) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map<String, String> idMap = {};
      for (var calendar in calendarList) {
        idMap[calendar.name ?? ''] = calendar.id ?? '';
        await addToCalender(calendar.name ?? '');
      }
      await prefs.setString(Secrets.calendarIds, jsonEncode(idMap));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addToCalender(String calendarName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final selectedCalendars = await getSelectedCalendars();
      if (!selectedCalendars.contains(calendarName)) {
        selectedCalendars.add(calendarName);
        await prefs.setStringList(Secrets.selectedCalendars, selectedCalendars);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
