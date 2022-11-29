import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';

import 'package:portemem/portemem/sfcalendar-extrait/appointment.dart';
import 'package:portemem/portemem/sfcalendar-extrait/appointment_helper.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendaer_controller.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendar_data_source.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendar_ressource.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendar_theme.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendar_view_day.dart';
import 'package:portemem/portemem/sfcalendar-extrait/date_time_engenier.dart';
import 'package:portemem/portemem/sfcalendar-extrait/event_args.dart';
import 'package:portemem/portemem/sfcalendar-extrait/month_view_setting.dart';
import 'package:portemem/portemem/sfcalendar-extrait/ressource_view_setting.dart';
import 'package:portemem/portemem/sfcalendar-extrait/scadule_view_setting.dart';
import 'package:portemem/portemem/sfcalendar-extrait/sfcalendar.dart';
import 'package:portemem/portemem/sfcalendar-extrait/time_region.dart';
import 'package:portemem/portemem/sfcalendar-extrait/time_slot_view_setting.dart';





/// All day appointment height
const double kAllDayAppointmentHeight = 20;

/// Signature for callback that used to get and update the calendar
/// state details.
typedef UpdateCalendarStateT = void Function(
    UpdateCalendarStateDetailsT updateCalendarStateDetails);

//// Extra small devices (phones, 600px and down)
//// @media only screen and (max-width: 600px) {...}
////
//// Small devices (portrait tablets and large phones, 600px and up)
//// @media only screen and (min-width: 600px) {...}
////
//// Medium devices (landscape tablets, 768px and up)
//// media only screen and (min-width: 768px) {...}
////
//// Large devices (laptops/desktops, 992px and up)
//// media only screen and (min-width: 992px) {...}
////
//// Extra large devices (large laptops and desktops, 1200px and up)
//// media only screen and (min-width: 1200px) {...}
//// Default width to render the mobile UI in web, if the device width exceeds
//// the given width agenda view will render the web UI.
const double _kMobileViewWidth = 767;

// ignore: avoid_classes_with_only_static_members
/// Holds the static helper methods used for calendar views rendering
/// in calendar.
class CalendarViewHelperT {
  /// Return the current context direction is RTL or not.
  static bool isRTLLayout(BuildContext context) {
    final TextDirection direction = Directionality.of(context);
    return direction == TextDirection.rtl;
  }

  /// Determine the current platform needs mobile platform UI.
  /// The [_kMobileViewWidth] value is a breakpoint for mobile platform.
  static bool isMobileLayoutUI(double width, bool isMobileLayout) {
    return isMobileLayout || width <= _kMobileViewWidth;
  }

  /// Determine the current platform is mobile platform(android or iOS).
  static bool isMobileLayout(TargetPlatform platform) {
    if (kIsWeb) {
      return false;
    }

    return platform == TargetPlatform.android || platform == TargetPlatform.iOS;
  }

  /// Check the list is empty or not.
  static bool isEmptyList<T>(List<T>? value) {
    if (value == null || value.isEmpty) {
      return true;
    }

    return false;
  }

  /// Check the date as current month date when the month leading and trailing
  /// dates not shown and its row count as 6.
  static bool isCurrentMonthDate(int weekRowCount,
      bool showLeadingTrailingDates, int currentMonth, DateTime date) {
    if (isLeadingAndTrailingDatesVisible(
        weekRowCount, showLeadingTrailingDates)) {
      return true;
    }

    if (date.month == currentMonth) {
      return true;
    }

    return false;
  }

  /// Check the leading and trailing dates visible or not.
  static bool isLeadingAndTrailingDatesVisible(
      int weekRowCount, bool showLeadingTrailingDates) {
    return weekRowCount != 6 || showLeadingTrailingDates;
  }

  /// Check both the dates collection dates are equal or not.
  static bool isDateCollectionEqual(
      List<DateTime>? originalDates, List<DateTime>? copyDates) {
    if (originalDates == copyDates) {
      return true;
    }

    if (originalDates == null || copyDates == null) {
      return false;
    }

    final int datesCount = originalDates.length;
    if (datesCount != copyDates.length) {
      return false;
    }

    for (int i = 0; i < datesCount; i++) {
      if (!isSameDate(originalDates[i], copyDates[i])) {
        return false;
      }
    }

    return true;
  }

  /// Return the copy of list passed.
  static List<T>? cloneList<T>(List<T>? value) {
    if (value == null) {
      return null;
    }
    return value.sublist(0);
  }

  /// Check both the collections are equal or not.
  static bool isCollectionEqual<T>(List<T>? collection1, List<T>? collection2) {
    if (collection1 == collection2) {
      return true;
    }

    if (isEmptyList(collection1) && isEmptyList(collection2)) {
      return true;
    }

    if (collection1 == null || collection2 == null) {
      return false;
    }

    final int collectionCount = collection1.length;
    if (collectionCount != collection2.length) {
      return false;
    }

    for (int i = 0; i < collectionCount; i++) {
      if (collection1[i] != collection2[i]) {
        return false;
      }
    }

    return true;
  }

  /// Check whether the date collection contains the date value or not.
  static bool isDateInDateCollection(List<DateTime>? dates, DateTime date) {
    if (dates == null || dates.isEmpty) {
      return false;
    }

    for (final DateTime currentDate in dates) {
      if (isSameDate(currentDate, date)) {
        return true;
      }
    }

    return false;
  }

