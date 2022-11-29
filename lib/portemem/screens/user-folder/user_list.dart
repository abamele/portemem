import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:portemem/portemem/constants/colors.dart';
import 'package:portemem/portemem/screens/user-folder/user_details.dart';
import '../../constants/apiUrl.dart';
import '../../constants/phone_number_format.dart';
import '../../widgets/bottom_appBar.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  TextEditingController nameSurname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController website = TextEditingController();
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final UsNumberTextInputFormatter _phoneNumberFormatter =
      UsNumberTextInputFormatter();
  final formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;

  String _groupValue = '';
  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  int value = 0;
  List bloodGroup = [
    "O Rh(+)",
    "O Rh(-)",
    "A Rh(+)",
    "A Rh(-)",
    "B Rh(+)",
    "B Rh(-)",
    "AB Rh(+)",
    "AB Rh(-)"
  ];

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
                  "Kullanıcı Listesi",
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
                                            "Kullanıcı Ekle",
                                            style: new TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Ad Soyad",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: nameSurname,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Yazınız...",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "E-mail",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: email,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Yazınız...",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Password",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: password,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Yazınız...",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Doğum Tarihi",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: dateOfBirth,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Yazınız...",
                                                          suffixIcon: Icon(
                                                              Icons.date_range),
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                        ),
                                                        onTap: () async {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                                  new FocusNode());
                                                          await _openDatePicker1(
                                                              context);
                                                          dateOfBirth
                                                              .text = DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(
                                                                  dateTime1!);
                                                        },
                                                        onSaved: (val) {
                                                          strDate = val;
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child: Text(
                                                              "Kategoriler",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 17),
                                                            ),
                                                          ),
                                                          Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                horizontal: 12,
                                                              ),
                                                              margin:
                                                                  const EdgeInsets.all(
                                                                      10.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                      borderRadius:
                                                                          (BorderRadius.circular(
                                                                              12))),
                                                              child:
                                                                  DropdownButton(
                                                                      isExpanded:
                                                                          true,
                                                                      value:
                                                                          value,
                                                                      items: bloodGroupList(
                                                                          "Seçiniz"),
                                                                      onChanged:
                                                                          (int?
                                                                              value) {
                                                                        if (value ==
                                                                            0) {
                                                                          return;
                                                                        } else {
                                                                          value =
                                                                              value;
                                                                        }
                                                                      },
                                                                      hint: const Text(
                                                                          "Seçiniz..."))),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Telefon Numarası",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: phone,
                                                        inputFormatters: [
                                                          FilteringTextInputFormatter
                                                              .allow(RegExp(
                                                                  "[0-9]")),
                                                          LengthLimitingTextInputFormatter(
                                                              10),
                                                          _phoneNumberFormatter
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "(5xx) xxx-xxxx ",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                        ),
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Adres",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: adress,
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
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Ülke",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: country,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Yazınız...",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Şehir",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: city,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Yazınız...",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "İlçe",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: district,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Yazınız...",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Posta Kodu",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        controller: postalCode,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Yazınız...",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Kullanıcı Tipi",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: Column(
                                                        children: <Widget>[
                                                          RadioListTile(
                                                            title: const Text(
                                                                'Admin'),
                                                            value: "Admin",
                                                            groupValue:
                                                                _groupValue,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                checkRadio(value
                                                                    as String);
                                                              });
                                                            },
                                                          ),
                                                          RadioListTile(
                                                              title: Text(
                                                                  'Normal'),
                                                              value: 'Normal',
                                                              groupValue:
                                                                  _groupValue,
                                                              onChanged:
                                                                  (value) {
                                                                setState(() {
                                                                  checkRadio(value
                                                                      as String);
                                                                });
                                                              }),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              top: 15),
                                                      child: Text(
                                                        "Web Sitesi",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                          top: 10),
                                                      child: TextFormField(
                                                        //controller: website,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              "Webdsite Giriniz...",
                                                          helperStyle:
                                                              TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 17),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  "Yakını Bilgileri",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                ),
                                                child: TextFormField(
                                                  //controller: _userName,
                                                  decoration: InputDecoration(
                                                    hintText: "Ad Soyad",
                                                    helperStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                  left: 10.0,
                                                  right: 10,
                                                ),
                                                child: TextFormField(
                                                  //controller: _userName,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(RegExp("[0-9]")),
                                                    LengthLimitingTextInputFormatter(
                                                        10),
                                                    _phoneNumberFormatter
                                                  ],
                                                  decoration: InputDecoration(
                                                    hintText: "(5xx) xxx-xxxx",
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
                                          height: 30,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                minimumSize: Size(290, 45),
                                                primary: blueColor),
                                            child: Text("Kaydet"),
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                formKey.currentState!.save();
                                                addUser(
                                                    Hive.box("userbox")
                                                        .get("UyeID"),
                                                    nameSurname.text,
                                                    email.text,
                                                    password.text,
                                                    dateOfBirth.text,
                                                    phone.text,
                                                    adress.text,
                                                    country.text,
                                                    city.text,
                                                    district.text,
                                                    postalCode.text,
                                                    website.text);
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
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text("")
                                      ],
                                    ),
                                  )),
                            );
                          });
                        });
                  },
                  child: Text(
                    "Kullanıcı Ekle",
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
                            future: getCustomerList(takeValue),
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
                              List user = data["Veri"];
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: user.length,
                                  itemBuilder: (context, index) {
                                    final _nameSurname = user[index]
                                            ["AdiSoyadi"]
                                        .toString()
                                        .toLowerCase();
                                    final _email = user[index]["KullaniciAdi"]
                                        .toString()
                                        .toLowerCase();
                                    final _birthDay = user[index]
                                            ["DogumTarihiFormatli"]
                                        .toString()
                                        .toLowerCase();

                                    if (_nameSurname.contains(searchValue) ||
                                        _email.contains(searchValue) ||
                                        _birthDay.contains(searchValue)) {
                                      return Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(20),
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
                                                      "Kullanıcı Adı :",
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
                                                      "${_nameSurname}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Email :",
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
                                                      "${_email}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Doğum Tarihi :",
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
                                                      "${_birthDay}",
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
                                                                      UserDetails(
                                                                        userList:
                                                                            user[index],
                                                                      ))).then(
                                                              (value) =>
                                                                  _reload(
                                                                      value));
                                                        },
                                                        child: Text(
                                                          "Kullanıcı Detayları",
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

  Future<void> _reload(var value) async {
    setState(() {});
  }

  bloodGroupList(String title) {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    for (var i = 0; i < bloodGroup.length + 1; i++) {
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
              bloodGroup[i - 1].toString(),
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

  Future getCustomerList(int take) async {
    try {
      var response = await Dio().post(AppUrl.userList, data: {
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

  Future addUser(
    int? id,
    String adSoyad,
    String eposta,
    String sifre,
    String dogumTarihi,
    String telefon,
    String adres,
    String ulke,
    String sehir,
    String ilce,
    String postaKodu,
    String website,
  ) async {
    // showBusinessLoginDialog();
    try {
      var response = await Dio().post(AppUrl.addUser, data: {
        "UyeID": 0,
        "SessionUyeID": id,
        "KullaniciAdi": eposta,
        "Sifresi": sifre,
        "FirmaUnvan": "",
        "AdiSoyadi": adSoyad,
        "Onay": true,
        "OnayKodu": "00000000-0000-0000-0000-000000000000",
        "RootAdmin": true,
        "Telefon": telefon,
        "GSM": "",
        "Adres": adres,
        "Ulke": ulke,
        "Sehir": sehir,
        "Ilce": ilce,
        "PostaKodu": postaKodu,
        "WebSitesi": website,
        "OnayBitisTarihi": "2022-04-23T15:32:23.641Z",
        "DogumTarihi": "2022-04-23T15:32:23.641Z",
        "DogumTarihiFormatli": "string",
        "CreatedOn": "2022-04-23T15:32:23.641Z",
        "ModifiedOn": "2022-04-23T15:32:23.641Z",
        "IsDeleted": true,
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "kullanıcı kaydedildi",
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/user_list", (route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
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
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/homepage", (Route<dynamic> route) => false);
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
