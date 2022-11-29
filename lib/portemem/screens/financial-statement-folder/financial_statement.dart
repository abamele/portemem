import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:portemem/portemem/constants/colors.dart';
import 'package:portemem/portemem/sfcalendar-extrait/calendar_view_day.dart';
import 'package:portemem/portemem/sfcalendar-extrait/month_view_setting.dart';
import 'package:portemem/portemem/sfcalendar-extrait/sfcalendar.dart';

import '../../constants/apiUrl.dart';
import '../../sfcalendar-extrait/calendar_data_source.dart';
import '../../widgets/bottom_appBar.dart';
import 'financial_statement_model.dart';

/// The hove page which hosts the calendar
class FinancialStatementPage extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  FinancialStatementPage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FinancialStatementPageState createState() => _FinancialStatementPageState();
}

class _FinancialStatementPageState extends State<FinancialStatementPage> {
  List<Color>? _colorCollection;
  MeetingDataSource? events;

  @override
  void initState() {
    _initializeEventColor();
    getDataFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: blueColor,
        title: Center(
          child: Text("Mali Tablolar"),
        ),
      ),
      body: SafeArea(
        child: Container(
            child: FutureBuilder(
                future: getDataFromApi(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Bir şeyler yanlış gitti');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return SafeArea(
                      child: Container(
                        child: SfCalendarT(
                          view: CalendarViewT.month,
                          showDatePickerButton: true,
                          monthViewSettings:
                          const MonthViewSettingsT(showAgenda: true),
                          dataSource: MeetingDataSource(snapshot.data),
                          initialDisplayDate: snapshot.data[0].from,
                          onClick: (){
                            _showDayEventsInModalSheet();
                          },
                        ),
                      ));
                })),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  void _showDayEventsInModalSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
        isScrollControlled: true,
        context: context,
        builder: (context) => SizedBox(
              height: 170,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: blueColor, minimumSize: Size(249, 50)),
                      onPressed: () {
                        Navigator.pushNamed(
                            context, "/add_financial_statement");
                      },
                      child: Text("Takvim Oluşur"))
                ],
              ),
            ));
  }

  void _initializeEventColor() {
    this._colorCollection = <Color>[];
    _colorCollection!.add(const Color(0xFF0F8644));
    _colorCollection!.add(const Color(0xFF8B1FA9));
    _colorCollection!.add(const Color(0xFFD20100));
    _colorCollection!.add(const Color(0xFFFC571D));
    _colorCollection!.add(const Color(0xFF36B37B));
    _colorCollection!.add(const Color(0xFF01A1EF));
    _colorCollection!.add(const Color(0xFF3D4FB5));
    _colorCollection!.add(const Color(0xFFE47C73));
    _colorCollection!.add(const Color(0xFF636363));
    _colorCollection!.add(const Color(0xFF0A8043));
  }

  Future<List<FinancialStatementModel>> getDataFromApi() async {
    var response = await Dio().post(AppUrl.finacialStatement, data: {});
    Map<String, dynamic> data = response.data as Map<String, dynamic>;
    List meeting = data["Veri"];
    final Random random = Random();
    final List<FinancialStatementModel> appointmentData = [];
    for (int i = 0; i < meeting.length; i++) {
      FinancialStatementModel _meeting = FinancialStatementModel(
        eventName: meeting[i]['text'] == "string" ? "" : meeting[i]['text'],
        from: _convertDateFromString(meeting[i]['startDate']),
        to: _convertDateFromString(meeting[i]['endDate']),
        background: blueColor,
      );
      appointmentData.add(_meeting);
    }

    return appointmentData;
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSourceT {
  MeetingDataSource(List<FinancialStatementModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay ?? true;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}