  /// Return schedule view appointment height and its value based on
  /// schedule view settings and month view settings.
  static double getScheduleAppointmentHeight(
      MonthViewSettingsT? monthViewSettings,
      ScheduleViewSettingsT? scheduleViewSettings) {
    return monthViewSettings != null
        ? (monthViewSettings.agendaItemHeight == -1
        ? 50
        : monthViewSettings.agendaItemHeight)
        : (scheduleViewSettings == null ||
        scheduleViewSettings.appointmentItemHeight == -1
        ? 50
        : scheduleViewSettings.appointmentItemHeight);
  }

  /// Return schedule view all day appointment height and its value based on
  /// schedule view settings and month view settings.
  static double getScheduleAllDayAppointmentHeight(
      MonthViewSettingsT? monthViewSettings,
      ScheduleViewSettingsT? scheduleViewSettings) {
    return monthViewSettings != null
        ? (monthViewSettings.agendaItemHeight == -1
        ? 210
        : monthViewSettings.agendaItemHeight)
        : (scheduleViewSettings == null ||
        scheduleViewSettings.appointmentItemHeight == -1
        ? 25
        : scheduleViewSettings.appointmentItemHeight);
  }

  /// Returns the height for an resource item to render the resource within
  /// it in the resource panel.
  static double getResourceItemHeight(
      double resourceViewSize,
      double timelineViewHeight,
      ResourceViewSettingsT resourceViewSettings,
      int resourceCount) {
    /// The combined padding value between the circle and the display name text
    final double textPadding = resourceViewSettings.showAvatar ? 10 : 0;

    /// To calculate the resource item height based on visible resource count,
    /// added this condition calculated the resource item height based on
    /// visible resource count.
    if (resourceViewSettings.visibleResourceCount > 0) {
      return timelineViewHeight / resourceViewSettings.visibleResourceCount;
    }

    double itemHeight = timelineViewHeight + textPadding;

    /// Added this condition to check if the visible resource count is `-1`, we
    /// have calculated the resource item height based on the resource panel
    /// width and the view height, the smallest of this will set as the
    /// resource item height.
    if (timelineViewHeight > resourceViewSize &&
        resourceViewSettings.visibleResourceCount < 0) {
      itemHeight = resourceViewSize + textPadding;
    }

    /// Modified the resource height if the visible resource count is `-1` on
    /// this scenario if the resource count is less, to avoid the empty white
    /// space on the screen height, we calculated the resource item height to
    /// fill into the available screen height.
    return resourceCount * itemHeight < timelineViewHeight
        ? timelineViewHeight / resourceCount
        : itemHeight;
  }

  /// Check and returns whether the resource panel can be added or not in the
  /// calendar.
  static bool isResourceEnabled(
      CalendarDataSourceT? dataSource, CalendarViewT view) {
    return isTimelineView(view) &&
        dataSource != null &&
        dataSource.resources != null &&
        dataSource.resources!.isNotEmpty;
  }

  /// Return the appointment semantics text for the all the appointment
  /// views(all day panel, time slot panel, agenda view).
  static String getAppointmentSemanticsText(CalendarAppointmentT appointment) {
    if (appointment.isAllDay) {
      return '${appointment.subject}All day';
    } else if (appointment.isSpanned ||
        AppointmentHelperT.getDifference(
            appointment.startTime, appointment.endTime)
            .inDays >
            0) {
      // ignore: lines_longer_than_80_chars
      return '${appointment.subject}${DateFormat('hh mm a dd/MMMM/yyyy').format(appointment.startTime)}to${DateFormat('hh mm a dd/MMMM/yyyy').format(appointment.endTime)}';
    } else {
      // ignore: lines_longer_than_80_chars
      return '${appointment.subject}${DateFormat('hh mm a').format(appointment.startTime)}-${DateFormat('hh mm a dd/MMMM/yyyy').format(appointment.endTime)}';
    }
  }

  /// Get the today text color based on today highlight color and today text
  /// style.
  static Color? getTodayHighlightTextColor(Color? todayHighlightColor,
      TextStyle? todayTextStyle, SfCalendarThemeDataT calendarTheme) {
    Color? todayTextColor = todayHighlightColor;
    if (todayTextColor != null && todayTextColor == Colors.transparent) {
      todayTextColor = todayTextStyle != null
          ? todayTextStyle.color
          : calendarTheme.todayTextStyle!.color;
    }

    return todayTextColor;
  }

  /// Get the exact the time from the position and the date time includes
  /// minutes value.
  static double getTimeToPosition(Duration duration,
      TimeSlotViewSettingsT timeSlotViewSettings, double minuteHeight) {
    final int startHour = timeSlotViewSettings.startHour.toInt();
    final Duration startDuration = Duration(
        hours: startHour,
        minutes: ((timeSlotViewSettings.startHour - startHour) * 60).toInt());
    final Duration difference = duration - startDuration;
    return difference.isNegative ? 0 : difference.inMinutes * minuteHeight;
  }

