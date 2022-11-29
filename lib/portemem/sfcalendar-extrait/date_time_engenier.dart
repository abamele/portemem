import 'package:portemem/portemem/sfcalendar-extrait/appointment_helper.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendar_view_day.dart';
import 'package:syncfusion_flutter_core/core.dart';




// ignore: avoid_classes_with_only_static_members
/// Holds the static helper methods used for date calculation in calendar.
class DateTimeHelperT {
  /// Calculate the visible dates count based on calendar view
  static int getViewDatesCount(CalendarViewT calendarView, int numberOfWeeks,
      int daysCount, List<int>? nonWorkingDays) {
    switch (calendarView) {
      case CalendarViewT.month:
        return DateTime.daysPerWeek * numberOfWeeks;
      case CalendarViewT.week:
      case CalendarViewT.timelineWeek:
        return (daysCount >= 1 && daysCount <= 7)
            ? daysCount
            : DateTime.daysPerWeek;
      case CalendarViewT.workWeek:
      case CalendarViewT.timelineWorkWeek:
        return (daysCount >= 1 && daysCount <= 7)
            ? daysCount
            : DateTime.daysPerWeek - nonWorkingDays!.length;
      case CalendarViewT.timelineDay:
      case CalendarViewT.day:
        return (daysCount >= 1 && daysCount <= 7) ? daysCount : 1;
      case CalendarViewT.schedule:
        return 1;
      case CalendarViewT.timelineMonth:

      /// 6 represents the number of weeks in view, we have used this static,
      /// since timeline month doesn't support the number of weeks in view.
        return DateTime.daysPerWeek * 6;
    }
  }

  /// Returns the list of current month dates alone from the dates passed.
  static List<DateTime> getCurrentMonthDates(List<DateTime> visibleDates) {
    final int visibleDatesCount = visibleDates.length;
    final int currentMonth = visibleDates[visibleDatesCount ~/ 2].month;
    final List<DateTime> currentMonthDates = <DateTime>[];
    for (int i = 0; i < visibleDatesCount; i++) {
      final DateTime currentVisibleDate = visibleDates[i];
      if (currentVisibleDate.month != currentMonth) {
        continue;
      }

      currentMonthDates.add(currentVisibleDate);
    }

    return currentMonthDates;
  }

  /// Calculate the next view visible start date based on calendar view.
  static DateTime getNextViewStartDate(
      CalendarViewT calendarView,
      int numberOfWeeksInView,
      DateTime date,
      int visibleDatesCount,
      List<int>? nonWorkingDays) {
    switch (calendarView) {
      case CalendarViewT.month:
        {
          return numberOfWeeksInView == 6
              ? DateTimeHelperT.getDateTimeValue(getNextMonthDate(date))
              : DateTimeHelperT.getDateTimeValue(
              addDays(date, numberOfWeeksInView * DateTime.daysPerWeek));
        }
      case CalendarViewT.timelineMonth:
        return DateTimeHelperT.getDateTimeValue(getNextMonthDate(date));
      case CalendarViewT.week:
      case CalendarViewT.timelineWeek:
        return DateTimeHelperT.getDateTimeValue(
            addDays(date, visibleDatesCount));
      case CalendarViewT.workWeek:
      case CalendarViewT.timelineWorkWeek:
        {
          final int nonWorkingDaysCount =
          nonWorkingDays == null ? 0 : nonWorkingDays.length;
          if (visibleDatesCount + nonWorkingDaysCount == 7) {
            return DateTimeHelperT.getDateTimeValue(
                addDays(date, visibleDatesCount + nonWorkingDaysCount));
          }

          for (int i = 0; i <= visibleDatesCount; i++) {
            final dynamic currentDate = addDays(date, i);
            if (nonWorkingDays != null &&
                nonWorkingDays.contains(currentDate.weekday)) {
              visibleDatesCount++;
            }
          }
          return DateTimeHelperT.getDateTimeValue(
              addDays(date, visibleDatesCount));
        }
      case CalendarViewT.day:
      case CalendarViewT.timelineDay:
        return DateTimeHelperT.getDateTimeValue(
            addDays(date, visibleDatesCount));
      case CalendarViewT.schedule:
        return DateTimeHelperT.getDateTimeValue(addDays(date, 1));
    }
  }

