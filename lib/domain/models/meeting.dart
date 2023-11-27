import 'package:flutter/material.dart';

/// asdfasdfasdfasd [Appointment].
class Meeting {
  Meeting(
    this.subject,
    this.start,
    this.end,
    this.color,
    this.isAllDay,
  );

  String subject;

  DateTime start;

  DateTime end;

  Color color;

  bool isAllDay;
}