  /// Returns the time interval value based on the given start time, end time
  /// and time interval value of time slot view settings, the time interval will
  /// be auto adjust if the given time interval doesn't cover the given start
  /// and end time values, i.e: if the startHour set as 10 and endHour set as
  /// 20 and the timeInterval value given as 180 means we cannot divide the 10
  /// hours into 3  hours, hence the time interval will be auto adjusted to 200
  /// based on the given properties.
  static int getTimeInterval(TimeSlotViewSettingsT settings) {
    double defaultLinesCount = 24;
    double totalMinutes = 0;

    if (settings.startHour >= 0 &&
        settings.endHour >= settings.startHour &&
        settings.endHour <= 24) {
      defaultLinesCount = settings.endHour - settings.startHour;
    }

    totalMinutes = defaultLinesCount * 60;

    final int timeIntervalMinutes = settings.timeInterval.inMinutes;
    if (timeIntervalMinutes >= 0 &&
        timeIntervalMinutes <= totalMinutes &&
        totalMinutes.round() % timeIntervalMinutes == 0) {
      return timeIntervalMinutes;
    } else if (timeIntervalMinutes >= 0 &&
        timeIntervalMinutes <= totalMinutes) {
      return _getNearestValue(timeIntervalMinutes, totalMinutes);
    } else {
      return 60;
    }
  }

  /// Returns the horizontal lines count for a single day in day/week/workweek and time line view
  static double getHorizontalLinesCount(
      TimeSlotViewSettingsT settings, CalendarViewT view) {
    if (view == CalendarViewT.timelineMonth) {
      return 1;
    }

    double defaultLinesCount = 24;
    double totalMinutes = 0;
    final int timeInterval = getTimeInterval(settings);

    if (settings.startHour >= 0 &&
        settings.endHour >= settings.startHour &&
        settings.endHour <= 24) {
      defaultLinesCount = settings.endHour - settings.startHour;
    }

    totalMinutes = defaultLinesCount * 60;

    return totalMinutes / timeInterval;
  }

  static int _getNearestValue(int timeInterval, double totalMinutes) {
    timeInterval++;
    if (totalMinutes.round() % timeInterval == 0) {
      return timeInterval;
    }

    return _getNearestValue(timeInterval, totalMinutes);
  }

  /// Check both the time slot date values are same or not.
  static bool isSameTimeSlot(DateTime? date1, DateTime? date2) {
    if (date1 == date2) {
      return true;
    }

    if (date1 == null || date2 == null) {
      return false;
    }

    return isSameDate(date1, date2) &&
        date1.hour == date2.hour &&
        date1.minute == date2.minute;
  }

  /// Return time label size based on calendar view of calendar widget.
  static double getTimeLabelWidth(
      double timeLabelViewWidth, CalendarViewT view) {
    if (view == CalendarViewT.timelineMonth) {
      return 0;
    }

    if (timeLabelViewWidth != -1) {
      return timeLabelViewWidth;
    }

    switch (view) {
      case CalendarViewT.timelineDay:
      case CalendarViewT.timelineWeek:
      case CalendarViewT.timelineWorkWeek:
        return 30;
      case CalendarViewT.day:
      case CalendarViewT.week:
      case CalendarViewT.workWeek:
        return 50;
      case CalendarViewT.schedule:
      case CalendarViewT.month:
      case CalendarViewT.timelineMonth:
        return 0;
    }
  }

  /// Return the view header height based on calendar view of calendar widget.
  static double getViewHeaderHeight(
      double viewHeaderHeight, CalendarViewT view) {
    if (viewHeaderHeight != -1) {
      return viewHeaderHeight;
    }

    switch (view) {
      case CalendarViewT.day:
      case CalendarViewT.week:
      case CalendarViewT.workWeek:
        return 60;
      case CalendarViewT.month:
        return 25;
      case CalendarViewT.timelineDay:
      case CalendarViewT.timelineWeek:
      case CalendarViewT.timelineWorkWeek:
      case CalendarViewT.timelineMonth:
        return 30;
      case CalendarViewT.schedule:
        return 0;
    }
  }

  /// Check the calendar view is day or not.
  static bool isDayView(CalendarViewT view, int numberOfDays,
      List<int>? nonWorkingDays, int numberOfWeeks) {
    final int daysCount = DateTimeHelperT.getViewDatesCount(
        view, numberOfWeeks, numberOfDays, nonWorkingDays);
    if ((view == CalendarViewT.day ||
        view == CalendarViewT.week ||
        view == CalendarViewT.workWeek) &&
        daysCount == 1) {
      return true;
    }
    return false;
  }

  /// Return the cell end padding based on platform of calendar widget.
  static double getCellEndPadding(double cellEndPadding, bool isMobile) {
    if (cellEndPadding != -1) {
      return cellEndPadding;
    }

    if (isMobile) {
      return 3;
    }

    return 6;
  }

  /// method to check whether the view changed callback can triggered or not.
  static bool shouldRaiseViewChangedCallback(
      ViewChangedCallbackT? onViewChanged) {
    return onViewChanged != null;
  }

  /// method to check whether the on tap callback can triggered or not.
  static bool shouldRaiseCalendarTapCallback(CalendarTapCallbackT? onTap) {
    return onTap != null;
  }

