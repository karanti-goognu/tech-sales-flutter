import 'package:flutter/material.dart';

 class PickDate{
  static Future<DateTime> selectDate({BuildContext context, DateTime firstDate, DateTime lastDate}) async {
    DateTime selectedDate= DateTime.now();
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate!=null?firstDate:DateTime(2020),
        lastDate: lastDate!=null?lastDate:DateTime(2025),
    );
    if (picked != null && picked != selectedDate){
      // print(picked);
      return picked;}
    else
      return null;
  }
 }
