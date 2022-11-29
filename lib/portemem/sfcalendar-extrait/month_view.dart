import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:syncfusion_flutter_core/core.dart';

import 'package:portemem/portemem/sfcalendar-extrait/appointment_helper.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendar_theme.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendar_view_helper.dart';
import 'package:portemem/portemem/sfcalendar-extrait/date_time_engenier.dart';
import 'package:portemem/portemem/sfcalendar-extrait/event_args.dart';
import 'package:portemem/portemem/sfcalendar-extrait/month_view_setting.dart';
import 'package:portemem/portemem/sfcalendar-extrait/sfcalendar.dart';
import 'package:portemem/portemem/sfcalendar-extrait/week_number_style.dart';




/// Used to hold the month cell views on calendar month view.
class MonthViewWidgetT extends StatefulWidget {
  /// Constructor to create the month view widget to holds month cells for
  /// calendar month view.
  const MonthViewWidgetT(
      this.visibleDates,
      this.rowCount,
      this.monthCellStyle,
      this.isRTL,
      this.todayHighlightColor,
      this.todayTextStyle,
      this.cellBorderColor,
      this.calendarTheme,
      this.calendarCellNotifier,
      this.showTrailingAndLeadingDates,
      this.minDate,
      this.maxDate,
      this.calendar,
      this.blackoutDates,
      this.blackoutDatesTextStyle,
      this.textScaleFactor,
      this.builder,
      this.width,
      this.height,
      this.weekNumberStyle,
      this.isMobilePlatform,
      this.visibleAppointmentNotifier);

  /// Defines the row count for the month view.
  final int rowCount;

  /// Defines the style for the month cells.
  final MonthCellStyleT monthCellStyle;

  /// Holds the current month view widget dates.
  final List<DateTime> visibleDates;

  /// Defines the direction of calendar widget is RTL or not.
  final bool isRTL;

  /// Defines the today month cell highlight color.
  final Color? todayHighlightColor;

  /// Defines the today month cell text style.
  final TextStyle? todayTextStyle;

  /// Defines the month cell border color.
  final Color? cellBorderColor;

  /// Holds the theme data details for calendar.
  final SfCalendarThemeDataT calendarTheme;

  /// Holds the current hovering point used to paint the hovering.
  final ValueNotifier<Offset?> calendarCellNotifier;

  /// Defines the min date of the calendar.
  final DateTime minDate;

  /// Defines the max date of the calendar.
  final DateTime maxDate;

  /// Holds the calendar instance used to get the calendar properties.
  final SfCalendarT calendar;

  /// Decides the trailing and leading of month view will visible or not.
  final bool showTrailingAndLeadingDates;

  /// Holds the blackout dates collection of calendar.
  final List<DateTime>? blackoutDates;

  /// Defines the text style of the blackout dates month cell.
  final TextStyle? blackoutDatesTextStyle;

  /// Defines the scale factor for the month cell text.
  final double textScaleFactor;

  /// Defines the width of the month view widget.
  final double width;

  /// Defines the height of the month view widget.
  final double height;

  /// Defines the text style of the week number.
  final WeekNumberStyleT weekNumberStyle;

  /// Defines the current platform is mobile platform or not.
  final bool isMobilePlatform;

  /// Used to build the widget that replaces the month cell.
  final MonthCellBuilderT? builder;

  /// Holds the visible appointment collection used to trigger the builder
  /// when its value changed.
  final ValueNotifier<List<CalendarAppointmentT>?> visibleAppointmentNotifier;

  @override
  // ignore: library_private_types_in_public_api
  _MonthViewWidgetState createState() => _MonthViewWidgetState();
}

class _MonthViewWidgetState extends State<MonthViewWidgetT> {
  @override
  void initState() {
    widget.visibleAppointmentNotifier.addListener(_updateAppointment);
    super.initState();
  }