  /// method to check whether the long press callback can triggered or not.
  static bool shouldRaiseCalendarLongPressCallback(
      CalendarLongPressCallbackT? onLongPress) {
    return onLongPress != null;
  }

  //// method to check whether the selection changed callback can triggered or not.
  static bool shouldRaiseCalendarSelectionChangedCallback(
      CalendarSelectionChangedCallbackT? onSelectionChanged) {
    return onSelectionChanged != null;
  }

  /// Method to check whether the appointment resize start callback can trigger
  /// or not.
  static bool shouldRaiseAppointmentResizeStartCallback(
      AppointmentResizeStartCallbackT? onAppointmentResizeStart) {
    return onAppointmentResizeStart != null;
  }

  /// Method to check whether the appointment resize update callback can trigger
  /// or not.
  static bool shouldRaiseAppointmentResizeUpdateCallback(
      AppointmentResizeUpdateCallbackT? onAppointmentResizeUpdate) {
    return onAppointmentResizeUpdate != null;
  }

  /// Method to check whether the appointment resize end callback can trigger
  /// or not.
  static bool shouldRaiseAppointmentResizeEndCallback(
      AppointmentResizeEndCallbackT? onAppointmentResizeEnd) {
    return onAppointmentResizeEnd != null;
  }

  /// method that raise the calendar tapped callback with the given parameters
  static void raiseCalendarTapCallback(
      SfCalendarT calendar,
      DateTime? date,
      List<dynamic>? appointments,
      CalendarElementT element,
      CalendarResourceT? resource) {
    calendar.onTap!(CalendarTapDetailsT(appointments, date, element, resource));
  }

  /// Method that raise the calendar long press callback with given parameters.
  static void raiseCalendarLongPressCallback(
      SfCalendarT calendar,
      DateTime? date,
      List<dynamic>? appointments,
      CalendarElementT element,
      CalendarResourceT? resource) {
    calendar.onLongPress!(
        CalendarLongPressDetailsT(appointments, date, element, resource));
  }

  /// method that raise the calendar selection changed callback
  /// with the given parameters
  static void raiseCalendarSelectionChangedCallback(
      SfCalendarT calendar, DateTime? date, CalendarResourceT? resource) {
    calendar.onSelectionChanged!(CalendarSelectionDetailsT(date, resource));
  }

  /// method that raises the visible dates changed callback with the given
  /// parameters
  static void raiseViewChangedCallback(
      SfCalendarT calendar, List<DateTime> visibleDates) {
    calendar.onViewChanged!(ViewChangedDetailsT(visibleDates));
  }

  /// Method  that raises the appointment resize start callback with the given
  /// parameters.
  static void raiseAppointmentResizeStartCallback(
      SfCalendarT calendar, dynamic appointment, CalendarResourceT? resource) {
    calendar.onAppointmentResizeStart!(
        AppointmentResizeStartDetailsT(appointment, resource));
  }

  /// Method  that raises the appointment resize update callback with the given
  /// parameters.
  static void raiseAppointmentResizeUpdateCallback(
      SfCalendarT calendar,
      dynamic appointment,
      CalendarResourceT? resource,
      DateTime? resizingTime,
      Offset resizingOffset) {
    calendar.onAppointmentResizeUpdate!(AppointmentResizeUpdateDetailsT(
        appointment, resource, resizingTime, resizingOffset));
  }

  /// Method  that raises the appointment resize end callback with the given
  /// parameters.
  static void raiseAppointmentResizeEndCallback(
      SfCalendarT calendar,
      dynamic appointment,
      CalendarResourceT? resource,
      DateTime? startTime,
      DateTime? endTime) {
    calendar.onAppointmentResizeEnd!(
        AppointmentResizeEndDetailsT(appointment, resource, startTime, endTime));
  }

  /// Check the calendar view is timeline view or not.
  static bool isTimelineView(CalendarViewT view) {
    switch (view) {
      case CalendarViewT.timelineDay:
      case CalendarViewT.timelineWeek:
      case CalendarViewT.timelineWorkWeek:
      case CalendarViewT.timelineMonth:
        return true;
      case CalendarViewT.day:
      case CalendarViewT.week:
      case CalendarViewT.workWeek:
      case CalendarViewT.month:
      case CalendarViewT.schedule:
        return false;
    }
  }

  /// converts the given schedule appointment collection to their custom
  /// appointment collection
  static List<dynamic> getCustomAppointments(
      List<CalendarAppointmentT>? appointments, CalendarDataSourceT? dataSource) {
    final List<dynamic> customAppointments = <dynamic>[];
    if (appointments == null) {
      return customAppointments;
    }

    for (int i = 0; i < appointments.length; i++) {
      customAppointments.add(getAppointmentDetail(appointments[i], dataSource));
    }

    return customAppointments;
  }

  /// Returns the appointment details with given appointment type.
  static dynamic getAppointmentDetail(
      CalendarAppointmentT appointment, CalendarDataSourceT? dataSource) {
    if (appointment.recurrenceRule != null &&
        appointment.recurrenceRule!.isNotEmpty) {
      final AppointmentT appointmentObject =
      appointment.convertToCalendarAppointment();
      if (appointment.data is AppointmentT) {
        return appointmentObject;
      } else {
        return dataSource!.convertAppointmentToObject(
            appointment.data, appointmentObject) ??
            appointmentObject;
      }
    } else {
      return appointment.data;
    }
  }

