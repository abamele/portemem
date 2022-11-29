import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:portemem/portemem/constants/colors.dart';
import '../../constants/apiUrl.dart';
import '../../widgets/bottom_appBar.dart';
import 'my_nominated_task_details.dart';

class MyNomitedTaskList extends StatefulWidget {
  List task;
  MyNomitedTaskList({Key? key, required this.task}) : super(key: key);

  @override
  State<MyNomitedTaskList> createState() => _MyNomitedTaskListState();
}

class _MyNomitedTaskListState extends State<MyNomitedTaskList> {
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  TextEditingController taskDef = TextEditingController();
  TextEditingController taskNomi = TextEditingController();
  TextEditingController taskType = TextEditingController();
  TextEditingController taskState = TextEditingController();
  TextEditingController taskComment = TextEditingController();
  TextEditingController taskStartedDate = TextEditingController();
  TextEditingController taskEndDate = TextEditingController();
  TextEditingController taskResp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});

  List txtState = ["Devam Ediyor", "Onaylandı", "Reddedildi", "İptal"];

  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? endDate;
  int _value1 = 0;
  int _value2 = 0;
  int _value3 = 0;
  int _value4 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isSroll) {
          return [
            SliverAppBar(
                backgroundColor: blueColor,
                elevation: 0.0,
                toolbarHeight: 80,
                title: Center(
                    child: Text(
                  "Atadığım Görevler",
                  style: TextStyle(color: Colors.white),
                )))
          ];
        },
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, right: 20, left: 20),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(),
              child: Center(
                child: TextField(
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: 'Ara...',
                      border: OutlineInputBorder()),
                  onChanged: (value) {
                    _searchTextNotify.value = value;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(290, 45), primary: blueColor),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              content: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50,
                                        color: blueColor,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: new Text(
                                          "Görev Ekle",
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 40),
                                              child: Text(
                                                "Görev Tanımı",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                controller: taskDef,
                                                decoration: InputDecoration(
                                                  hintText: "Yazınız... ",
                                                  helperStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      (BorderRadius.circular(
                                                          12))),
                                              child: DropdownButton(
                                                  isExpanded: true,
                                                  value: _value1,
                                                  items:
                                                      taskNominationDropdownList(
                                                          " Seçiniz..."),
                                                  onChanged: (int? value) {
                                                    _value1 = value!;
                                                    if (_value1 == 0) {
                                                      _value1 = 0;
                                                    }
                                                    setState(() {});
                                                  },
                                                  hint:
                                                      const Text("Seçiniz...")),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 20),
                                              child: Text(
                                                "Görev Sorumlusu",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      (BorderRadius.circular(
                                                          12))),
                                              child: DropdownButton(
                                                  isExpanded: true,
                                                  value: _value2,
                                                  items: taskRespDropdownList(
                                                      "Seçiniz..."),
                                                  onChanged: (int? value) {
                                                    _value2 = value!;
                                                    if (_value2 == 0) {
                                                      _value2 = 0;
                                                    }
                                                    setState(() {});
                                                  },
                                                  hint:
                                                      const Text("Seçiniz...")),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 20),
                                              child: Text(
                                                "Görev Tipi",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 20),
                                              child: TextFormField(
                                                controller: taskType,
                                                decoration: InputDecoration(
                                                  hintText: "Yazınız... ",
                                                  helperStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, right: 10, top: 10),
                                              child: TextFormField(
                                                controller: taskStartedDate,
                                                decoration: InputDecoration(
                                                  suffixIcon:
                                                      Icon(Icons.date_range),
                                                  hintText: 'Yazınız...',
                                                  helperStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
                                                ),
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  await _openDatePicker1(
                                                      context);
                                                  taskStartedDate.text =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(dateTime1!);
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 20),
                                              child: TextFormField(
                                                //controller: taskEndDate,
                                                decoration: InputDecoration(
                                                  hintText: 'Yazınız...',
                                                  suffixIcon:
                                                      Icon(Icons.date_range),
                                                  helperStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
                                                ),
                                                onTap: () async {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          new FocusNode());
                                                  await _openDatePicker2(
                                                      context);
                                                  taskEndDate.text =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(dateTime2!);
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
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      (BorderRadius.circular(
                                                          12))),
                                              child: DropdownButton(
                                                  isExpanded: true,
                                                  value: _value3,
                                                  items: offerStateDropdownList(
                                                      "Seçiniz..."),
                                                  onChanged: (int? value) {
                                                    _value3 = value!;
                                                    if (_value3 == 0) {
                                                      _value3 = 0;
                                                    }
                                                    setState(() {});
                                                  },
                                                  hint: const Text(
                                                      "Üye Seçiniz...")),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 20),
                                              child: Text(
                                                "Bilgilendirecek Kişiler",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 20),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                  ),
                                                  borderRadius:
                                                      (BorderRadius.circular(
                                                          12))),
                                              child: DropdownButton(
                                                  isExpanded: true,
                                                  value: _value4,
                                                  items:
                                                      persGetInfoListDropdownList(
                                                          "Seçiniz..."),
                                                  onChanged: (int? value) {
                                                    _value4 = value!;
                                                    if (_value4 == 0) {
                                                      _value4 = 0;
                                                    }
                                                    setState(() {});
                                                  },
                                                  hint: const Text(
                                                      "Üye Seçiniz...")),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 20),
                                              child: Text(
                                                "Açıklama",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 20),
                                              child: TextFormField(
                                                controller: taskComment,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                minLines: 4,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  hintText: "Yazınız...",
                                                  helperStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
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
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(290, 45),
                                                primary: blueColor),
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
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
                                              style: TextStyle(fontSize: 17),
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
                            );
                          });
                        });
                  },
                  child: Text(
                    "Görev Ekle",
                    style: TextStyle(fontSize: 17),
                  )),
            ),
            ValueListenableBuilder(
                valueListenable: _searchTextNotify,
                builder:
                    (BuildContext context, String searchValue, Widget? child) {
                  return ValueListenableBuilder(
                      valueListenable: take,
                      builder:
                          (BuildContext context, int takeValue, Widget? child) {
                        return FutureBuilder(
                            future: getMyTaskList(takeValue),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Bir şeyler yanlış gitti');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.data == null) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              Map<String, dynamic> data =
                                  snapshot.data.data as Map<String, dynamic>;
                              List task = data["Veri"];
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: task.length,
                                  itemBuilder: (context, index) {
                                    final _taskNo = task[index]["GorevID"]
                                        .toString()
                                        .toLowerCase();
                                    final _startDate = task[index]
                                            ["FormGorevBaslangicFormatli"]
                                        .toString()
                                        .toLowerCase();
                                    final _endDate = task[index]
                                            ["FormGorevBitisFormatli"]
                                        .toString()
                                        .toLowerCase();
                                    final _taskState = task[index]
                                            ["GorevinDurumuText"]
                                        .toString()
                                        .toLowerCase();
                                    List _taskResp =
                                        task[index]["GorevSorumlulari"] ?? "";

                                    if (_taskNo.contains(searchValue) ||
                                        _startDate.contains(searchValue) ||
                                        _endDate.contains(searchValue) ||
                                        _taskResp.contains(searchValue)) {
                                      return ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _taskResp.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(20),
                                                  child: Card(
                                                    elevation: 8.0,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 50,
                                                          color: blueColor,
                                                          alignment:
                                                              Alignment.center,
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10.0),
                                                          child: new Text(
                                                            "",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Görev No :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            "${_taskNo}",
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Görev Sorumlusu :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "${_taskResp[index]["AdiSoyadi"]}",
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Başlangıç Tarihi :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            "${_startDate}",
                                                            style: TextStyle(
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Bitiş Tarihi :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            "${_endDate}",
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Text(
                                                            "Görev Durumu :",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 17),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15.0),
                                                          child: Text(
                                                            "${_taskState}",
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                        ),
                                                        Center(
                                                          child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  minimumSize:
                                                                      Size(290,
                                                                          45),
                                                                  primary: Colors
                                                                      .white),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            MyNominatedTaskDetails(
                                                                              taskList: task[index],
                                                                            )));
                                                              },
                                                              child: Text(
                                                                "Görev Detayları",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Colors
                                                                        .grey),
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
                                              ],
                                            );
                                          });
                                    }
                                    return Container();
                                  });
                            });
                      });
                }),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  offerStateDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    //List state = widget.offerList;
    for (var i = 0; i < txtState.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              txtState[i - 1],
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
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

  taskNominationDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List taskNomination = widget.task;
    for (var i = 0; i < taskNomination.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              taskNomination[i - 1]["AdiSoyadi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  taskRespDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List taskResp = widget.task;
    print(
        "............sorumlusususssssssssssssss.......................................${taskResp}");
    for (var i = 0; i < taskResp.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              taskResp[i - 1]["AdiSoyadi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  persGetInfoListDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List taskResp = widget.task;
    print(
        "............sorumlusususssssssssssssss.......................................${taskResp}");
    for (var i = 0; i < taskResp.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              taskResp[i - 1]["AdiSoyadi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  Future getMyTaskList(int take) async {
    try {
      var response = await Dio().post(AppUrl.myNomtaskList, data: {
        "sort": [
          {"selector": "string", "desc": true}
        ],
        "group": {},
        "requireTotalCount": true,
        "searchOperation": "string",
        "skip": 0,
        "take": take,
        "userDatas": [
          {"SelectedField": "UyeID", "SelectedValue": "1"}
        ],
        "filter": [""],
        "filterSearchField": "string",
        "filterSearchValue": "string",
        "multiFilterSearch": {},
        "sortingFieldValue": "string",
        "sortingFieldDesc": "string",
        "multipleFilters": ["string"]
      });
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }

  Future addMeeting(
    String? uyeId,
    String musteriId,
  ) async {
    try {
      var response = await Dio().post(AppUrl.addContact, data: {
        "UyeId": uyeId,
        "AktiviteKodu": 0,
        "KontakID": "",
        "MusteriAdi": "string",
        "KontakAdi": "string",
        "AktiviteTuru": "string",
        "AktiviteTipi": "string",
        "Aciklama": "string",
        "AktiviteDurumu": "string",
        "ToplantiBaslangic": "2022-09-08T07:58:01.673Z",
        "ToplantiBitis": "2022-09-08T07:58:01.673Z",
        "OlusturmaTarihi": "string",
        "OlusKullanici": "string",
        "Email": "string",
        "MusteriID": musteriId,
        "BaslangicTarihiFormatli": "string",
        "BitisTarihiFormatli": "string",
        "FormBasTarihFormatli": "string",
        "FormBitisTarihFormatli": "string",
        "KontakListeIDs": ["string"],
        "KontakYetkiliListeIDs": ["string"],
        "ToplantiYetkilileri": [
          {
            "ID": 0,
            "ToplantiID": "string",
            "YetkiliID": "string",
            "KontakID": "string",
            "KontakAdi": "string"
          }
        ],
        "ToplantiYetkiliListeText": ["string"],
        "toplantituru": "string"
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Müşteri kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/customer_list", (route) => false);
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
