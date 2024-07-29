import 'package:flutter/material.dart';

class Appointment {
  final DateTime date;
  final TimeOfDay time;
  final String pet;
  final List<String> services;
  final String details;

  Appointment({
    required this.date,
    required this.time,
    required this.pet,
    required this.services,
    required this.details,
  });
}