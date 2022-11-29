import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfBarcodeThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfChartThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfDataGridThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfDataPagerThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfDateRangePickerThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfGaugeThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfMapsThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfRangeSelectorThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfRangeSliderThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/SfSliderThemeData.dart';
import 'package:portemem/portemem/sfcalendar-extrait/pdf_viewer.dart';


import 'calendar_theme.dart';


/// Applies a theme to descendant Syncfusion widgets.
///
/// If [SfTheme] is not specified, then based on the
/// [Theme.of(context).brightness], brightness for
/// Syncfusion widgets will be applied.
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Center(
///       child: SfTheme(
///         data: SfThemeData(
///           chartThemeData: SfChartThemeData(
///             backgroundColor: Colors.grey,
///             brightness: Brightness.dark
///           )
///         ),
///         child: SfCartesianChart(
///         )
///       ),
///     )
///   );
/// }
/// ```
class SfThemeT extends StatelessWidget {
  /// Creating an argument constructor of SfTheme class.
  const SfThemeT({
    Key? key,
    this.data,
    required this.child,
  }) : super(key: key);

  /// Specifies a widget that can hold single child.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     body: Center(
  ///       child: SfTheme(
  ///         data: SfThemeData(
  ///           chartThemeData: SfChartThemeData(
  ///             backgroundColor: Colors.grey,
  ///             brightness: Brightness.dark
  ///           )
  ///         ),
  ///         child: SfCartesianChart(
  ///         )
  ///       ),
  ///     )
  ///   );
  /// }
  /// ```
  final Widget child;

  /// Specifies the color and typography values for descendant widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///   return Scaffold(
  ///     body: Center(
  ///       child: SfTheme(
  ///         data: SfThemeData(
  ///           chartThemeData: SfChartThemeData(
  ///             backgroundColor: Colors.grey,
  ///             brightness: Brightness.dark
  ///           )
  ///         ),
  ///         child: SfCartesianChart(
  ///         )
  ///       ),
  ///     )
  ///   );
  /// }
  /// ```
  final SfThemeDataT? data;

  //ignore: unused_field
  static final SfThemeDataT _kFallbackTheme = SfThemeDataT.fallback();

  /// The data from the closest [SfTheme] instance that encloses the given
  /// context.
  ///
  /// Defaults to [SfThemeData.fallback] if there is no [SfTheme] in the given
  /// build context.
  ///
  static SfThemeDataT of(BuildContext context) {
    final _SfInheritedTheme? inheritedTheme =
    context.dependOnInheritedWidgetOfExactType<_SfInheritedTheme>();
    return inheritedTheme?.data ??
        (Theme.of(context).colorScheme.brightness == Brightness.light
            ? SfThemeDataT.light()
            : SfThemeDataT.dark());
  }

  @override
  Widget build(BuildContext context) {
    return _SfInheritedTheme(data: data, child: child);
  }
}

class _SfInheritedTheme extends InheritedTheme {
  const _SfInheritedTheme({Key? key, this.data, required Widget child})
      : super(key: key, child: child);

  final SfThemeDataT? data;

  @override
  bool updateShouldNotify(_SfInheritedTheme oldWidget) =>
      data != oldWidget.data;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _SfInheritedTheme? ancestorTheme =
    context.findAncestorWidgetOfExactType<_SfInheritedTheme>();
    return identical(this, ancestorTheme)
        ? child
        : SfThemeT(data: data, child: child);
  }
}

