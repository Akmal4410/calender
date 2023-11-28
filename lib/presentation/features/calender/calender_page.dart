import 'package:calender/data/data_source/event_data_source.dart';
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
            view: CalendarView.month,
            specialRegions: _getTimeRegions(),
            dataSource: EventDataSource(controller.calendarEvents.value),
            showTodayButton: true,
            selectionDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1.2),
            ),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              showAgenda: true,
              agendaViewHeight: 400,
              agendaItemHeight: 50,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.gotoAddEvent(),
        child: const Icon(Icons.add),
      ),
    );
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
}
