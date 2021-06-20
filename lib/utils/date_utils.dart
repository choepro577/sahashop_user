import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SahaDateUtils {
  static final SahaDateUtils _singleton = SahaDateUtils._internal();

  var formatYMD = DateFormat('yyyy-MM-dd');
  var formatYMD_HHMMSS = DateFormat('yyyy-MM-dd HH:mm:ss');
  var formatYMD_HHMM = DateFormat('yyyy-MM-dd HH:mm');
  var formatDMY = DateFormat('dd-MM-yyyy');
  var formatDMY2 = DateFormat('dd/MM/yyyy');
  var formatDMY3 = DateFormat('dd/MM/yyyy, HH:mm');
  var formatHHmm = DateFormat('HH:mm');
  var formatddMM = DateFormat('dd/MM');
  var formatMMyyyy = DateFormat('MM/yyyy');
  var formatMyyyy = DateFormat('M/yyyy');
  var formatHDM = DateFormat('hh:mm, dd-MM');

  SahaDateUtils._internal();

  factory SahaDateUtils() {
    return _singleton;
  }

  String getStringTimeSpa(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatHDM.format(dateTime);
  }

  String getStringMYYYYFromString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatMyyyy.format(dateTime);
  }

  String getStringMYYYYFromDateTime(DateTime date) {
    return formatMyyyy.format(date);
  }

  String getStringMMyyyyFromDateTime(DateTime dateTime) {
    return formatMMyyyy.format(dateTime);
  }

  String getStringddMMFromDateTime(DateTime dateTime) {
    return formatddMM.format(dateTime);
  }

  String getStringddMMFromString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatddMM.format(dateTime);
  }

  DateTime getDateTimeFormString(String date) {
    return formatYMD_HHMMSS.parse(date);
  }

  DateTime getUtcDateTimeFormString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return DateTime.utc(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );
  }

  String getStringHHmmFormString(String date) {
    var dateTime = getDateTimeFormString(date);
    return formatHHmm.format(dateTime);
  }

  String getStringHHmmFromDateTime(DateTime dateTime) {
    return formatHHmm.format(dateTime);
  }

  String getToDayString() {
    return formatYMD.format(DateTime.now());
  }

  String getDateTimeString() {
    return formatYMD_HHMMSS.format(DateTime.now());
  }

  DateTime getDateTimePlusMinuteString(DateTime dateTime, int minute) {
    return dateTime.add(Duration(minutes: minute));
  }

  DateTime getDateTimeNowPlusMinuteString(int minute) {
    return DateTime.now().add(Duration(minutes: minute));
  }

  String getDateTimeString2(DateTime dateTime) {
    return formatYMD_HHMMSS.format(dateTime);
  }

  String getDateTimeString3(DateTime dateTime) {
    return formatYMD_HHMM.format(dateTime);
  }

  String getDateByFormat(DateTime date) {
    return formatYMD.format(date);
  }

  String getYYMMDD(DateTime dateTime) {
    return formatYMD.format(dateTime);
  }

  String getDDMMYY(DateTime dateTime) {
    return formatDMY.format(dateTime);
  }

  String getDDMM(DateTime dateTime) {
    return formatddMM.format(dateTime);
  }

  String getDDMMYYFromString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatDMY.format(dateTime);
  }

  String getDDMMYY2FromString(String date) {
    DateTime dateTime = getDateTimeFormString(date);
    return formatDMY2.format(dateTime);
  }

  String getDDMMYY2(DateTime dateTime) {
    return formatDMY2.format(dateTime);
  }

  String getDDMMYY3(DateTime dateTime) {
    return formatDMY3.format(dateTime);
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.month == date2.month &&
        date1.year == date2.year &&
        date1.day == date2.day;
  }

  int dayOfYear(DateTime date) {
    return int.parse(DateFormat('D').format(date));
  }

  int weekOfYear(DateTime date) {
    return ((dayOfYear(date) - date.weekday + 10) / 7).floor();
  }

  int getTimeStartMilisecond(String time) {
    DateTime dateTime = DateTime.parse(time);

    return dateTime.millisecondsSinceEpoch;
  }

  double getMinuteInDay(String time) {
    DateTime dateTime = DateTime.parse(time);
    return (dateTime.hour * 60 + dateTime.minute).toDouble();
  }

  String getTimeByMinute(double minutes) {
    String hour =
        (minutes ~/ 60 < 10) ? '0${minutes ~/ 60}' : '${minutes ~/ 60}';
    String minute = ((minutes % 60).toInt() < 10)
        ? '0${(minutes % 60).toInt()}'
        : '${(minutes % 60).toInt()}';
    return '$hour:$minute';
  }

  int getDateOfTheMonth(String time) {
    DateTime dateTime = DateTime.parse(time);
    return dateTime.day;
  }

  int getMonthFromString(String time) {
    DateTime dateTime = DateTime.parse(time);
    return dateTime.month;
  }

  String getYesterday() {
    DateTime now = DateTime.now();
    DateTime yesterday = new DateTime(now.year, now.month, now.day - 1);
    return formatYMD.format(yesterday);
  }

  String getStringEndOfTheDay(DateTime dateTime) {
    DateTime endDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59);
    return getDateTimeString2(endDate);
  }

  String getStringBeginOfTheDay(DateTime dateTime) {
    DateTime endDate =
        DateTime(dateTime.year, dateTime.month, dateTime.day, 00, 00);
    return getDateTimeString2(endDate);
  }

  DateTime getEndOfTheDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59);
  }

  DateTime getBeginOfTheDay(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day, 00, 00);
  }

  String getFirstDayOfWeek() {
    DateTime now = DateTime.now();
    DateTime firtDayOfWeek = new DateTime(
        now.year, now.month, now.day - now.weekday + 1); //tinh thu 2
    return formatYMD.format(firtDayOfWeek);
  }

  String getEndDayOfWeek() {
    DateTime now = DateTime.now();
    DateTime endDayOfWeek =
        new DateTime(now.year, now.month, now.day + (7 - now.weekday));
    return formatYMD.format(endDayOfWeek);
  }

  String getFirstDayOfLastWeek() {
    DateTime now = DateTime.now();
    DateTime firtDayOfWeek =
        new DateTime(now.year, now.month, now.day - now.weekday + 1 - 7);
    return formatYMD.format(firtDayOfWeek);
  }

  String getEndDayOfLastWeek() {
    DateTime now = DateTime.now();
    DateTime endDayOfWeek =
        new DateTime(now.year, now.month, now.day + (7 - now.weekday) - 7);
    return formatYMD.format(endDayOfWeek);
  }

  String getFirstDayOfMonth() {
    DateTime now = DateTime.now();
    DateTime first = new DateTime(now.year, now.month, 1);
    return formatYMD.format(first);
  }

  DateTime getFirstDayOfMonthDateTime() {
    DateTime now = DateTime.now();
    DateTime first = new DateTime(now.year, now.month, 1);
    return first;
  }

  String getEndDayOfMonth() {
    DateTime now = DateTime.now();
    DateTime end = new DateTime(now.year, now.month + 1, 0);
    return formatYMD.format(end);
  }

  DateTime getEndDayOfMonthDateTime() {
    DateTime now = DateTime.now();
    DateTime end = new DateTime(now.year, now.month + 1, 0);
    return end;
  }

  String getFirstDayOfLastMonth() {
    DateTime now = DateTime.now();
    DateTime first = new DateTime(now.year, now.month - 1, 1);
    return formatYMD.format(first);
  }

  String getEndDayOfLastMonth() {
    DateTime now = DateTime.now();
    DateTime end = new DateTime(now.year, now.month, 0);
    return formatYMD.format(end);
  }

  String getFirstDayOfThisQuarter() {
    DateTime now = DateTime.now();
    DateTime first;
    if (now.month < 4) {
      first = DateTime(now.year, 1, 1);
    } else if (now.month < 7) {
      first = DateTime(now.year, 4, 1);
    } else if (now.month < 10) {
      first = DateTime(now.year, 7, 1);
    } else {
      first = DateTime(now.year, 10, 1);
    }
    return formatYMD.format(first);
  }

  String getEndDayOfThisQuarter() {
    DateTime now = DateTime.now();
    DateTime end;
    if (now.month < 4) {
      end = DateTime(now.year, 4, 0);
    } else if (now.month < 7) {
      end = DateTime(now.year, 7, 0);
    } else if (now.month < 10) {
      end = DateTime(now.year, 10, 0);
    } else {
      end = DateTime(now.year + 1, 1, 0);
    }
    return formatYMD.format(end);
  }

  String getFirstDayOfLastQuarter() {
    DateTime now = DateTime.now();
    DateTime first;
    if (now.month < 4) {
      first = DateTime(now.year, 10, 1);
    } else if (now.month < 7) {
      first = DateTime(now.year, 1, 1);
    } else if (now.month < 10) {
      first = DateTime(now.year, 4, 1);
    } else {
      first = DateTime(now.year, 7, 1);
    }
    return formatYMD.format(first);
  }

  String getEndDayOfLastQuarter() {
    DateTime now = DateTime.now();
    DateTime end;
    if (now.month < 4) {
      end = DateTime(now.year + 1, 1, 0);
    } else if (now.month < 7) {
      end = DateTime(now.year, 4, 0);
    } else if (now.month < 10) {
      end = DateTime(now.year, 7, 0);
    } else {
      end = DateTime(now.year, 10, 0);
    }
    return formatYMD.format(end);
  }

  String getFirstDayOfThisYear() {
    DateTime now = DateTime.now();
    DateTime first = DateTime(now.year, 1, 1);
    return formatYMD.format(first);
  }

  String getEndDayOfThisYear() {
    DateTime now = DateTime.now();
    DateTime end = DateTime(now.year + 1, 1, 0);
    return formatYMD.format(end);
  }

  String getDMH(String dateStr) {
    DateTime dateTime = DateTime.parse(dateStr);
    return getDMHfromDateTime(dateTime);
  }

  String getDMHfromDateTime(DateTime dateTime) {
    return DateFormat('MM-dd HH:mm').format(dateTime);
  }

  String getDMHfromString(String dateTime) {
    DateTime date = DateTime.now();
    if (dateTime != null && dateTime.isNotEmpty) {
      date = DateTime.parse(dateTime);
    }
    return getDMHfromDateTime(date);
  }

  String getHHMMSS(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  String getHHMM(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  Future<TimeOfDay?> selectTime(BuildContext context, TimeOfDay initTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != initTime) {
      return picked;
    }
    ;
    return null;
  }
}
