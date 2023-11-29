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
    );
  }
}