/// Holds the color and typography values for light and dark themes. Use
///  this class to configure a [SfTheme] widget.
///
/// To obtain the current theme, use [SfTheme.of].
///
/// ```dart
/// Widget build(BuildContext context) {
///   return Scaffold(
///     body: Center(
///       child: SfTheme(
///         data: SfThemeData(
///           chartThemeData: SfChartThemeData(
///             backgroundColor: Colors.grey,
///             brightness: Brightness.dark
///           )
///         ),
///         child: SfCartesianChart(
///         )
///       ),
///     )
///   );
/// }
/// ```
@immutable
class SfThemeDataT with Diagnosticable {
  /// Creating an argument constructor of SfThemeData class.
  factory SfThemeDataT(
      {Brightness? brightness,
        SfPdfViewerThemeDataT? pdfViewerThemeData,
        SfChartThemeDataT? chartThemeData,
        SfCalendarThemeDataT? calendarThemeData,
        SfDataGridThemeDataT? dataGridThemeData,
        SfDataPagerThemeDataT? dataPagerThemeData,
        SfDateRangePickerThemeDataT? dateRangePickerThemeData,
        SfBarcodeThemeDataT? barcodeThemeData,
        SfGaugeThemeDataT? gaugeThemeData,
        SfSliderThemeDataT? sliderThemeData,
        SfRangeSliderThemeDataT? rangeSliderThemeData,
        SfRangeSelectorThemeDataT? rangeSelectorThemeData,
        SfMapsThemeDataT? mapsThemeData}) {
    brightness ??= Brightness.light;
    pdfViewerThemeData =
        pdfViewerThemeData ?? SfPdfViewerThemeDataT(brightness: brightness);
    chartThemeData = chartThemeData ?? SfChartThemeDataT(brightness: brightness);
    calendarThemeData =
        calendarThemeData ?? SfCalendarThemeDataT(brightness: brightness);
    dataGridThemeData =
        dataGridThemeData ?? SfDataGridThemeDataT(brightness: brightness);
    dateRangePickerThemeData = dateRangePickerThemeData ??
        SfDateRangePickerThemeDataT(brightness: brightness);
    barcodeThemeData =
        barcodeThemeData ?? SfBarcodeThemeDataT(brightness: brightness);
    gaugeThemeData = gaugeThemeData ?? SfGaugeThemeDataT(brightness: brightness);
    sliderThemeData =
        sliderThemeData ?? SfSliderThemeDataT(brightness: brightness);
    rangeSelectorThemeData = rangeSelectorThemeData ??
        SfRangeSelectorThemeDataT(brightness: brightness);
    rangeSliderThemeData =
        rangeSliderThemeData ?? SfRangeSliderThemeDataT(brightness: brightness);
    mapsThemeData = mapsThemeData ?? SfMapsThemeDataT(brightness: brightness);
    dataPagerThemeData =
        dataPagerThemeData ?? SfDataPagerThemeDataT(brightness: brightness);
    return SfThemeDataT.raw(
        brightness: brightness,
        pdfViewerThemeData: pdfViewerThemeData,
        chartThemeData: chartThemeData,
        calendarThemeData: calendarThemeData,
        dataGridThemeData: dataGridThemeData,
        dataPagerThemeData: dataPagerThemeData,
        dateRangePickerThemeData: dateRangePickerThemeData,
        barcodeThemeData: barcodeThemeData,
        gaugeThemeData: gaugeThemeData,
        sliderThemeData: sliderThemeData,
        rangeSelectorThemeData: rangeSelectorThemeData,
        rangeSliderThemeData: rangeSliderThemeData,
        mapsThemeData: mapsThemeData);
  }

  /// Create a [SfThemeData] given a set of exact values. All the values must be
  /// specified.
  ///
  /// This will rarely be used directly. It is used by [lerp] to
  /// create intermediate themes based on two themes created with the
  /// [SfThemeData] constructor.
  ///
  const SfThemeDataT.raw(
      {required this.brightness,
        required this.pdfViewerThemeData,
        required this.chartThemeData,
        required this.calendarThemeData,
        required this.dataGridThemeData,
        required this.dateRangePickerThemeData,
        required this.barcodeThemeData,
        required this.gaugeThemeData,
        required this.sliderThemeData,
        required this.rangeSelectorThemeData,
        required this.rangeSliderThemeData,
        required this.mapsThemeData,
        required this.dataPagerThemeData});

