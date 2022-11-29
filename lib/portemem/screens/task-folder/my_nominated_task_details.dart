import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../widgets/bottom_appBar.dart';

class MyNominatedTaskDetails extends StatefulWidget {
  Map taskList;
  MyNominatedTaskDetails({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  @override
  State<MyNominatedTaskDetails> createState() => _MyNominatedTaskDetailsState();
}

class _MyNominatedTaskDetailsState extends State<MyNominatedTaskDetails> {
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});

  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? endDate;

  @override
  Widget build(BuildContext context) {
    String _taskDef = widget.taskList["GorevTanimi"] ?? '';
    String _taskNom = widget.taskList["GoreviAtayanAdiSoyadi"] ?? '';
    String _taskResp = widget.taskList["AdiSoyadi"] ?? '';
    String _taskType = widget.taskList[""] ?? '';
    String _taskStartDate = widget.taskList["FormGorevBaslangicFormatli"] ?? '';
    String _taskEndDate = widget.taskList["FormGorevBitisFormatli"] ?? '';
    String _taskState = widget.taskList["GorevinDurumuText"] ?? '';
    String _comment = widget.taskList["GorevinAciklamasi"] ?? '';
    String _persInfo = widget.taskList[""] ?? '';

    return Scaffold(
      appBar: AppBar(
          backgroundColor: blueColor,
          elevation: 0.0,
          title: Center(
              child: Text(
                "Görev Detayları",
                style: TextStyle(color: Colors.white),
              ))
      ),
      backgroundColor: Color(0xffF2F2F2),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                margin: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          color: blueColor,
                          alignment: Alignment.center,
                          padding:
                          const EdgeInsets.symmetric(
                              horizontal: 10.0),
                          child: new Text(
                            "",
                            style: new TextStyle(
                                color: Colors.white,
                                fontWeight:
                                FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 40),
                                child: Text(
                                  "Görev Tanımı",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10),
                                child: TextFormField(
                                  initialValue: _taskDef,
                                  decoration:
                                  InputDecoration(
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 20),
                                child: Text(
                                  "Görev Atayan",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10),
                                child: TextFormField(
                                  initialValue: _taskNom,
                                  decoration:
                                  InputDecoration(
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 20),
                                child: Text(
                                  "Görev Sorumlusu",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10),
                                child: TextFormField(
                                  initialValue: _taskResp,
                                  decoration:
                                  InputDecoration(
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                ),
                              ),

                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 20),
                                child: Text(
                                  "Başlangıç Tarihi",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20,
                                    right: 10,
                                    top: 10),
                                child: TextFormField(
                                  initialValue:
                                  _taskStartDate,
                                  decoration:
                                  InputDecoration(
                                    suffixIcon: Icon(
                                        Icons
                                            .date_range),
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                  onTap: () async {
                                    FocusScope.of(
                                        context)
                                        .requestFocus(
                                        new FocusNode());
                                    await _openDatePicker1(
                                        context);
                                    _taskStartDate
                                    = DateFormat(
                                        'dd/MM/yyyy')
                                        .format(
                                        dateTime1!);
                                  },
                                  onSaved: (val) {
                                    strDate = val;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 20),
                                child: Text(
                                  "Bitiş Tarihi",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 20),
                                child: TextFormField(
                                  initialValue: _taskEndDate,
                                  decoration:
                                  InputDecoration(
                                    suffixIcon: Icon(
                                        Icons
                                            .date_range),
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                  onTap: () async {
                                    FocusScope.of(
                                        context)
                                        .requestFocus(
                                        new FocusNode());
                                    await _openDatePicker2(
                                        context);
                                    _taskEndDate
                                    = DateFormat(
                                        'dd/MM/yyyy')
                                        .format(
                                        dateTime2!);
                                  },
                                  onSaved: (val) {
                                    endDate = val;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 20),
                                child: Text(
                                  "Görev Durumu",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10),
                                child: TextFormField(
                                  initialValue: _taskState,
                                  decoration:
                                  InputDecoration(
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 20),
                                child: Text(
                                  "Bilgilendirecek Kişiler",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10),
                                child: TextFormField(
                                  initialValue: _persInfo,
                                  decoration:
                                  InputDecoration(
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 20),
                                child: Text(
                                  "Açıklama",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 20),
                                child: TextFormField(
                                  initialValue: _comment,
                                  keyboardType:
                                  TextInputType
                                      .multiline,
                                  minLines: 4,
                                  maxLines: null,
                                  decoration:
                                  InputDecoration(
                                    hintText:
                                    "Yazınız...",
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 35, right: 35),
                          child: ElevatedButton(
                              style: ElevatedButton
                                  .styleFrom(
                                  minimumSize:
                                  Size(290, 45),
                                  primary: blueColor),
                              onPressed: () {
                                if(formKey.currentState!.validate()){
                                  formKey.currentState!.save();
                                  /* addTask(
                                                          Hive.box("userbox").get("UyeID"),
                                                          taskDef.text,
                                                          taskNomi.text,
                                                          taskType.text,
                                                          taskResp.text,
                                                          taskStartedDate.text,
                                                          taskEndDate.text,
                                                          taskState.text,
                                                          taskComment.text);*/
                                }
                              },
                              child: Text(
                                "Kaydet",
                                style: TextStyle(
                                    fontSize: 17),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(),
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
}