  /// Returns the index of the passed id's resource from the passed resource
  /// collection.
  static int getResourceIndex(
      List<CalendarResourceT>? resourceCollection, Object id) {
    if (resourceCollection == null || resourceCollection.isEmpty) {
      return -1;
    }

    return resourceCollection
        .indexWhere((CalendarResourceT resource) => resource.id == id);
  }

  /// Check the date in between first and last date
  static bool isDateTimeWithInDateTimeRange(
      DateTime startDate, DateTime endDate, DateTime date, int timeInterval) {
    if (startDate.isAfter(endDate)) {
      final dynamic temp = startDate;
      startDate = endDate;
      endDate = DateTimeHelperT.getDateTimeValue(temp);
    }

    if (isSameOrBeforeDateTime(endDate, date) &&
        isSameOrAfterDateTime(startDate, date)) {
      return true;
    }

    if (startDate.minute != 0) {
      date = date.add(Duration(minutes: timeInterval));
      if (isSameOrBeforeDateTime(endDate, date) &&
          isSameOrAfterDateTime(startDate, date)) {
        return true;
      }
    }

    return false;
  }

  /// Check the date before/same of last date
  static bool isSameOrBeforeDateTime(DateTime lastDate, DateTime date) {
    return CalendarViewHelperT.isSameTimeSlot(lastDate, date) ||
        lastDate.isAfter(date);
  }

  /// Check the date after/same of first date
  static bool isSameOrAfterDateTime(DateTime firstDate, DateTime date) {
    return CalendarViewHelperT.isSameTimeSlot(firstDate, date) ||
        firstDate.isBefore(date);
  }

  /// Method to switch the views based on the keyboard interaction.
  static KeyEventResult handleViewSwitchKeyBoardEvent(RawKeyEvent event,
      CalendarControllerT controller, List<CalendarViewT>? allowedViews) {
    /// Ctrl + and Ctrl - used by browser to zoom the page, hence as referred
    /// EJ2 scheduler, we have used alt + numeric to switch between views in
    /// calendar web and windows
    CalendarViewT view = controller.view!;
    if (event.isAltPressed) {
      if (event.logicalKey == LogicalKeyboardKey.digit1) {
        view = CalendarViewT.day;
      } else if (event.logicalKey == LogicalKeyboardKey.digit2) {
        view = CalendarViewT.week;
      } else if (event.logicalKey == LogicalKeyboardKey.digit3) {
        view = CalendarViewT.workWeek;
      } else if (event.logicalKey == LogicalKeyboardKey.digit4) {
        view = CalendarViewT.month;
      } else if (event.logicalKey == LogicalKeyboardKey.digit5) {
        view = CalendarViewT.timelineDay;
      } else if (event.logicalKey == LogicalKeyboardKey.digit6) {
        view = CalendarViewT.timelineWeek;
      } else if (event.logicalKey == LogicalKeyboardKey.digit7) {
        view = CalendarViewT.timelineWorkWeek;
      } else if (event.logicalKey == LogicalKeyboardKey.digit8) {
        view = CalendarViewT.timelineMonth;
      } else if (event.logicalKey == LogicalKeyboardKey.digit9) {
        view = CalendarViewT.schedule;
      }
    }

    if (allowedViews != null &&
        allowedViews.isNotEmpty &&
        !allowedViews.contains(view)) {
      return KeyEventResult.ignored;
    }

    controller.view = view;
    return KeyEventResult.handled;
  }

  /// Check the showWeekNumber is true or not and returns the position.
  static double getWeekNumberPanelWidth(
      bool showWeekNumber, double width, bool isMobilePlatform) {
    return showWeekNumber
        ? (width / (DateTime.daysPerWeek + 1)) / (isMobilePlatform ? 1.3 : 4)
        : 0;
  }

  /// Method to check that the current dragging appointment range contains any
  /// disabled date time in it.
  static bool isDraggingAppointmentHasDisabledCell(
      List<CalendarTimeRegion> timeRegions,
      List<DateTime> blackoutDates,
      DateTime appStartTime,
      DateTime appEndTime,
      bool isTimelineView,
      bool isMonthView,
      DateTime minDate,
      DateTime maxDate,
      int timeInterval,
      int resourceIndex,
      List<CalendarResourceT>? resources) {
    /// Condition added to check and restrict the appointment rescheduling when
    /// it exceeds the min/max dates in the calendar.
    if ((isMonthView &&
        (!isDateWithInDateRange(minDate, maxDate, appStartTime) ||
            !isDateWithInDateRange(minDate, maxDate, appEndTime))) ||
        (!isMonthView &&
            (!CalendarViewHelperT.isDateTimeWithInDateTimeRange(
                minDate, maxDate, appStartTime, timeInterval) ||
                !CalendarViewHelperT.isDateTimeWithInDateTimeRange(
                    minDate, maxDate, appEndTime, timeInterval)))) {
      return true;
    }

    /// Condition added to check and restrict the appointment rescheduling into
    /// the blackout dates of the month and timeline month views of the
    /// calendar.
    if (isMonthView) {
      for (int i = 0; i < blackoutDates.length; i++) {
        final DateTime blackoutDate = blackoutDates[i];
        if (isSameOrBeforeDate(appEndTime, blackoutDate) &&
            isSameOrAfterDate(appStartTime, blackoutDate)) {
          return true;
        }
      }

      return false;
    }

    /// Condition added to check and restrict the appointment rescheduling into
    /// the disabled time region of the timeslot views of the calendar.
    if (!isMonthView) {
      for (int i = 0; i < timeRegions.length; i++) {
        final CalendarTimeRegion region = timeRegions[i];
        if (!region.enablePointerInteraction &&
            (isSameOrBeforeDateTime(appEndTime, region.actualStartTime) &&
                isSameOrAfterDateTime(appStartTime, region.actualEndTime))) {
          if (resourceIndex != -1 &&
              region.resourceIds != null &&
              region.resourceIds!.isNotEmpty &&
              !region.resourceIds!.contains(resources![resourceIndex].id)) {
            continue;
          }
          return true;
        }
      }

      return false;
    }

    return false;
  }
}

