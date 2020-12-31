import 'package:flutter/material.dart';

 class PickDate{
  static Future<DateTime> selectDate(BuildContext context) async {
    DateTime selectedDate= DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      return selectedDate;
    else
      return null;
  }
 }
