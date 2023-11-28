import 'package:calender/utils/contants/app_colors.dart';
import 'package:flutter/material.dart';

/// asdfasdfasdfasd [Appointment].
class MyCalendarEvent {
  MyCalendarEvent({
    required this.subject,
    required this.start,
    required this.end,
    this.color = AppColors.kGreen,
    this.isAllDay = false,
  });

  String subject;

  DateTime start;

  DateTime end;

  Color color;

  bool isAllDay;
}