/// Args to get and update the required properties from calendar state to it's
/// children's
class UpdateCalendarStateDetailsT {
  /// Holds the current display date of calendar.
  DateTime? currentDate;

  /// Holds the current view visible dates collection of calendar.
  List<DateTime> currentViewVisibleDates = <DateTime>[];

  /// Holds the current visible appointment collections of calendar.
  List<CalendarAppointmentT> visibleAppointments = <CalendarAppointmentT>[];

  /// Holds the current selected date of calendar.
  DateTime? selectedDate;

  /// Holds the all day panel height of calendar.
  double allDayPanelHeight = 0;

  /// Holds the all day panel appointment view collection.
  List<AppointmentViewT> allDayAppointmentViewCollection = <AppointmentViewT>[];

  /// Holds the calendar appointments details.
  List<CalendarAppointmentT> appointments = <CalendarAppointmentT>[];
}

/// Holds the time region view rendering details.
class TimeRegionView {
  /// Constructor to create the time region view rendering details
  TimeRegionView(this.visibleIndex, this.region, this.bound);

  /// Holds the time slot index of the calendar view.
  int visibleIndex = -1;

  /// Holds the time region details.
  CalendarTimeRegion region;

  /// Holds the time region view position and size.
  Rect bound;
}

/// Holds the appointment view rendering details.
class AppointmentViewT {
  /// Decides the appointment view occupied or not.
  bool canReuse = true;

  /// Holds the visible index of appointment start date.
  int startIndex = -1;

  /// Holds the visible index of appointment end date.
  int endIndex = -1;

  /// Holds the appointment details
  CalendarAppointmentT? appointment;

  /// Defines the rendering position of the appointment view.
  int position = -1;

  /// Defines the maximum rendering position of the appointment view.
  int maxPositions = -1;

  /// Defines the appointment view holds spanned appointment or not.
  bool isSpanned = false;

  /// Holds the appointment view position and size.
  RRect? appointmentRect;

  /// Defines the resource view index of the appointment.
  int resourceIndex = -1;

  /// Clones and return new instance of the appointment view.
  AppointmentViewT clone() {
    return AppointmentViewT()
      ..appointmentRect = appointmentRect
      ..appointment = appointment
      ..canReuse = canReuse
      ..startIndex = startIndex
      ..endIndex = endIndex
      ..position = position
      ..maxPositions = maxPositions
      ..isSpanned = isSpanned
      ..resourceIndex = resourceIndex;
  }
}

/// Appointment data for calendar.
///
/// An object that contains properties to hold the detailed information about
/// the data, which will be rendered in [SfCalendar].
class CalendarAppointmentT {
  /// Constructor to creates an appointment data for [SfCalendar].
  CalendarAppointmentT({
    this.startTimeZone,
    this.endTimeZone,
    this.recurrenceRule,
    this.isAllDay = false,
    this.notes,
    this.location,
    this.resourceIds,
    this.recurrenceId,
    this.id,
    required this.startTime,
    required this.endTime,
    this.subject = '',
    this.color = Colors.lightBlue,
    this.isSpanned = false,
    this.recurrenceExceptionDates,
  })  : actualStartTime = startTime,
        actualEndTime = endTime;

  /// The start time for an [CalendarAppointment] in [SfCalendar].
  ///
  /// Defaults to `DateTime.now()`.
  DateTime startTime;

  /// The end time for an [CalendarAppointment] in [SfCalendar].
  ///
  /// Defaults to `DateTime.now()`.
  DateTime endTime;

  /// Displays the [CalendarAppointment] on the all day panel area of time slot
  /// views in [SfCalendar].
  ///
  /// Defaults to `false`.
  bool isAllDay = false;

  /// The subject for the [CalendarAppointment] in [SfCalendar].
  ///
  /// Defaults to ` ` represents empty string.
  String subject;

  /// The color that fills the background of the [CalendarAppointment] view in
  /// [SfCalendar].
  ///
  /// Defaults to `Colors.lightBlue`.
  Color color;

  /// The start time zone for an [CalendarAppointment] in [SfCalendar].
  ///
  /// If it is not [null] the appointment start time will be calculated based on
  /// the time zone set to this property and [SfCalendar.timeZone] property.
  ///
  /// Defaults to null.
  String? startTimeZone;