  /// This method returns the light theme when no theme has been specified.
  factory SfThemeDataT.light() => SfThemeDataT(brightness: Brightness.light);

  /// This method is used to return the dark theme.
  factory SfThemeDataT.dark() => SfThemeDataT(brightness: Brightness.dark);

  /// The default color theme. Same as [SfThemeData.light].
  ///
  /// This is used by [SfTheme.of] when no theme has been specified.
  factory SfThemeDataT.fallback() => SfThemeDataT.light();

  /// The brightness of the overall theme of the
  /// application for the Syncusion widgets.
  ///
  /// If [brightness] is not specified, then based on the
  /// [Theme.of(context).brightness], brightness for
  /// Syncfusion widgets will be applied.
  ///
  /// Also refer [Brightness].
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            brightness: Brightness.dark
  ///          ),
  ///          child: SfCartesianChart(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final Brightness brightness;

  /// Defines the default configuration of [SfPdfViewer] widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            pdfViewerThemeData: SfPdfViewerThemeData()
  ///          ),
  ///      child: SfPdfViewer.asset(
  ///           'assets/flutter-succinctly.pdf',
  ///         ),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfPdfViewerThemeDataT pdfViewerThemeData;

  /// Defines the default configuration of chart widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            chartThemeData: SfChartThemeData()
  ///          ),
  ///          child: SfCartesianChart(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfChartThemeDataT chartThemeData;

  /// Defines the default configuration of datagrid widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            dataGridThemeData: SfDataGridThemeData()
  ///          ),
  ///          child: SfDataGrid(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfDataGridThemeDataT dataGridThemeData;

  /// Defines the default configuration of datepicker widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            dateRangePickerThemeData: SfDateRangePickerThemeData()
  ///          ),
  ///          child: SfDateRangePicker(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfDateRangePickerThemeDataT dateRangePickerThemeData;

  /// Defines the default configuration of calendar widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            calendarThemeData: SfCalendarThemeData()
  ///          ),
  ///          child: SfCalendar(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfCalendarThemeDataT calendarThemeData;

  /// Defines the default configuration of barcode widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            barcodeThemeData: SfBarcodeThemeData()
  ///          ),
  ///          child: SfBarcodeGenerator(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfBarcodeThemeDataT barcodeThemeData;

  /// Defines the default configuration of gauge widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            gaugeThemeData: SfGaugeThemeData()
  ///          ),
  ///          child: SfRadialGauge(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfGaugeThemeDataT gaugeThemeData;

  /// Defines the default configuration of range selector widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            rangeSelectorThemeData: SfRangeSelectorThemeData()
  ///          ),
  ///          child: SfRangeSelector(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfRangeSelectorThemeDataT rangeSelectorThemeData;

  /// Defines the default configuration of range slider widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            rangeSliderThemeData: SfRangeSliderThemeData()
  ///          ),
  ///          child: SfRangeSlider(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfRangeSliderThemeDataT rangeSliderThemeData;

  /// Defines the default configuration of slider widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            sliderThemeData: SfSliderThemeData()
  ///          ),
  ///          child: SfSlider(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfSliderThemeDataT sliderThemeData;

  /// Defines the default configuration of maps widgets.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///  return Scaffold(
  ///    appBar: AppBar(),
  ///      body: Center(
  ///        child: SfTheme(
  ///          data: SfThemeData(
  ///            mapsThemeData: SfMapsThemeData()
  ///          ),
  ///          child: SfMaps(),
  ///        ),
  ///      )
  ///   );
  /// }
  /// ```
  final SfMapsThemeDataT mapsThemeData;

  ///ToDO
  final SfDataPagerThemeDataT dataPagerThemeData;

