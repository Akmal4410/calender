import 'package:calender/domain/models/meeting.dart';
import 'package:calender/presentation/features/calender/calender_controller.dart';
import 'package:calender/presentation/features/calender/widgets/app_drawer.dart';
import 'package:calender/utils/contants/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderPage extends GetView<CalenderController> {
  const CalenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(
          myAppName,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => SfCalendar(
            controller: controller.calenderController,
            onTap: controller.calendarTapped,
            view: CalendarView.month,
            specialRegions: _getTimeRegions(),
            dataSource: MeetingDataSource(_getDataSource()),
            showTodayButton: true,
            selectionDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1.2),
            ),
            timeSlotViewSettings: const TimeSlotViewSettings(
                // timeIntervalHeight: 80,
                ),
            monthViewSettings: const MonthViewSettings(
              numberOfWeeksInView: 6,
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true,
              agendaViewHeight: 500,
              agendaItemHeight: 50,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 5));
    meetings.add(
      Meeting(
        'Conference',
        startTime,
        endTime,
        const Color(0xFF0F8644),
        true,
      ),
    );

    return meetings;
  }
}

List<TimeRegion> _getTimeRegions() {
  final List<TimeRegion> regions = <TimeRegion>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
  final DateTime endTime = startTime.add(const Duration(hours: 5));
  regions.add(
    TimeRegion(
      startTime: startTime,
      endTime: endTime,
      enablePointerInteraction: false,
      color: const Color(0xFF0F8644),
      text: 'Conference',
    ),
  );

  return regions;
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
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

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}
