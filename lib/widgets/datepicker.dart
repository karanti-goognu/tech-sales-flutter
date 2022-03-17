import 'package:flutter/material.dart';

 class PickDate{
  static Future<DateTime?> selectDate({required BuildContext context, DateTime? firstDate, DateTime? lastDate}) async {
    DateTime selectedDate= DateTime.now();
    int thisYear= selectedDate.year;
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate!=null?firstDate:DateTime(thisYear),
        lastDate: lastDate!=null?lastDate:DateTime(thisYear+2),
    );
    if (picked != null && picked != selectedDate){
      return picked;}
    else
      return null;
  }
 }
