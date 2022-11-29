import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:portemem/portemem/constants/colors.dart';
import '../../constants/apiUrl.dart';
import '../../constants/phone_number_format.dart';
import '../../widgets/bottom_appBar.dart';
import 'customer_contact_details.dart';

class CustomerContactList extends StatefulWidget {
  List customer;
  CustomerContactList({
    Key? key,
    required this.customer,
  }) : super(key: key);

  @override
  State<CustomerContactList> createState() => _CustomerContactListState();
}

class _CustomerContactListState extends State<CustomerContactList> {
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});

  TextEditingController customerName = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController departman = TextEditingController();
  TextEditingController task = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController not = TextEditingController();

  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final UsNumberTextInputFormatter _phoneNumberFormatter =
      UsNumberTextInputFormatter();

  final formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;

  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScroll) {
          return [
            SliverAppBar(
                backgroundColor: blueColor,
                elevation: 0.0,
                toolbarHeight: 80,
                title: Center(
                    child: Text(
                  "Müşteri Yetkilileri",
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
              margin: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(290, 45),
                    primary: blueColor,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
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
                                              "Müşteri Adı",
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
                                              controller: customerName,
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Kontak Adı",
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
                                              margin:
                                                  const EdgeInsets.all(10.0),
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
                                                  value: value,
                                                  items: customerDropdownList(
                                                      "Seçiniz"),
                                                  onChanged: (int? value) {
                                                    if (value == 0) {
                                                      return;
                                                    } else {
                                                      value = value;
                                                    }
                                                  },
                                                  hint: const Text(
                                                      "Seçiniz..."))),
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
                                              "Email",
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
                                              controller: email,
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Telefon",
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
                                              controller: phone,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .allow(RegExp("[0-9]")),
                                                LengthLimitingTextInputFormatter(
                                                    10),
                                                _phoneNumberFormatter
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          child: Text(
                                            "Doğum Tarihi",
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
                                            controller: dateOfBirth,
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
                                              dateOfBirth.text =
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Departman",
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
                                              controller: departman,
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Görevi",
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
                                              controller: task,
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
                                    /*                                 Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Title",
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
                                              controller: title,
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
                                    ),*/
                                    /*            Padding(
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
                                              controller: not,
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
                                    ),*/
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
                                            formKey.currentState!.save();
                                            //showBusinessLoginDialog();
                                            addContact(
                                              Hive.box("userbox").get("UyeID"),
                                              customerName.text,
                                              email.text,
                                              phone.text,
                                              dateOfBirth.text,
                                              departman.text,
                                              task.text,
                                            );
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
                  },
                  child: Text(
                    "Yetkili Ekle",
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
                            future: getCustomerContactList(takeValue),
                            builder: (context, AsyncSnapshot snapshot) {
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
                              List contact = data["Veri"];
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: contact.length,
                                  itemBuilder: (context, index) {
                                    final _contactName = contact[index]
                                            ["KontakAdi"]
                                        .toString()
                                        .toLowerCase();
                                    final _customerName = contact[index]
                                            ["MusteriAdi"]
                                        .toString()
                                        .toLowerCase();
                                    final _email = contact[index]["Email"]
                                        .toString()
                                        .toLowerCase();
                                    final _phone = contact[index]["CepTelefonu"]
                                        .toString()
                                        .toLowerCase();

                                    if (_contactName.contains(searchValue) ||
                                        _customerName.contains(searchValue) ||
                                        _email.contains(searchValue) ||
                                        _phone.contains(searchValue)) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20, top: 20),
                                            child: Card(
                                              elevation: 8.0,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Yetkili Adı :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text(
                                                      "${_contactName}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Müşteri Adı :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text(
                                                      "${_customerName}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Email:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "${_email}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Telefon :",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15.0),
                                                    child: Text(
                                                      "${_phone}",
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
                                                                  builder: (context) =>
                                                                      CustomerContactDetails(
                                                                          contactList:
                                                                              contact[index])));
                                                        },
                                                        child: Text(
                                                          "Kontak Detayları",
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  Colors.grey),
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

  customerDropdownList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.customer;
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
              customer[i - 1]["KategoriAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }

  Future getCustomerContactList(int take) async {
    try {
      var response = await Dio().post(AppUrl.contactList, data: {
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
    } catch (e) {
      print(".......................$e");
    }
  }

  Future addContact(
    int uyeId,
    String musteriAdi,
    String email,
    String telefon,
    String dogumT,
    String departman,
    String gorev,
  ) async {
    try {
      var response = await Dio().post(AppUrl.addContact, data: {
        {
          "UyeId": uyeId,
          "KontakID": 0,
          "KontakAdi": musteriAdi,
          "Departman": departman,
          "Gorevi": gorev,
          "Email": email,
          "CepTelefonu": telefon,
          "OlusKullanici": "string",
          "AdresSatiri1": "string",
          "OlusTarihi": "string",
          "MusteriID": "",
          "DogumTarihi": "string",
          "DogumTarihiFormatli": dogumT,
          "FormDogumTarihiFormatli": "string"
        }
      }).then((value) {
        Hive.box("userbox").putAll({});
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