  /// Calculate the previous view visible start date based on calendar view.
  static DateTime getPreviousViewStartDate(
      CalendarViewT calendarView,
      int numberOfWeeksInView,
      DateTime date,
      int visibleDatesCount,
      List<int>? nonWorkingDays) {
    switch (calendarView) {
      case CalendarViewT.month:
        {
          return numberOfWeeksInView == 6
              ? DateTimeHelperT.getDateTimeValue(getPreviousMonthDate(date))
              : DateTimeHelperT.getDateTimeValue(
              addDays(date, -numberOfWeeksInView * DateTime.daysPerWeek));
        }
      case CalendarViewT.timelineMonth:
        return DateTimeHelperT.getDateTimeValue(getPreviousMonthDate(date));
      case CalendarViewT.week:
      case CalendarViewT.timelineWeek:
        return DateTimeHelperT.getDateTimeValue(
            addDays(date, -visibleDatesCount));
      case CalendarViewT.workWeek:
      case CalendarViewT.timelineWorkWeek:
        {
          final int nonWorkingDaysCount =
          nonWorkingDays == null ? 0 : nonWorkingDays.length;
          if (visibleDatesCount + nonWorkingDaysCount == 7) {
            return DateTimeHelperT.getDateTimeValue(
                addDays(date, -visibleDatesCount - nonWorkingDaysCount));
          }
          for (int i = 1; i <= visibleDatesCount; i++) {
            final dynamic currentDate = addDays(date, -i);
            if (nonWorkingDays != null &&
                nonWorkingDays.contains(currentDate.weekday)) {
              visibleDatesCount++;
            }
          }
          return DateTimeHelperT.getDateTimeValue(
              addDays(date, -visibleDatesCount));
        }
      case CalendarViewT.day:
      case CalendarViewT.timelineDay:
        return DateTimeHelperT.getDateTimeValue(
            addDays(date, -visibleDatesCount));
      case CalendarViewT.schedule:
        return DateTimeHelperT.getDateTimeValue(addDays(date, -1));
    }
  }

  static DateTime _getPreviousValidDate(
      DateTime prevViewDate, List<int> nonWorkingDays) {
    DateTime previousDate =
    DateTimeHelperT.getDateTimeValue(addDays(prevViewDate, -1));
    while (nonWorkingDays.contains(previousDate.weekday)) {
      previousDate = DateTimeHelperT.getDateTimeValue(addDays(previousDate, -1));
    }
    return previousDate;
  }

  static DateTime _getNextValidDate(
      DateTime nextDate, List<int> nonWorkingDays) {
    DateTime nextViewDate =
    DateTimeHelperT.getDateTimeValue(addDays(nextDate, 1));
    while (nonWorkingDays.contains(nextViewDate.weekday)) {
      nextViewDate = DateTimeHelperT.getDateTimeValue(addDays(nextViewDate, 1));
    }
    return nextViewDate;
  }

  /// Return index value of the date in dates collection.
  /// if the date in between the dates collection but dates collection does not
  /// have a date value then it return next date index.
  /// Eg., If the dates collection have Jan 4, Jan 5, Jan 7, Jan 8 and Jan 9,
  /// and the date value as Jan 6 then it return index as 2(Jan 7).
  static int getIndex(List<DateTime> dates, DateTime date) {
    if (date.isBefore(dates[0])) {
      return 0;
    }

    final int datesCount = dates.length;
    if (date.isAfter(dates[datesCount - 1])) {
      return datesCount - 1;
    }

    for (int i = 0; i < datesCount; i++) {
      final DateTime visibleDate = dates[i];
      if (isSameOrBeforeDate(visibleDate, date)) {
        return i;
      }
    }

    return -1;
  }

  /// Get the exact visible date index for date, if the date collection
  /// does not contains the date value then it return -1 value.
  static int getVisibleDateIndex(List<DateTime> dates, DateTime date) {
    final int count = dates.length;
    if (!isDateWithInDateRange(dates[0], dates[count - 1], date)) {
      return -1;
    }

    for (int i = 0; i < count; i++) {
      if (isSameDate(dates[i], date)) {
        return i;
      }
    }

    return -1;
  }

