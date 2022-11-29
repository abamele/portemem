import 'dart:math';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// The hove page which hosts the calendar
class CalendarApi extends StatefulWidget {
  /// Creates the home page to display teh calendar widget.
  const CalendarApi({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CalendarApiState createState() => _CalendarApiState();
}

class _CalendarApiState extends State<CalendarApi> {

  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            child: FutureBuilder(
                future: getDataFromApi(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return SafeArea(
                        child: Container(
                          child: SfCalendar(
                            view: CalendarView.month,
                            dataSource: _MeetingDataSource(snapshot.data),
                            monthViewSettings:
                            const MonthViewSettings(showAgenda: true),
                            initialDisplayDate: snapshot.data[0].from,
                          ),
                        ));
                  } else {
                    return Container(
                      child: Center(child: Text("loading...")),
                    );
                  }
                }),
          ),
        ));
  }

  Future<List<_Meeting>> getDataFromApi() async {
    final data = await Dio().get("http://10.0.2.2:3000/data");
    var jsonAppData = json.decode(data.data.toString() ) as List;
    print(".................test....................................${jsonAppData.toString()}");
    final List<_Meeting> appointmentData = [];
    final Random random = Random();
    for (dynamic data in jsonAppData) {
      _Meeting _meeting = _Meeting(
        eventName: data['subject'],
        from: _convertDateFromString(data['statTime']),
        to: _convertDateFromString(data['endTime']),
        background: Colors.red,
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
class _MeetingDataSource extends CalendarDataSource {
  _MeetingDataSource(List<_Meeting> source) {
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
    return appointments![index].isAllDay;
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

class _Meeting {
  _Meeting({
    this.eventName = '',
    this.from,
    this.to,
    this.background,
    this.isAllDay,
  });

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
}
