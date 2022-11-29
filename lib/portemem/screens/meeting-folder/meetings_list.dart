import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:portemem/portemem/constants/colors.dart';
import '../../constants/apiUrl.dart';
import '../../widgets/bottom_appBar.dart';
import 'meeting_details.dart';

class MeetingList extends StatefulWidget {
  List customer;
  List contact;
  MeetingList({Key? key, required this.customer, required this.contact})
      : super(key: key);

  @override
  State<MeetingList> createState() => _MeetingListState();
}

class _MeetingListState extends State<MeetingList> {
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});

  TextEditingController cutomerName = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController meetingG = TextEditingController();
  TextEditingController meetingT = TextEditingController();
  TextEditingController meetingStartDate = TextEditingController();
  TextEditingController meetingEndDate = TextEditingController();
  TextEditingController _comment = TextEditingController();

  final formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;
  String? endDate;

  int value1 = 0;
  int value2 = 0;
  int value3 = 0;
  int value4 = 0;

  List meetingList = [
    "Yayın Tanıtımı",
    "Rutin Ziyaret",
    "Yeni Tamışma",
    "Genel Görüşme"
  ];
  List meetingTypeList = ["Online", "Yüz Yüze", "Telefon"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: blueColor,
          elevation: 0.0,
          title: Center(
              child: Text(
            "Toplantılar",
            style: TextStyle(color: Colors.white),
          ))),
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
                  minimumSize: Size(290, 45),
                  primary: blueColor,
                ),
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
                                        "Yetkili Ekle",
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Müşteri",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            margin: const EdgeInsets.all(10.0),
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
                                                value: value1,
                                                items: customerListDropdown(
                                                    "Seçiniz..."),
                                                onChanged: (int? value) {
                                                  value1 = value!;
                                                  if (value1 == 0) {
                                                    value = 0;
                                                  }
                                                  setState(() {});
                                                },
                                                hint: const Text("Seçiniz...")),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Yetkililer",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            margin: const EdgeInsets.all(10.0),
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
                                                value: value2,
                                                items: contactListDropdown(
                                                    "Seçiniz..."),
                                                onChanged: (int? value) {
                                                  value2 = value!;
                                                  if (value2 == 0) {
                                                    value = 0;
                                                  }
                                                  setState(() {});
                                                },
                                                hint: const Text("Seçiniz...")),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Toplantı Türleri",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            margin: const EdgeInsets.all(10.0),
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
                                                value: value3,
                                                items: meetingDropdownList(
                                                    "Seçiniz..."),
                                                onChanged: (int? value) {
                                                  value3 = value!;
                                                  if (value3 == 0) {
                                                    value = 0;
                                                  }
                                                  setState(() {});
                                                },
                                                hint: const Text("Seçiniz...")),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Toplantı Tipi",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                            ),
                                            margin: const EdgeInsets.all(10.0),
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
                                                value: value4,
                                                items: meetingTypeDropdownList(
                                                    "Seçiniz..."),
                                                onChanged: (int? value) {
                                                  value4 = value!;
                                                  if (value4 == 0) {
                                                    value = 0;
                                                  }
                                                  setState(() {});
                                                },
                                                hint: const Text("Seçiniz...")),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Başlangiç Tarihi",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, right: 10, top: 10),
                                          child: TextFormField(
                                            controller: meetingStartDate,
                                            decoration: InputDecoration(
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
                                              await _openDatePicker1(context);
                                              meetingStartDate.text =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(dateTime1!);
                                            },
                                            onSaved: (val) {
                                              strDate = val;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
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
                                              left: 20, right: 20, top: 20),
                                          child: TextFormField(
                                            controller: meetingEndDate,
                                            decoration: InputDecoration(
                                              hintText: 'Yazınız',
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
                                              await _openDatePicker2(context);
                                              meetingEndDate.text =
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(dateTime2!);
                                            },
                                            onSaved: (val) {
                                              endDate = val;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Notlar",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10,
                                            ),
                                            child: TextFormField(
                                              minLines: 4,
                                              maxLines: null,
                                              //controller: address,
                                              decoration: InputDecoration(
                                                hintText: "Yazınız...",
                                                helperStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 17),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: Size(290, 45),
                                            primary: blueColor),
                                        child: Text("Kaydet"),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            print(
                                                "..........verifffffffffff.................${value1.toString()}");
                                            formKey.currentState!.save();
                                            //showBusinessLoginDialog();
                                            addMeeting(
                                                Hive.box("userbox")
                                                    .get("UyeID"),
                                                value1.toString(),
                                                contact.text,
                                                meetingG.text,
                                                meetingT.text,
                                                meetingStartDate.text,
                                                meetingEndDate.text,
                                                _comment.text);
                                            print(
                                                "............uyeıd...............................${Hive.box("userbox").get("UyeID").toString()}");
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        "Lütfen zorunlu alanları giriniz."),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Kapat"))
                                                    ],
                                                  );
                                                });
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                      });
                },
                child: Text(
                  "Toplantı Ekle",
                  style: TextStyle(
                    fontSize: 17,
                  ),
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
                          future: getMeetingList(takeValue),
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
                            List meeting = data["Veri"];
                            return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: meeting.length,
                                itemBuilder: (context, index) {
                                  final _meetingNo = meeting[index]
                                          ["AktiviteKodu"]
                                      .toString()
                                      .toLowerCase();
                                  final _customerName = meeting[index]
                                          ["MusteriAdi"]
                                      .toString()
                                      .toLowerCase();
                                  final _meetingContact = meeting[index]
                                          ["KontakYetkiliListeIDs"]
                                      .toString()
                                      .toLowerCase();
                                  final _startDate = meeting[index]
                                          ["BaslangicTarihiFormatli"]
                                      .toString()
                                      .toLowerCase();
                                  final _endDate = meeting[index]
                                          ["BitisTarihiFormatli"]
                                      .toString()
                                      .toLowerCase();

                                  if (_meetingNo.contains(searchValue) ||
                                      _customerName.contains(searchValue) ||
                                      _startDate.contains(searchValue) ||
                                      _endDate.contains(searchValue)) {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20, top: 20),
                                          child: Card(
                                            elevation: 8.0,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  color: blueColor,
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                          .symmetric(
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
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "Toplantı No",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "${_meetingNo}",
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "Müşteri Adı",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "${_customerName}",
                                                  ),
                                                ),
                                                /*Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "Toplantı Yetkilileri",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "",
                                                  ),
                                                ),*/
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "Başlangıç Tarihi",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "${_startDate}",
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "Bitiş Tarihi",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(15),
                                                  child: Text(
                                                    "${_endDate}",
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                ),
                                                Center(
                                                  child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        minimumSize:
                                                            Size(290, 45),
                                                        primary: Colors.white,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        MeetingDetails(
                                                                          meeting:
                                                                              meeting[index],
                                                                          contact:
                                                                              widget.contact[index],
                                                                        )));
                                                      },
                                                      child: Text(
                                                        "Müşteri Detayları",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.grey),
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
                                  }
                                  return Container();
                                });
                          });
                    });
              }),
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  customerListDropdown(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = meetingList;
    for (var i = 0; i < customer.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              customer[i - 1],
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  contactListDropdown(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = meetingList;
    for (var i = 0; i < customer.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              customer[i - 1],
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  meetingDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List meeting = meetingList;
    for (var i = 0; i < meeting.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              meeting[i - 1],
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  meetingTypeDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List meeting = meetingTypeList;
    for (var i = 0; i < meetingTypeList.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              meeting[i - 1],
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
                primary: Color(0xff5858FF), // header background color
                onPrimary: Colors.white, // header text color
                onSurface: Color(0xff5858FF), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Color(0xff5858FF), // button text color
                ),
              ),
            ),
            child: child!,
          );
        });
  }

  Future getMeetingList(int take) async {
    try {
      var response = await Dio().post(AppUrl.meetingList, data: {
        "sort": [
          {"selector": "string", "desc": true}
        ],
        "group": {},
        "requireTotalCount": true,
        "searchOperation": "string",
        "skip": 0,
        "take": take,
        "userDatas": [
          {"SelectedField": "string", "SelectedValue": "string"}
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
    } on DioError catch (e) {
      if (e.response!.data["errorCode"] == 2023) {}
    }
  }

  Future addMeeting(
      String? uyeId,
      String musteriAdi,
      String kontakAdi,
      String aktiviteTuru,
      String aktivitetiTipi,
      String baslangicT,
      String bitisT,
      String not) async {
    try {
      var response = await Dio().post(AppUrl.addMeeting, data: {
        "UyeId": uyeId,
        "AktiviteKodu": 0,
        "KontakID": "string",
        "MusteriAdi": musteriAdi,
        "KontakAdi": kontakAdi,
        "AktiviteTuru": aktiviteTuru,
        "AktiviteTipi": aktivitetiTipi,
        "Aciklama": not,
        "AktiviteDurumu": "string",
        "ToplantiBaslangic": "2022-09-09T06:16:44.634Z",
        "ToplantiBitis": "2022-09-09T06:16:44.634Z",
        "OlusturmaTarihi": "string",
        "OlusKullanici": "string",
        "Email": "string",
        "MusteriID": "string",
        "BaslangicTarihiFormatli": baslangicT,
        "BitisTarihiFormatli": bitisT,
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