  /// The end time zone for an [CalendarAppointment] in [SfCalendar].
  ///
  /// If it is not [null] the appointment end time will be calculated based on
  /// the time zone set to this property and [SfCalendar.timeZone] property.
  ///
  /// Defaults to null.
  String? endTimeZone;

  /// Recurs the [CalendarAppointment] on [SfCalendar].
  ///
  /// Defaults to null.
  String? recurrenceRule;

  /// Delete the occurrence for an recurrence appointment.
  ///
  /// Defaults to `null`.
  List<DateTime>? recurrenceExceptionDates;

  /// Defines the notes for an [CalendarAppointment] in [SfCalendar].
  ///
  /// Defaults to null.
  String? notes;

  /// Defines the location for an [CalendarAppointment] in [SfCalendar].
  ///
  /// Defaults to null.
  String? location;

  /// The ids of the [CalendarResource] that shares this [CalendarAppointment].
  List<Object>? resourceIds;

  /// Defines the recurrence id that
  /// used to create an exception for recurrence appointment in [SfCalendar].
  Object? recurrenceId;

  /// Defines the id for [Appointment] in [SfCalendar].
  ///
  /// Defaults to hashCode.
  Object? id;

  /// Holds the parent appointment details
  Object? data;

  /// Store the appointment start date value based on start timezone value.
  DateTime actualStartTime;

  /// Store the appointment end date value based on end timezone value.
  DateTime actualEndTime;

  /// Defines the appointment is spanned appointment or not.
  bool isSpanned = false;

  /// For span appointments, we have split the appointment into multiple while
  /// calculating the visible appointments, to render on the visible view, hence
  /// it's not possible to get the exact start and end time for the spanning
  /// appointment, hence to hold the exact start time of the appointment we have
  /// used this variable, and stored the start time which calculated based on
  /// the timezone, in the visible appointments calculation.
  late DateTime exactStartTime;

  /// For span appointments, we have split the appointment into multiple while
  /// calculating the visible appointments, to render on the visible view, hence
  /// it's not possible to get the exact start and end time for the spanning
  /// appointment, hence to hold the exact start time of the appointment we have
  /// used this variable, and stored the end time which calculated based on
  /// the timezone, in the visible appointments calculation.
  late DateTime exactEndTime;

  /// Returns an appointment object based on
  /// the passed calendar appointment value
  AppointmentT convertToCalendarAppointment() {
    return AppointmentT(
        startTime: startTime,
        endTime: endTime,
        subject: subject,
        color: color,
        recurrenceRule: recurrenceRule,
        isAllDay: isAllDay,
        resourceIds: resourceIds,
        recurrenceId: recurrenceId,
        id: id,
        startTimeZone: startTimeZone,
        endTimeZone: endTimeZone,
        notes: notes,
        location: location,
        recurrenceExceptionDates: recurrenceExceptionDates);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    late final CalendarAppointmentT otherAppointment;
    if (other is CalendarAppointmentT) {
      otherAppointment = other;
    }

    return CalendarViewHelperT.isSameTimeSlot(
        otherAppointment.startTime, startTime) &&
        CalendarViewHelperT.isSameTimeSlot(otherAppointment.endTime, endTime) &&
        CalendarViewHelperT.isSameTimeSlot(
            otherAppointment.actualStartTime, actualStartTime) &&
        CalendarViewHelperT.isSameTimeSlot(
            otherAppointment.actualEndTime, actualEndTime) &&
        otherAppointment.isSpanned == isSpanned &&
        otherAppointment.startTimeZone == startTimeZone &&
        otherAppointment.endTimeZone == endTimeZone &&
        otherAppointment.isAllDay == isAllDay &&
        otherAppointment.notes == notes &&
        otherAppointment.location == location &&
        !CalendarViewHelperT.isCollectionEqual(
            otherAppointment.resourceIds, resourceIds) &&
        otherAppointment.recurrenceId == recurrenceId &&
        otherAppointment.id == id &&
        otherAppointment.data == data &&
        otherAppointment.subject == subject &&
        otherAppointment.color == color &&
        otherAppointment.recurrenceRule == recurrenceRule &&
        CalendarViewHelperT.isDateCollectionEqual(
            otherAppointment.recurrenceExceptionDates,
            recurrenceExceptionDates);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return hashValues(
      startTimeZone,
      endTimeZone,
      recurrenceRule,
      isAllDay = false,
      notes,
      location,
      hashList(resourceIds),
      recurrenceId,
      id,
      data,
      startTime,
      endTime,
      subject,
      color,
      hashList(recurrenceExceptionDates),
    );
  }
}

/// It is used to highlight time slots on day, week, work week
/// and timeline views based on start and end time and
/// also used to restrict interaction on time slots.
///
/// Note: If time region have both the [text] and [iconData] then the region
/// will draw icon only.
class CalendarTimeRegion {
  /// Creates a Time region for timeslot views in calendar.
  ///
  /// The time region used to highlight and block the specific timeslots in
  /// timeslots view of [SfCalendar].
  CalendarTimeRegion(
      {required this.startTime,
        required this.endTime,
        this.text,
        this.recurrenceRule,
        this.color,
        this.enablePointerInteraction = true,
        this.recurrenceExceptionDates,
        this.resourceIds,
        this.timeZone,
        this.iconData,
        this.textStyle})
      : actualStartTime = startTime,
        actualEndTime = endTime;