  /// Creates a copy of this theme but with the given
  /// fields replaced with the new values.
  SfThemeDataT copyWith(
      {Brightness? brightness,
        SfPdfViewerThemeDataT? pdfViewerThemeData,
        SfChartThemeDataT? chartThemeData,
        SfCalendarThemeDataT? calendarThemeData,
        SfDataGridThemeDataT? dataGridThemeData,
        SfDateRangePickerThemeDataT? dateRangePickerThemeData,
        SfBarcodeThemeDataT? barcodeThemeData,
        SfGaugeThemeDataT? gaugeThemeData,
        SfSliderThemeDataT? sliderThemeData,
        SfRangeSelectorThemeDataT? rangeSelectorThemeData,
        SfRangeSliderThemeDataT? rangeSliderThemeData,
        SfMapsThemeDataT? mapsThemeData,
        SfDataPagerThemeDataT? dataPagerThemeData}) {
    return SfThemeDataT.raw(
        brightness: brightness ?? this.brightness,
        pdfViewerThemeData: pdfViewerThemeData ?? this.pdfViewerThemeData,
        chartThemeData: chartThemeData ?? this.chartThemeData,
        calendarThemeData: calendarThemeData ?? this.calendarThemeData,
        dataGridThemeData: dataGridThemeData ?? this.dataGridThemeData,
        dataPagerThemeData: dataPagerThemeData ?? this.dataPagerThemeData,
        dateRangePickerThemeData:
        dateRangePickerThemeData ?? this.dateRangePickerThemeData,
        barcodeThemeData: barcodeThemeData ?? this.barcodeThemeData,
        gaugeThemeData: gaugeThemeData ?? this.gaugeThemeData,
        sliderThemeData: sliderThemeData ?? this.sliderThemeData,
        rangeSelectorThemeData:
        rangeSelectorThemeData ?? this.rangeSelectorThemeData,
        rangeSliderThemeData: rangeSliderThemeData ?? this.rangeSliderThemeData,
        mapsThemeData: mapsThemeData ?? this.mapsThemeData);
  }

  /// Linearly interpolate between two themes.
  static SfThemeDataT lerp(SfThemeDataT? a, SfThemeDataT? b, double t) {
    assert(a != null);
    assert(b != null);

    return SfThemeDataT.raw(
        brightness: t < 0.5 ? a!.brightness : b!.brightness,
        pdfViewerThemeData: SfPdfViewerThemeDataT.lerp(
            a!.pdfViewerThemeData, b!.pdfViewerThemeData, t)!,
        chartThemeData:
        SfChartThemeDataT.lerp(a.chartThemeData, b.chartThemeData, t)!,
        calendarThemeData: SfCalendarThemeDataT.lerp(
            a.calendarThemeData, b.calendarThemeData, t)!,
        dataGridThemeData: SfDataGridThemeDataT.lerp(
            a.dataGridThemeData, b.dataGridThemeData, t)!,
        dataPagerThemeData: SfDataPagerThemeDataT.lerp(
            a.dataPagerThemeData, b.dataPagerThemeData, t)!,
        dateRangePickerThemeData: SfDateRangePickerThemeDataT.lerp(
            a.dateRangePickerThemeData, b.dateRangePickerThemeData, t)!,
        barcodeThemeData:
        SfBarcodeThemeDataT.lerp(a.barcodeThemeData, b.barcodeThemeData, t)!,
        gaugeThemeData:
        SfGaugeThemeDataT.lerp(a.gaugeThemeData, b.gaugeThemeData, t)!,
        sliderThemeData:
        SfSliderThemeDataT.lerp(a.sliderThemeData, b.sliderThemeData, t)!,
        rangeSelectorThemeData: SfRangeSelectorThemeDataT.lerp(
            a.rangeSelectorThemeData, b.rangeSelectorThemeData, t)!,
        rangeSliderThemeData: SfRangeSliderThemeDataT.lerp(
            a.rangeSliderThemeData, b.rangeSliderThemeData, t)!,
        mapsThemeData:
        SfMapsThemeDataT.lerp(a.mapsThemeData, b.mapsThemeData, t)!);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return other is SfThemeDataT &&
        other.brightness == brightness &&
        other.pdfViewerThemeData == pdfViewerThemeData &&
        other.chartThemeData == chartThemeData &&
        other.calendarThemeData == calendarThemeData &&
        other.dataGridThemeData == dataGridThemeData &&
        other.dataPagerThemeData == dataPagerThemeData &&
        other.dateRangePickerThemeData == dateRangePickerThemeData &&
        other.barcodeThemeData == barcodeThemeData &&
        other.gaugeThemeData == gaugeThemeData &&
        other.sliderThemeData == sliderThemeData &&
        other.rangeSelectorThemeData == rangeSelectorThemeData &&
        other.rangeSliderThemeData == rangeSliderThemeData &&
        other.mapsThemeData == mapsThemeData;
  }

