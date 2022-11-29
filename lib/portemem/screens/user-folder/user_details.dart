import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

import '../../constants/apiUrl.dart';
import '../../constants/colors.dart';

class UserDetails extends StatefulWidget {
  Map? userList;
  UserDetails({Key? key, this.userList}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  final ValueNotifier<Map> _loginLoading =
  ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  DateTime? dateTime1;
  DateTime? dateTime2;
  String? strDate;

  @override
  Widget build(BuildContext context) {
    String _userName = widget.userList!["AdiSoyadi"];
    String _birthDay = widget.userList!["DogumTarihiFormatli"];
    String _bloodGroupe = widget.userList!["KanGrubu"];
    String _email = widget.userList!["KullaniciAdi"];
    String _password = widget.userList!["Sifresi"];
    String _address = widget.userList!["Adres"];
    String _gsm = widget.userList!["GSM"];
    String _country = widget.userList!["Ulke"];
    String _city = widget.userList!["Sehir"];
    String _county = widget.userList!["Ilce"];
    String _postalCode = widget.userList!["PostaKodu"];
    String _website = widget.userList!["WebSitesi"];
    String _nearnessName = widget.userList!["YakinAdiSoyadi"];
    String _nearnessNumber = widget.userList!["YakinTelefon"];
    bool? isActive = widget.userList!["RootAdmin"];
    String _groupValue = '';
    void checkRadio(String value) {
      setState(() {
        _groupValue = value;
      });
    }

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Kullanıcı"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              elevation: 8.0,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Column(
                children: [
                  Form(
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
                                "",
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
                                            initialValue: _userName,
                                            decoration:
                                            InputDecoration(
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
                                            initialValue: _email,
                                            decoration:
                                            InputDecoration(
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
                                            "Şifre",
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
                                            initialValue: _password,
                                            decoration:
                                            InputDecoration(
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
                                            initialValue: _birthDay,
                                            decoration:
                                            InputDecoration(
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
                                              _birthDay = DateFormat(
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
                                                  "Kan Grubu",
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
                                                margin: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 10),
                                                child: TextFormField(
                                                  initialValue: _bloodGroupe,
                                                  decoration:
                                                  InputDecoration(
                                                    helperStyle:
                                                    TextStyle(
                                                        color: Colors
                                                            .grey,
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
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
                                            initialValue: _gsm,
                                            decoration:
                                            InputDecoration(
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
                                            initialValue: _address,
                                            keyboardType:
                                            TextInputType
                                                .multiline,
                                            minLines: 4,
                                            maxLines: null,
                                            decoration:
                                            InputDecoration(
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
                                            initialValue: _country,
                                            decoration:
                                            InputDecoration(
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
                                            initialValue: _city,
                                            decoration:
                                            InputDecoration(
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
                                            initialValue: _county,
                                            decoration:
                                            InputDecoration(
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
                                            initialValue: _postalCode,
                                            decoration:
                                            InputDecoration(
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
                                              RadioListTile<bool>(
                                                title: const Text(
                                                    'Admin'),
                                                value: true,
                                                groupValue:
                                                isActive,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isActive=value;
                                                  });
                                                },
                                              ),
                                              RadioListTile<bool>(
                                                  title: Text(
                                                      'Normal'),
                                                  value: false,
                                                  groupValue:
                                                  isActive,
                                                  onChanged:
                                                      (value) {
                                                    setState(() {
                                                      isActive=value;
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
                                            initialValue: _website,
                                            decoration:
                                            InputDecoration(
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
                                      initialValue: _nearnessName,
                                      decoration: InputDecoration(
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
                                      initialValue: _nearnessNumber,
                                      decoration: InputDecoration(
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
                                    showBusinessLoginDialog();
                                    updateUser(
                                        widget.userList!["UyeID"],
                                        _userName,
                                        _email,
                                        _password,
                                        _birthDay,
                                        _gsm.toString(),
                                        _address,
                                        _country,
                                        _city,
                                        _county,
                                        _postalCode,
                                        _website);
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

                          ],
                        ),
                      )),

                  SizedBox(
                    height: 20,
                  ),
                  Text("")
                ],
              ),
            )
          ],
        ),
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

  Future updateUser(
      int id,
      String adSoyad,
      String email,
      String sifre,
      String gsm,
      String dogumT,
      String adres,
      String ulke,
      String il,
      String ilce,
      String postakodu,
      String website) async {
    try {
      var response = await Dio().post(AppUrl.updateUser, data: {
        "UyeID": id,
        "SessionUyeID": 0,
        "KullaniciAdi": email,
        "Sifresi": sifre,
        "FirmaUnvan": "string",
        "AdiSoyadi": adSoyad,
        "Onay": true,
        "OnayKodu": "string",
        "RootAdmin": true,
        "Telefon": "string",
        "GSM": gsm,
        "Adres":adres,
        "Ulke": ulke,
        "Sehir": il,
        "Ilce": ilce,
        "PostaKodu": postakodu,
        "WebSitesi": website,
        "OnayBitisTarihi": "string",
        "DogumTarihi": "string",
        "CreatedOn": "string",
        "ModifiedOn": "string",
        "IsDeleted": true,
        "CreatedBy": "string",
        "KanGrubu": "string",
        "YakinTelefon": "string",
        "YakinAdiSoyadi": "string"
      }).then((value) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Column(
                  children: [
                    Icon(Icons.check_circle, size: 60, color: Colors.green),
                    SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Kullanıcı Güncenllendi",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/user_list", (route) => false);
                      },
                      child: Text(
                        "Kapat",
                        style: TextStyle(fontSize: 17),
                      ))
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
