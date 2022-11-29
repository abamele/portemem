import 'package:date_time_picker/date_time_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:portemem/portemem/constants/apiUrl.dart';
import 'package:portemem/portemem/constants/colors.dart';

class AddMeting extends StatefulWidget {
  const AddMeting({Key? key}) : super(key: key);

  @override
  State<AddMeting> createState() => _AddMetingState();
}

class _AddMetingState extends State<AddMeting> {
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});
  TextEditingController text = TextEditingController();
/*  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();*/
  TextEditingController comment = TextEditingController();
  String startDate = '';
  String _valueToValidate1 = '';
  String _valueSaved1 = '';
  String endDate = '';
  String _valueToValidate2 = '';
  String _valueSaved2 = '';
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? enddate;
  int _value1 = 0;
  int _value2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Takvim Oluşur"),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Konu",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              controller: text,
              decoration: InputDecoration(
                hintText: "Yazınız...",
                helperStyle: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Başlangıç Tarihi",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: DateTimePicker(
              type: DateTimePickerType.dateTime,
              dateMask: 'dd/MM/yyyy - HH:mm ',
              //controller: _controller1,
              //initialValue: _initialValue,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              //icon: Icon(Icons.event),
              //dateLabelText: 'Date Time',
              use24HourFormat: false,
              locale: Locale('tr', 'TR'),
              onChanged: (val) => setState(() {
                startDate = val;
                print(".........new value.....................${startDate}");
              }),
              validator: (val) {
                setState(() => _valueToValidate2 = val ?? '');
                return null;
              },
              onSaved: (val) => setState(() => _valueSaved2 = val ?? ''),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Bitiş Tarihi",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: DateTimePicker(
              type: DateTimePickerType.dateTime,
              dateMask: 'dd/MM/yyyy - HH:mm ',
              //controller: _controller2,
              //initialValue: _initialValue,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              //icon: Icon(Icons.event),
              //dateLabelText: 'Date Time',
              use24HourFormat: false,
              locale: Locale('tr', 'TR'),
              onChanged: (val) => setState(() {
                endDate = val;
                print(".........new value.....................${endDate}");
              }),
              validator: (val) {
                setState(() => _valueToValidate2 = val ?? '');
                return null;
              },
              onSaved: (val) => setState(() => _valueSaved2 = val ?? ''),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Açıklama",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 20),
            child: TextFormField(
              controller: comment,
              minLines: 4,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Yazınız...",
                helperStyle: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: blueColor, minimumSize: Size(290, 50)),
              child: Text("Kaydet"),
              onPressed: () {
                showBusinessLoginDialog();
                addMeeting(Hive.box("userbox").get("UyeID"), text.text,
                    startDate, endDate, comment.text);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _openDatePicker1(BuildContext context) async {
    dateTime1 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: blueColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: blueColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: blueColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
  }

  Future<void> _openDatePicker2(BuildContext context) async {
    dateTime2 = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: blueColor, // header background color
                onPrimary: Colors.white, // header text color
                onSurface: blueColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: blueColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
  }

  Future addMeeting(
    int? uyeId,
    String konu,
    String baslangicT,
    String bitisT,
    String not,
  ) async {
    try {
      var response = await Dio().post(AppUrl.addMyCalendar, data: {
        "UyeId": uyeId,
        "Id": "",
        "text": konu,
        "description": not,
        "startDate": baslangicT,
        "endDate": bitisT
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Not Oluşturuldu",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/my_calendar", (route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
      print("..................................$response");
      return response;
    } on DioError catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("${e.response!.data["message"]}"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Kapat"))
              ],
            );
          });
    }
  }

  showBusinessLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ValueListenableBuilder(
              valueListenable: _loginLoading,
              builder: (BuildContext context, Map value, Widget? child) {
                if (value["state"] == 0) {
                  return WillPopScope(
                      child: Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      onWillPop: () async => false);
                } else if (value["state"] == 1) {
                  Future.delayed(Duration.zero, () {
                    Navigator.pushNamedAndRemoveUntil(context, "/customer_list",
                            (Route<dynamic> route) => false);
                  });
                  return WillPopScope(
                      child: Container(
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      onWillPop: () async => false);
                } else {
                  return AlertDialog(
                    title: Text(value["message"]),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Tamam"))
                    ],
                  );
                }
              });
        }).then((value) => _loginLoading.value = {"state": 0, "message": ""});
  }
}