  @override
  int get hashCode {
    final List<Object> values = <Object>[
      brightness,
      pdfViewerThemeData,
      chartThemeData,
      calendarThemeData,
      dataGridThemeData,
      dataPagerThemeData,
      dateRangePickerThemeData,
      barcodeThemeData,
      gaugeThemeData,
      sliderThemeData,
      rangeSelectorThemeData,
      rangeSliderThemeData,
      mapsThemeData
    ];
    return Object.hashAll(values);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    final SfThemeDataT defaultData = SfThemeDataT.fallback();
    properties.add(EnumProperty<Brightness>('brightness', brightness,
        defaultValue: defaultData.brightness));
    properties.add(DiagnosticsProperty<SfPdfViewerThemeDataT>(
        'pdfViewerThemeData', pdfViewerThemeData,
        defaultValue: defaultData.pdfViewerThemeData));
    properties.add(DiagnosticsProperty<SfChartThemeDataT>(
        'chartThemeData', chartThemeData,
        defaultValue: defaultData.chartThemeData));
    properties.add(DiagnosticsProperty<SfCalendarThemeDataT>(
        'calendarThemeData', calendarThemeData,
        defaultValue: defaultData.calendarThemeData));
    properties.add(DiagnosticsProperty<SfDataGridThemeDataT>(
        'dataGridThemeData', dataGridThemeData,
        defaultValue: defaultData.dataGridThemeData));
    properties.add(DiagnosticsProperty<SfDataPagerThemeDataT>(
        'dataPagerThemeData', dataPagerThemeData,
        defaultValue: defaultData.dataPagerThemeData));
    properties.add(DiagnosticsProperty<SfDateRangePickerThemeDataT>(
        'dateRangePickerThemeData', dateRangePickerThemeData,
        defaultValue: defaultData.dateRangePickerThemeData));
    properties.add(DiagnosticsProperty<SfBarcodeThemeDataT>(
        'barcodeThemeData', barcodeThemeData,
        defaultValue: defaultData.barcodeThemeData));
    properties.add(DiagnosticsProperty<SfGaugeThemeDataT>(
        'gaugeThemeData', gaugeThemeData,
        defaultValue: defaultData.gaugeThemeData));
    properties.add(DiagnosticsProperty<SfRangeSelectorThemeDataT>(
        'rangeSelectorThemeData', rangeSelectorThemeData,
        defaultValue: defaultData.rangeSelectorThemeData));
    properties.add(DiagnosticsProperty<SfRangeSliderThemeDataT>(
        'rangeSliderThemeData', rangeSliderThemeData,
        defaultValue: defaultData.rangeSliderThemeData));
    properties.add(DiagnosticsProperty<SfSliderThemeDataT>(
        'sliderThemeData', sliderThemeData,
        defaultValue: defaultData.sliderThemeData));
    properties.add(DiagnosticsProperty<SfMapsThemeDataT>(
        'mapsThemeData', mapsThemeData,
        defaultValue: defaultData.mapsThemeData));
  }
}