  @override
  void didUpdateWidget(MonthViewWidgetT oldWidget) {
    if (widget.visibleAppointmentNotifier !=
        oldWidget.visibleAppointmentNotifier) {
      oldWidget.visibleAppointmentNotifier.removeListener(_updateAppointment);
      widget.visibleAppointmentNotifier.addListener(_updateAppointment);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.visibleAppointmentNotifier.removeListener(_updateAppointment);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    final double weekNumberPanelWidth =
    CalendarViewHelperT.getWeekNumberPanelWidth(
        widget.calendar.showWeekNumber,
        widget.width,
        widget.isMobilePlatform);
    if (widget.builder != null) {
      final int visibleDatesCount = widget.visibleDates.length;
      final double cellWidth =
          (widget.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
      final double cellHeight = widget.height / widget.rowCount;
      double xPosition = weekNumberPanelWidth, yPosition = 0;
      final int currentMonth =
          widget.visibleDates[visibleDatesCount ~/ 2].month;
      final bool showTrailingLeadingDates =
      CalendarViewHelperT.isLeadingAndTrailingDatesVisible(
          widget.rowCount, widget.showTrailingAndLeadingDates);
      for (int i = 0; i < visibleDatesCount; i++) {
        final DateTime currentVisibleDate = widget.visibleDates[i];
        if (!showTrailingLeadingDates &&
            currentMonth != currentVisibleDate.month) {
          xPosition += cellWidth;
          if (xPosition + 1 >= widget.width) {
            xPosition = weekNumberPanelWidth;
            yPosition += cellHeight;
          }

          continue;
        }

        final List<CalendarAppointmentT> appointments =
        AppointmentHelperT.getSelectedDateAppointments(
            widget.visibleAppointmentNotifier.value,
            widget.calendar.timeZone,
            currentVisibleDate);
        List<dynamic> monthCellAppointment = appointments;
        if (widget.calendar.dataSource != null &&
            !AppointmentHelperT.isCalendarAppointment(
                widget.calendar.dataSource!)) {
          monthCellAppointment = CalendarViewHelperT.getCustomAppointments(
              appointments, widget.calendar.dataSource);
        }

        final Widget child = widget.builder!(
            context,
            MonthCellDetailsT(
                currentVisibleDate,
                List<Object>.unmodifiable(monthCellAppointment),
                List<DateTime>.unmodifiable(widget.visibleDates),
                Rect.fromLTWH(
                    widget.isRTL
                        ? widget.width - xPosition - cellWidth
                        : xPosition,
                    yPosition,
                    cellWidth,
                    cellHeight)));
        children.add(RepaintBoundary(child: child));

        xPosition += cellWidth;
        if (xPosition + 1 >= widget.width) {
          xPosition = weekNumberPanelWidth;
          yPosition += cellHeight;
        }
      }
    }

    return _MonthViewRenderObjectWidgetT(
      widget.visibleDates,
      widget.visibleAppointmentNotifier.value,
      widget.rowCount,
      widget.monthCellStyle,
      widget.isRTL,
      widget.todayHighlightColor,
      widget.todayTextStyle,
      widget.cellBorderColor,
      widget.calendarTheme,
      widget.calendarCellNotifier,
      widget.minDate,
      widget.maxDate,
      widget.blackoutDates,
      widget.blackoutDatesTextStyle,
      widget.showTrailingAndLeadingDates,
      widget.textScaleFactor,
      widget.width,
      widget.height,
      widget.calendar.weekNumberStyle,
      weekNumberPanelWidth,
      widget.isMobilePlatform,
      children: children,
    );
  }

  void _updateAppointment() {
    setState(() {
      /// Update the children when visible appointment changed.
    });
  }
}

class _MonthViewRenderObjectWidgetT extends MultiChildRenderObjectWidget {
  _MonthViewRenderObjectWidgetT(
      this.visibleDates,
      this.visibleAppointments,
      this.rowCount,
      this.monthCellStyle,
      this.isRTL,
      this.todayHighlightColor,
      this.todayTextStyle,
      this.cellBorderColor,
      this.calendarTheme,
      this.calendarCellNotifier,
      this.minDate,
      this.maxDate,
      this.blackoutDates,
      this.blackoutDatesTextStyle,
      this.showTrailingAndLeadingDates,
      this.textScaleFactor,
      this.width,
      this.height,
      this.weekNumberStyle,
      this.weekNumberPanelWidth,
      this.isMobilePlatform,
      {List<Widget> children = const <Widget>[]})
      : super(children: children);

  final int rowCount;
  final MonthCellStyleT monthCellStyle;
  final List<DateTime> visibleDates;
  final List<CalendarAppointmentT>? visibleAppointments;
  final bool isRTL;
  final Color? todayHighlightColor;
  final TextStyle? todayTextStyle;
  final Color? cellBorderColor;
  final SfCalendarThemeDataT calendarTheme;
  final ValueNotifier<Offset?> calendarCellNotifier;
  final DateTime minDate;
  final DateTime maxDate;
  final List<DateTime>? blackoutDates;
  final TextStyle? blackoutDatesTextStyle;
  final bool showTrailingAndLeadingDates;
  final double textScaleFactor;
  final double width;
  final double height;
  final WeekNumberStyleT weekNumberStyle;
  final double weekNumberPanelWidth;
  final bool isMobilePlatform;

  @override
  _MonthViewRenderObjectT createRenderObject(BuildContext context) {
    return _MonthViewRenderObjectT(
        visibleDates,
        visibleAppointments,
        rowCount,
        monthCellStyle,
        isRTL,
        todayHighlightColor,
        todayTextStyle,
        cellBorderColor,
        calendarTheme,
        calendarCellNotifier,
        minDate,
        maxDate,
        blackoutDates,
        blackoutDatesTextStyle,
        showTrailingAndLeadingDates,
        textScaleFactor,
        width,
        height,
        weekNumberStyle,
        weekNumberPanelWidth,
        isMobilePlatform);
  }

  @override
  void updateRenderObject(
      BuildContext context, _MonthViewRenderObjectT renderObject) {
    renderObject
      ..visibleDates = visibleDates
      ..visibleAppointments = visibleAppointments
      ..rowCount = rowCount
      ..monthCellStyle = monthCellStyle
      ..isRTL = isRTL
      ..todayHighlightColor = todayHighlightColor
      ..todayTextStyle = todayTextStyle
      ..cellBorderColor = cellBorderColor
      ..calendarTheme = calendarTheme
      ..calendarCellNotifier = calendarCellNotifier
      ..minDate = minDate
      ..maxDate = maxDate
      ..blackoutDates = blackoutDates
      ..blackoutDatesTextStyle = blackoutDatesTextStyle
      ..showTrailingAndLeadingDates = showTrailingAndLeadingDates
      ..textScaleFactor = textScaleFactor
      ..width = width
      ..height = height
      ..weekNumberPanelWidth = weekNumberPanelWidth
      ..weekNumberStyle = weekNumberStyle
      ..isMobilePlatform = isMobilePlatform;
  }
}

class _MonthViewRenderObjectT extends CustomCalendarRenderObjectT {
  _MonthViewRenderObjectT(
      this._visibleDates,
      this._visibleAppointments,
      this._rowCount,
      this._monthCellStyle,
      this._isRTL,
      this._todayHighlightColor,
      this._todayTextStyle,
      this._cellBorderColor,
      this._calendarTheme,
      this._calendarCellNotifier,
      this._minDate,
      this._maxDate,
      this._blackoutDates,
      this._blackoutDatesTextStyle,
      this._showTrailingAndLeadingDates,
      this._textScaleFactor,
      this._width,
      this._height,
      this._weekNumberStyle,
      this._weekNumberPanelWidth,
      this._isMobilePlatform);

  bool _isMobilePlatform;

  bool get isMobilePlatform => _isMobilePlatform;

  set isMobilePlatform(bool value) {
    if (_isMobilePlatform == value) {
      return;
    }

    _isMobilePlatform = value;
  }

  double _height;

  double get height => _height;

  set height(double value) {
    if (_height == value) {
      return;
    }

    _height = value;
    markNeedsLayout();
  }

  double _width;

  double get width => _width;

  set width(double value) {
    if (_width == value) {
      return;
    }

    _width = value;
    markNeedsLayout();
  }

  int _rowCount;

  int get rowCount => _rowCount;

  set rowCount(int value) {
    if (_rowCount == value) {
      return;
    }

    _rowCount = value;
    markNeedsLayout();
  }

  double _textScaleFactor;

  double get textScaleFactor => _textScaleFactor;

  set textScaleFactor(double value) {
    if (_textScaleFactor == value) {
      return;
    }

    _textScaleFactor = value;
    markNeedsPaint();
  }

  Color? _todayHighlightColor;

  Color? get todayHighlightColor => _todayHighlightColor;

  set todayHighlightColor(Color? value) {
    if (_todayHighlightColor == value) {
      return;
    }

    _todayHighlightColor = value;
    if (childCount != 0) {
      return;
    }

    markNeedsPaint();
  }

  TextStyle? _todayTextStyle;

  TextStyle? get todayTextStyle => _todayTextStyle;

  set todayTextStyle(TextStyle? value) {
    if (_todayTextStyle == value) {
      return;
    }

    _todayTextStyle = value;
    if (childCount != 0) {
      return;
    }

    markNeedsPaint();
  }

  Color? _cellBorderColor;

  Color? get cellBorderColor => _cellBorderColor;

  set cellBorderColor(Color? value) {
    if (_cellBorderColor == value) {
      return;
    }

    _cellBorderColor = value;
    if (childCount != 0) {
      return;
    }

    markNeedsPaint();
  }

  DateTime _minDate;

  DateTime get minDate => _minDate;

  set minDate(DateTime value) {
    if (_minDate == value || isSameDate(_minDate, value)) {
      return;
    }

    _minDate = value;
    markNeedsPaint();
  }

  DateTime _maxDate;

  DateTime get maxDate => _maxDate;

  set maxDate(DateTime value) {
    if (_maxDate == value || isSameDate(_maxDate, value)) {
      return;
    }

    _maxDate = value;
    markNeedsPaint();
  }

  MonthCellStyleT _monthCellStyle;

  MonthCellStyleT get monthCellStyle => _monthCellStyle;

  set monthCellStyle(MonthCellStyleT value) {
    if (_monthCellStyle == value) {
      return;
    }

    _monthCellStyle = value;
    if (childCount != 0) {
      return;
    }

    markNeedsPaint();
  }

  bool _isRTL;

  bool get isRTL => _isRTL;

  set isRTL(bool value) {
    if (_isRTL == value) {
      return;
    }

    _isRTL = value;
    if (childCount == 0) {
      markNeedsPaint();
    } else {
      markNeedsLayout();
    }
  }

  bool _showTrailingAndLeadingDates;

  bool get showTrailingAndLeadingDates => _showTrailingAndLeadingDates;

  set showTrailingAndLeadingDates(bool value) {
    if (_showTrailingAndLeadingDates == value) {
      return;
    }

    _showTrailingAndLeadingDates = value;
    if (childCount == 0) {
      markNeedsPaint();
    } else {
      markNeedsLayout();
    }
  }

  SfCalendarThemeDataT _calendarTheme;

  SfCalendarThemeDataT get calendarTheme => _calendarTheme;

  set calendarTheme(SfCalendarThemeDataT value) {
    if (_calendarTheme == value) {
      return;
    }

    _calendarTheme = value;
    if (childCount != 0) {
      return;
    }

    markNeedsPaint();
  }

  List<DateTime> _visibleDates;

  List<DateTime> get visibleDates => _visibleDates;

  set visibleDates(List<DateTime> value) {
    if (_visibleDates == value) {
      return;
    }

    _visibleDates = value;
    markNeedsPaint();
  }

  List<CalendarAppointmentT>? _visibleAppointments;

  List<CalendarAppointmentT>? get visibleAppointments => _visibleAppointments;

  set visibleAppointments(List<CalendarAppointmentT>? value) {
    if (_visibleAppointments == value) {
      return;
    }

    _visibleAppointments = value;
    if (childCount == 0) {
      return;
    }

    markNeedsPaint();
  }

  List<DateTime>? _blackoutDates;

  List<DateTime>? get blackoutDates => _blackoutDates;

  set blackoutDates(List<DateTime>? value) {
    if (_blackoutDates == value) {
      return;
    }

    final List<DateTime>? oldDates = _blackoutDates;
    _blackoutDates = value;
    if (CalendarViewHelperT.isEmptyList(_blackoutDates) &&
        CalendarViewHelperT.isEmptyList(oldDates)) {
      return;
    }

    _updateBlackoutDatesIndex();
    markNeedsPaint();
  }

  TextStyle? _blackoutDatesTextStyle;

  TextStyle? get blackoutDatesTextStyle => _blackoutDatesTextStyle;

  set blackoutDatesTextStyle(TextStyle? value) {
    if (_blackoutDatesTextStyle == value) {
      return;
    }

    _blackoutDatesTextStyle = value;
    if (childCount != 0) {
      return;
    }

    markNeedsPaint();
  }

  ValueNotifier<Offset?> _calendarCellNotifier;

  ValueNotifier<Offset?> get calendarCellNotifier => _calendarCellNotifier;

  set calendarCellNotifier(ValueNotifier<Offset?> value) {
    if (_calendarCellNotifier == value) {
      return;
    }

    _calendarCellNotifier.removeListener(markNeedsPaint);
    _calendarCellNotifier = value;
    _calendarCellNotifier.addListener(markNeedsPaint);
  }

  WeekNumberStyleT _weekNumberStyle;

  WeekNumberStyleT get weekNumberStyle => _weekNumberStyle;

  set weekNumberStyle(WeekNumberStyleT value) {
    if (_weekNumberStyle == value) {
      return;
    }

    _weekNumberStyle = value;
    if (childCount == 0) {
      markNeedsPaint();
    } else {
      markNeedsLayout();
    }
  }

  double _weekNumberPanelWidth;

  double get weekNumberPanelWidth => _weekNumberPanelWidth;

  set weekNumberPanelWidth(double value) {
    if (_weekNumberPanelWidth == value) {
      return;
    }

    _weekNumberPanelWidth = value;
    if (childCount == 0) {
      markNeedsPaint();
    } else {
      markNeedsLayout();
    }
  }

  /// attach will called when the render object rendered in view.
  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _calendarCellNotifier.addListener(markNeedsPaint);
  }

  /// detach will called when the render object removed from view.
  @override
  void detach() {
    _calendarCellNotifier.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void performLayout() {
    final Size widgetSize = constraints.biggest;
    size = Size(widgetSize.width.isInfinite ? width : widgetSize.width,
        widgetSize.height.isInfinite ? height : widgetSize.height);
    final double cellWidth =
        (size.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
    final double cellHeight = size.height / rowCount;
    for (dynamic child = firstChild; child != null; child = childAfter(child)) {
      child.layout(constraints.copyWith(
          minWidth: cellWidth,
          minHeight: cellHeight,
          maxWidth: cellWidth,
          maxHeight: cellHeight));
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final bool isNeedCustomPaint = childCount != 0;
    if (_blackoutDatesIndex.isEmpty) {
      _updateBlackoutDatesIndex();
    }

    if (!isNeedCustomPaint) {
      _drawMonthCells(context.canvas, size);
    } else {
      final double cellWidth =
          (size.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
      final double cellHeight = size.height / rowCount;
      double xPosition = weekNumberPanelWidth, yPosition = 0;
      RenderBox? child = firstChild;
      final int visibleDatesCount = visibleDates.length;
      final int currentMonth = visibleDates[visibleDatesCount ~/ 2].month;
      final bool showTrailingLeadingDates =
      CalendarViewHelperT.isLeadingAndTrailingDatesVisible(
          rowCount, showTrailingAndLeadingDates);
      _drawWeekNumberPanel(context.canvas, cellHeight);
      for (int i = 0; i < visibleDatesCount; i++) {
        final DateTime currentVisibleDate = visibleDates[i];

        /// Based on ISO, Monday is the first day of the week. So we can
        /// calculate the week number is Monday of the week for the current
        /// date.
        if (currentVisibleDate.weekday == DateTime.monday) {
          /// Calculate the row start date based on visible dates index.
          final DateTime startDate =
          visibleDates[(i ~/ DateTime.daysPerWeek) * DateTime.daysPerWeek];

          /// Calculate the row end date based on visible dates index.
          final DateTime endDate = addDuration(
              startDate, const Duration(days: DateTime.daysPerWeek - 1))
          as DateTime;

          /// Used to check the start and end date is current month date or not.
          final bool isCurrentMonthWeek =
              startDate.month == currentMonth || endDate.month == currentMonth;

          if (weekNumberPanelWidth != 0 &&
              (showTrailingLeadingDates ||
                  (!showTrailingLeadingDates && isCurrentMonthWeek))) {
            _drawWeekNumber(context.canvas, size, currentVisibleDate,
                cellHeight, yPosition);
          }
        }

        if (!showTrailingLeadingDates &&
            currentMonth != currentVisibleDate.month) {
          xPosition += cellWidth;
          if (xPosition + 1 >= size.width) {
            xPosition = weekNumberPanelWidth;
            yPosition += cellHeight;
          }
          continue;
        }

        context.paintChild(
            child!,
            Offset(isRTL ? size.width - xPosition - cellWidth : xPosition,
                yPosition));
        child = childAfter(child);

        if (calendarCellNotifier.value != null &&
            !_blackoutDatesIndex.contains(i)) {
          _addMouseHovering(context.canvas, size, cellWidth, cellHeight,
              isRTL ? xPosition - weekNumberPanelWidth : xPosition, yPosition);
        }

        xPosition += cellWidth;
        if (xPosition + 1 >= size.width) {
          xPosition = weekNumberPanelWidth;
          yPosition += cellHeight;
        }
      }
    }
  }

  final Paint _linePainter = Paint();
  final TextPainter _textPainter = TextPainter();
  static const double linePadding = 0.5;
  List<int> _blackoutDatesIndex = <int>[];

  void _updateBlackoutDatesIndex() {
    _blackoutDatesIndex = <int>[];
    final int count = blackoutDates == null ? 0 : blackoutDates!.length;
    for (int i = 0; i < count; i++) {
      final DateTime blackoutDate = blackoutDates![i];
      final int blackoutDateIndex =
      DateTimeHelperT.getVisibleDateIndex(visibleDates, blackoutDate);
      if (blackoutDateIndex == -1) {
        continue;
      }

      _blackoutDatesIndex.add(blackoutDateIndex);
    }
  }

  void _drawWeekNumber(Canvas canvas, Size size, DateTime date,
      double cellHeight, double yPosition) {
    final String weekNumber =
    DateTimeHelperT.getWeekNumberOfYear(date).toString();
    double xPosition = isRTL ? size.width - weekNumberPanelWidth : 0;
    final TextStyle weekNumberTextStyle =
        weekNumberStyle.textStyle ?? calendarTheme.weekNumberTextStyle!;
    final TextSpan textSpan =
    TextSpan(text: weekNumber, style: weekNumberTextStyle);

    _textPainter.text = textSpan;
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textWidthBasis = TextWidthBasis.longestLine;
    _textPainter.textScaleFactor = textScaleFactor;

    const double topPadding = 4;
    _textPainter.layout(maxWidth: weekNumberPanelWidth);
    xPosition += (weekNumberPanelWidth - _textPainter.width) / 2;
    _textPainter.paint(canvas, Offset(xPosition, yPosition + topPadding));
  }

  void _drawWeekNumberPanel(Canvas canvas, double cellHeight) {
    if (weekNumberPanelWidth == 0) {
      return;
    }

    final double xPosition = isRTL ? size.width - weekNumberPanelWidth : 0;
    final double padding = isMobilePlatform ? 5 : 0;
    final double left = xPosition + padding;
    final double right = (xPosition + weekNumberPanelWidth) - padding;
    final Rect rect =
    Rect.fromLTRB(left, padding, right, size.height - padding);
    _linePainter.style = PaintingStyle.fill;
    _linePainter.color = weekNumberStyle.backgroundColor ??
        calendarTheme.weekNumberBackgroundColor!;
    final RRect roundedRect =
    RRect.fromRectAndRadius(rect, Radius.circular(padding));
    canvas.drawRRect(roundedRect, _linePainter);

    if (isMobilePlatform) {
      double yPosition = cellHeight;
      _linePainter.strokeWidth = linePadding;
      _linePainter.color = cellBorderColor ?? calendarTheme.cellBorderColor!;
      for (int i = 0; i < rowCount - 1; i++) {
        canvas.drawLine(
            Offset(left, yPosition), Offset(right, yPosition), _linePainter);
        yPosition += cellHeight;
      }
    }
  }

  void _drawMonthCells(Canvas canvas, Size size) {
    const double viewPadding = 5;
    const double circlePadding = 4;
    final double cellWidth =
        (size.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
    final double cellHeight = size.height / rowCount;
    double xPosition = isRTL
        ? size.width - cellWidth - weekNumberPanelWidth
        : weekNumberPanelWidth;
    double yPosition = viewPadding;
    _textPainter.textDirection = TextDirection.ltr;
    _textPainter.textWidthBasis = TextWidthBasis.longestLine;
    _textPainter.textScaleFactor = textScaleFactor;
    final int visibleDatesCount = visibleDates.length;
    final DateTime currentMonthDate = visibleDates[visibleDatesCount ~/ 2];
    final int nextMonth =
        DateTimeHelperT.getDateTimeValue(getNextMonthDate(currentMonthDate))
            .month;
    final int previousMonth =
        DateTimeHelperT.getDateTimeValue(getPreviousMonthDate(currentMonthDate))
            .month;
    final DateTime today = DateTime.now();
    bool isCurrentDate;

    _linePainter.isAntiAlias = true;
    final TextStyle todayStyle =
        todayTextStyle ?? calendarTheme.todayTextStyle!;
    final TextStyle currentMonthTextStyle =
        monthCellStyle.textStyle ?? calendarTheme.activeDatesTextStyle!;
    final TextStyle previousMonthTextStyle =
        monthCellStyle.trailingDatesTextStyle ??
            calendarTheme.trailingDatesTextStyle!;
    final TextStyle nextMonthTextStyle = monthCellStyle.leadingDatesTextStyle ??
        calendarTheme.leadingDatesTextStyle!;
    final TextStyle? blackoutDatesStyle =
        blackoutDatesTextStyle ?? calendarTheme.blackoutDatesTextStyle;
    final TextStyle disabledTextStyle = TextStyle(
        color: currentMonthTextStyle.color != null
            ? currentMonthTextStyle.color!.withOpacity(0.38)
            : calendarTheme.brightness == Brightness.light
            ? Colors.black26
            : Colors.white38,
        fontSize: 13,
        fontFamily: 'Roboto');

    final bool showTrailingLeadingDates =
    CalendarViewHelperT.isLeadingAndTrailingDatesVisible(
        rowCount, showTrailingAndLeadingDates);

    final Color currentMonthBackgroundColor = monthCellStyle.backgroundColor ??
        calendarTheme.activeDatesBackgroundColor!;
    final Color nextMonthBackgroundColor =
        monthCellStyle.leadingDatesBackgroundColor ??
            calendarTheme.leadingDatesBackgroundColor!;
    final Color previousMonthBackgroundColor =
        monthCellStyle.trailingDatesBackgroundColor ??
            calendarTheme.trailingDatesBackgroundColor!;
    final Color todayBackgroundColor = monthCellStyle.todayBackgroundColor ??
        calendarTheme.todayBackgroundColor!;

    TextStyle textStyle = currentMonthTextStyle;
    _drawWeekNumberPanel(canvas, cellHeight);
    for (int i = 0; i < visibleDatesCount; i++) {
      isCurrentDate = false;
      final DateTime currentVisibleDate = visibleDates[i];

      /// Based on ISO, Monday is the first day of the week. So we can
      /// calculate the week number is Monday of the week for the current
      /// date.
      if (currentVisibleDate.weekday == DateTime.monday) {
        /// Calculate the row start date based on visible dates index.
        final DateTime startDate =
        visibleDates[(i ~/ DateTime.daysPerWeek) * DateTime.daysPerWeek];

        /// Calculate the row end date based on visible dates index.
        final DateTime endDate = addDuration(
            startDate, const Duration(days: DateTime.daysPerWeek - 1))
        as DateTime;

        /// Used to check the start and end date is current month date or not.
        final bool isCurrentMonthWeek =
            startDate.month == currentMonthDate.month ||
                endDate.month == currentMonthDate.month;

        if (weekNumberPanelWidth != 0 &&
            (showTrailingLeadingDates ||
                (!showTrailingLeadingDates && isCurrentMonthWeek))) {
          _drawWeekNumber(
              canvas, size, currentVisibleDate, cellHeight, yPosition);
        }
      }

      textStyle = currentMonthTextStyle;
      _linePainter.color = currentMonthBackgroundColor;
      if (currentVisibleDate.month == nextMonth) {
        if (!showTrailingLeadingDates) {
          if (isRTL) {
            if (xPosition - 1 < 0) {
              xPosition = size.width;
              yPosition += cellHeight;
            }

            xPosition -= cellWidth;
          } else {
            xPosition += cellWidth;
            if (xPosition + 1 >= size.width) {
              xPosition = weekNumberPanelWidth;
              yPosition += cellHeight;
            }
          }

          continue;
        }

        textStyle = nextMonthTextStyle;
        _linePainter.color = nextMonthBackgroundColor;
      } else if (currentVisibleDate.month == previousMonth) {
        if (!showTrailingLeadingDates) {
          if (isRTL) {
            if (xPosition - 1 < 0) {
              xPosition = size.width;
              yPosition += cellHeight;
            }

            xPosition -= cellWidth;
          } else {
            xPosition += cellWidth;
            if (xPosition + 1 >= size.width) {
              xPosition = weekNumberPanelWidth;
              yPosition += cellHeight;
            }
          }

          continue;
        }

        textStyle = previousMonthTextStyle;
        _linePainter.color = previousMonthBackgroundColor;
      }

      if (rowCount <= 4) {
        textStyle = currentMonthTextStyle;
      }

      if (isSameDate(currentVisibleDate, today)) {
        _linePainter.color = todayBackgroundColor;
        textStyle = todayStyle;
        isCurrentDate = true;
      }

      if (!isDateWithInDateRange(minDate, maxDate, currentVisibleDate)) {
        textStyle = disabledTextStyle;
      }

      final bool isBlackoutDate = _blackoutDatesIndex.contains(i);
      if (isBlackoutDate) {
        textStyle = blackoutDatesStyle ??
            textStyle.copyWith(decoration: TextDecoration.lineThrough);
      }

      final TextSpan span = TextSpan(
        text: currentVisibleDate.day.toString(),
        style: textStyle,
      );

      _textPainter.text = span;

      _textPainter.layout(maxWidth: cellWidth);

      //// In web when the mouse hovering the cell, the painter style set as stroke,
      //// hence if background color set for an cell and mouse hovered for the
      //// cell before it will change the background color from fill to stroke
      //// for the cells after it, hence to fill the background color we have set
      //// the style s fill.
      _linePainter.style = PaintingStyle.fill;
      canvas.drawRect(
          Rect.fromLTWH(
              xPosition, yPosition - viewPadding, cellWidth, cellHeight),
          _linePainter);

      if (calendarCellNotifier.value != null && !isBlackoutDate) {
        _addMouseHovering(canvas, size, cellWidth, cellHeight, xPosition,
            yPosition - viewPadding);
      }

      if (isCurrentDate) {
        _linePainter.style = PaintingStyle.fill;
        _linePainter.color = todayHighlightColor!;
        _linePainter.isAntiAlias = true;

        final double textHeight = _textPainter.height / 2;
        canvas.drawCircle(
            Offset(xPosition + cellWidth / 2,
                yPosition + circlePadding + textHeight),
            textHeight + viewPadding,
            _linePainter);
      }

      _textPainter.paint(
          canvas,
          Offset(xPosition + (cellWidth / 2 - _textPainter.width / 2),
              yPosition + circlePadding));

      if (isRTL) {
        if (xPosition - 1 < 0) {
          xPosition = size.width - weekNumberPanelWidth;
          yPosition += cellHeight;
        }

        xPosition -= cellWidth;
      } else {
        xPosition += cellWidth;
        if (xPosition + 1 >= size.width) {
          xPosition = weekNumberPanelWidth;
          yPosition += cellHeight;
        }
      }
    }

    _drawVerticalAndHorizontalLines(
        canvas, size, yPosition, xPosition, cellHeight, cellWidth);
  }

  void _addMouseHovering(Canvas canvas, Size size, double cellWidth,
      double cellHeight, double xPosition, double yPosition) {
    if (xPosition <= calendarCellNotifier.value!.dx &&
        xPosition + cellWidth >= calendarCellNotifier.value!.dx &&
        yPosition <= calendarCellNotifier.value!.dy &&
        yPosition + cellHeight >= calendarCellNotifier.value!.dy) {
      _linePainter.style = PaintingStyle.stroke;
      _linePainter.strokeWidth = 2;
      _linePainter.color = calendarTheme.selectionBorderColor!.withOpacity(0.4);
      canvas.drawRect(
          Rect.fromLTWH(
              xPosition == 0 ? xPosition + linePadding : xPosition,
              yPosition,
              (xPosition + cellWidth).round() >= size.width
                  ? cellWidth - linePadding - 1
                  : cellWidth - 1,
              (yPosition + cellHeight).round() >= size.height.round()
                  ? cellHeight - 1 - linePadding
                  : cellHeight - 1),
          _linePainter);
    }
  }

  void _drawVerticalAndHorizontalLines(Canvas canvas, Size size,
      double yPosition, double xPosition, double cellHeight, double cellWidth) {
    yPosition = cellHeight;
    _linePainter.strokeWidth = linePadding;
    _linePainter.color = cellBorderColor ?? calendarTheme.cellBorderColor!;
    xPosition = isRTL ? 0 : weekNumberPanelWidth;
    final double finalXPosition =
    isRTL ? size.width - weekNumberPanelWidth : size.width;
    canvas.drawLine(Offset(xPosition, linePadding),
        Offset(finalXPosition, linePadding), _linePainter);
    for (int i = 0; i < rowCount - 1; i++) {
      canvas.drawLine(
          Offset(
              isMobilePlatform
                  ? isRTL
                  ? 0
                  : weekNumberPanelWidth
                  : 0,
              yPosition),
          Offset(
              isMobilePlatform
                  ? isRTL
                  ? size.width - weekNumberPanelWidth
                  : size.width
                  : size.width,
              yPosition),
          _linePainter);
      yPosition += cellHeight;
    }

    canvas.drawLine(Offset(0, size.height - linePadding),
        Offset(size.width, size.height - linePadding), _linePainter);
    xPosition =
    weekNumberPanelWidth != 0 && !isRTL ? weekNumberPanelWidth : cellWidth;
    canvas.drawLine(const Offset(linePadding, 0),
        Offset(linePadding, size.height), _linePainter);
    final int count = weekNumberPanelWidth == 0 ? 6 : 7;
    for (int i = 0; i < count; i++) {
      canvas.drawLine(
          Offset(xPosition, 0), Offset(xPosition, size.height), _linePainter);
      xPosition += cellWidth;
    }
  }

  String _getAccessibilityText(DateTime date, int index) {
    final String accessibilityText =
    DateFormat('EEE, dd MMMM yyyy').format(date);
    if (_blackoutDatesIndex.contains(index)) {
      return '$accessibilityText, Blackout date';
    }

    if (!isDateWithInDateRange(minDate, maxDate, date)) {
      return '$accessibilityText, Disabled date';
    }

    return accessibilityText;
  }

  List<CustomPainterSemantics> _getSemanticsBuilder(Size size) {
    final List<CustomPainterSemantics> semanticsBuilder =
    <CustomPainterSemantics>[];
    final double cellWidth =
        (size.width - weekNumberPanelWidth) / DateTime.daysPerWeek;
    double left = isRTL
        ? size.width - cellWidth - weekNumberPanelWidth
        : weekNumberPanelWidth,
        top = 0;
    final double cellHeight = size.height / rowCount;
    final bool showTrailingLeadingDates =
    CalendarViewHelperT.isLeadingAndTrailingDatesVisible(
        rowCount, showTrailingAndLeadingDates);
    final int currentMonth = visibleDates[visibleDates.length ~/ 2].month;
    for (int i = 0; i < visibleDates.length; i++) {
      final DateTime currentVisibleDate = visibleDates[i];

      /// Based on ISO, Monday is the first day of the week. So we can
      /// calculate the week number is Monday of the week for the current
      /// date.
      if (currentVisibleDate.weekday == DateTime.monday) {
        /// Calculate the row start date based on visible dates index.
        final DateTime startDate =
        visibleDates[(i ~/ DateTime.daysPerWeek) * DateTime.daysPerWeek];

        /// Calculate the row end date based on visible dates index.
        final DateTime endDate = addDuration(
            startDate, const Duration(days: DateTime.daysPerWeek - 1))
        as DateTime;

        /// Used to check the start and end date is current month date or not.
        final bool isCurrentMonthWeek =
            startDate.month == currentMonth || endDate.month == currentMonth;

        if (weekNumberPanelWidth != 0 &&
            (showTrailingLeadingDates ||
                (!showTrailingLeadingDates && isCurrentMonthWeek))) {
          final int weekNumber =
          DateTimeHelperT.getWeekNumberOfYear(currentVisibleDate);
          semanticsBuilder.add(CustomPainterSemantics(
              rect: Rect.fromLTWH(isRTL ? (size.width - left - cellWidth) : 0,
                  top, weekNumberPanelWidth, cellHeight),
              properties: SemanticsProperties(
                label: 'week$weekNumber',
                textDirection: TextDirection.ltr,
              )));
        }
      }
      if (showTrailingLeadingDates ||
          currentMonth == currentVisibleDate.month) {
        semanticsBuilder.add(CustomPainterSemantics(
          rect: Rect.fromLTWH(isRTL ? size.width - left - cellWidth : left, top,
              cellWidth, cellHeight),
          properties: SemanticsProperties(
            label: _getAccessibilityText(currentVisibleDate, i),
            textDirection: TextDirection.ltr,
          ),
        ));
      }

      left += cellWidth;
      if (left + 1 >= size.width) {
        top += cellHeight;
        left = weekNumberPanelWidth;
      }
    }

    return semanticsBuilder;
  }

  @override
  List<CustomPainterSemantics> Function(Size size) get semanticsBuilder =>
      _getSemanticsBuilder;
}