  /// Check the current calendar view is valid for move to previous view or not.
  static bool canMoveToPreviousView(
      CalendarViewT calendarView,
      int numberOfWeeksInView,
      DateTime minDate,
      DateTime maxDate,
      List<DateTime> visibleDates,
      List<int> nonWorkingDays,
      [bool isRTL = false]) {
    if (isRTL) {
      return canMoveToNextView(calendarView, numberOfWeeksInView, minDate,
          maxDate, visibleDates, nonWorkingDays);
    }

    switch (calendarView) {
      case CalendarViewT.month:
        {
          if (numberOfWeeksInView != 6) {
            final DateTime prevViewDate =
            DateTimeHelperT.getDateTimeValue(addDays(visibleDates[0], -1));
            if (!isSameOrAfterDate(minDate, prevViewDate)) {
              return false;
            }
          } else {
            final DateTime currentDate = visibleDates[visibleDates.length ~/ 2];
            final DateTime previousDate = DateTimeHelperT.getDateTimeValue(
                getPreviousMonthDate(currentDate));
            if ((previousDate.month < minDate.month &&
                previousDate.year == minDate.year) ||
                previousDate.year < minDate.year) {
              return false;
            }
          }
        }
        break;
      case CalendarViewT.timelineMonth:
        {
          final DateTime prevViewDate =
          DateTimeHelperT.getDateTimeValue(addDays(visibleDates[0], -1));
          if (!isSameOrAfterDate(minDate, prevViewDate)) {
            return false;
          }
        }
        break;
      case CalendarViewT.day:
      case CalendarViewT.week:
      case CalendarViewT.timelineDay:
      case CalendarViewT.timelineWeek:
        {
          DateTime prevViewDate = visibleDates[0];
          prevViewDate =
              DateTimeHelperT.getDateTimeValue(addDays(prevViewDate, -1));
          if (!isSameOrAfterDate(minDate, prevViewDate)) {
            return false;
          }
        }
        break;
      case CalendarViewT.timelineWorkWeek:
      case CalendarViewT.workWeek:
        {
          final DateTime previousDate =
          _getPreviousValidDate(visibleDates[0], nonWorkingDays);
          if (!isSameOrAfterDate(minDate, previousDate)) {
            return false;
          }
        }
        break;
      case CalendarViewT.schedule:
        return true;
    }

    return true;
  }

  /// Check the current calendar view is valid for move to next view or not.
  static bool canMoveToNextView(
      CalendarViewT calendarView,
      int numberOfWeeksInView,
      DateTime minDate,
      DateTime maxDate,
      List<DateTime> visibleDates,
      List<int> nonWorkingDays,
      [bool isRTL = false]) {
    if (isRTL) {
      return canMoveToPreviousView(calendarView, numberOfWeeksInView, minDate,
          maxDate, visibleDates, nonWorkingDays);
    }

    switch (calendarView) {
      case CalendarViewT.month:
        {
          if (numberOfWeeksInView != 6) {
            final DateTime nextViewDate = DateTimeHelperT.getDateTimeValue(
                addDays(visibleDates[visibleDates.length - 1], 1));
            if (!isSameOrBeforeDate(maxDate, nextViewDate)) {
              return false;
            }
          } else {
            final DateTime currentDate = visibleDates[visibleDates.length ~/ 2];
            final DateTime nextDate =
            DateTimeHelperT.getDateTimeValue(getNextMonthDate(currentDate));
            if ((nextDate.month > maxDate.month &&
                nextDate.year == maxDate.year) ||
                nextDate.year > maxDate.year) {
              return false;
            }
          }
        }
        break;
      case CalendarViewT.timelineMonth:
        {
          final DateTime nextViewDate = DateTimeHelperT.getDateTimeValue(
              addDays(visibleDates[visibleDates.length - 1], 1));
          if (!isSameOrBeforeDate(maxDate, nextViewDate)) {
            return false;
          }
        }
        break;
      case CalendarViewT.day:
      case CalendarViewT.week:
      case CalendarViewT.timelineDay:
      case CalendarViewT.timelineWeek:
        {
          final DateTime nextViewDate = DateTimeHelperT.getDateTimeValue(
              addDays(visibleDates[visibleDates.length - 1], 1));
          if (!isSameOrBeforeDate(maxDate, nextViewDate)) {
            return false;
          }
        }
        break;
      case CalendarViewT.workWeek:
      case CalendarViewT.timelineWorkWeek:
        {
          final DateTime nextDate = _getNextValidDate(
              visibleDates[visibleDates.length - 1], nonWorkingDays);
          if (!isSameOrBeforeDate(maxDate, nextDate)) {
            return false;
          }
        }
        break;
      case CalendarViewT.schedule:
        return true;
    }

    return true;
  }

  /// Converts the given dynamic data into date time data.
  static DateTime getDateTimeValue(dynamic date) {
    late final DateTime dateTimeData;
    if (date is DateTime) {
      dateTimeData = date;
    }

    return dateTimeData;
  }

  /// Returns week number for the given date.
  static int getWeekNumberOfYear(DateTime date) {
    final DateTime yearEndDate = DateTime(date.year - 1, 12, 31);
    final int dayOfYear =
        AppointmentHelperT.getDifference(yearEndDate, date).inDays;
    int weekNumber = (dayOfYear - date.weekday + 10) ~/ 7;
    if (weekNumber < 1) {
      weekNumber = getWeeksInYear(date.year - 1);
    } else if (weekNumber > getWeeksInYear(date.year)) {
      weekNumber = 1;
    }
    return weekNumber;
  }

  /// Get the weeks in year
  static int getWeeksInYear(int year) {
    int P(int y) => (y + (y ~/ 4) - (y ~/ 100) + (y ~/ 400)) % 7;
    if (P(year) == 4 || P(year - 1) == 3) {
      return 53;
    }
    return 52;
  }
}