  /// Used to specify the start time of the [CalendarTimeRegion].
  final DateTime startTime;

  /// Used to specify the end time of the [CalendarTimeRegion].
  final DateTime endTime;

  /// Used to specify the text of [CalendarTimeRegion].
  final String? text;

  /// Used to specify the recurrence of [CalendarTimeRegion].
  final String? recurrenceRule;

  /// Used to specify the background color of [CalendarTimeRegion].
  final Color? color;

  /// Used to allow or restrict the interaction of [CalendarTimeRegion].
  final bool enablePointerInteraction;

  /// Used to specify the time zone of [CalendarTimeRegion] start and end time.
  final String? timeZone;

  /// Used to specify the text style for [CalendarTimeRegion] text and icon.
  final TextStyle? textStyle;

  /// Used to specify the icon of [CalendarTimeRegion].
  ///
  /// Note: If time region have both the text and icon then it will draw icon
  /// only.
  final IconData? iconData;

  /// Used to restrict the occurrence for an recurrence region.
  final List<DateTime>? recurrenceExceptionDates;

  /// The ids of the [CalendarResource] that shares this [CalendarTimeRegion].
  final List<Object>? resourceIds;

  /// Used to store the original time region details.
  late TimeRegionT data;

  /// Used to store the start date value with specified time zone.
  late DateTime actualStartTime;

  /// Used to store the end date value with specified time zone.
  late DateTime actualEndTime;

  /// Creates a copy of this [CalendarTimeRegion] but with the given fields
  /// replaced with the new values.
  CalendarTimeRegion copyWith(
      {DateTime? startTime,
        DateTime? endTime,
        String? text,
        String? recurrenceRule,
        Color? color,
        bool? enablePointerInteraction,
        List<DateTime>? recurrenceExceptionDates,
        String? timeZone,
        IconData? iconData,
        TextStyle? textStyle,
        List<Object>? resourceIds}) {
    return CalendarTimeRegion(
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        color: color ?? this.color,
        recurrenceRule: recurrenceRule ?? this.recurrenceRule,
        textStyle: textStyle ?? this.textStyle,
        enablePointerInteraction:
        enablePointerInteraction ?? this.enablePointerInteraction,
        recurrenceExceptionDates:
        recurrenceExceptionDates ?? this.recurrenceExceptionDates,
        text: text ?? this.text,
        iconData: iconData ?? this.iconData,
        timeZone: timeZone ?? this.timeZone,
        resourceIds: resourceIds ?? this.resourceIds);
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(dynamic other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }

    late final CalendarTimeRegion region;
    if (other is CalendarTimeRegion) {
      region = other;
    }
    return region.textStyle == textStyle &&
        CalendarViewHelperT.isSameTimeSlot(region.startTime, startTime) &&
        CalendarViewHelperT.isSameTimeSlot(region.endTime, endTime) &&
        CalendarViewHelperT.isSameTimeSlot(
            region.actualStartTime, actualStartTime) &&
        CalendarViewHelperT.isSameTimeSlot(
            region.actualStartTime, actualStartTime) &&
        region.color == color &&
        region.recurrenceRule == recurrenceRule &&
        region.enablePointerInteraction == enablePointerInteraction &&
        CalendarViewHelperT.isDateCollectionEqual(
            region.recurrenceExceptionDates, recurrenceExceptionDates) &&
        region.iconData == iconData &&
        region.timeZone == timeZone &&
        region.resourceIds == resourceIds &&
        region.text == text;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode {
    return hashValues(
        startTime,
        endTime,
        color,
        recurrenceRule,
        textStyle,
        enablePointerInteraction,
        hashList(recurrenceExceptionDates),
        hashList(resourceIds),
        text,
        iconData,
        timeZone);
  }
}

/// Used to hold the schedule view hovering details
@immutable
class ScheduleViewHoveringDetailsT {
  /// Constructor to create the schedule view hovering details.
  const ScheduleViewHoveringDetailsT(this.hoveringDate, this.hoveringOffset);

  /// Holds the hovering position date time value.
  final DateTime hoveringDate;

  /// Holds the hovering position value.
  final Offset hoveringOffset;
}

/// The class contains all day panel selection details.
/// if all day panel appointment selected then [appointmentView] holds
/// appointment details, else [selectedDate] holds selected region date value.
@immutable
class SelectionDetails {
  /// Constructor to create the selection details.
  const SelectionDetails(this.appointmentView, this.selectedDate);

  /// Holds the selected appointment view details.
  final AppointmentViewT? appointmentView;

  /// Holds the selected date details.
  final DateTime? selectedDate;
}

/// Parent data for use with calendar custom widget.
class CalendarParentData extends ContainerBoxParentData<RenderBox> {}

/// Custom render object used in calendar child widgets.
abstract class CustomCalendarRenderObjectT extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, CalendarParentData> {
  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! CalendarParentData) {
      child.parentData = CalendarParentData();
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    return;
  }

  /// Returns a function that builds semantic information for the render object.
  SemanticsBuilderCallback? get semanticsBuilder => null;
}
