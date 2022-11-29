import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/apiUrl.dart';
import '../constants/colors.dart';
import '../constants/phone_number_format.dart';
import '../widgets/bottom_appBar.dart';

class CustomerDetailsWidget extends StatefulWidget {
  Map customList;
  CustomerDetailsWidget({Key? key, required this.customList}) : super(key: key);

  @override
  State<CustomerDetailsWidget> createState() => _CustomerDetailsWidgetState();
}

class _CustomerDetailsWidgetState extends State<CustomerDetailsWidget> {
  TextEditingController textController = TextEditingController();
  final ValueNotifier<int> selectButton = ValueNotifier<int>(0);
  final ValueNotifier<int> itemList = ValueNotifier<int>(10);
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final formKey = GlobalKey<FormState>();

  final UsNumberTextInputFormatter _phoneNumberFormatter =
      UsNumberTextInputFormatter();

  String _groupValue = '';
  void checkRadio(String value) {
    setState(() {
      _groupValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    String _customerName = widget.customList["MusteriAdi"] ?? "";
    String _categoryName = widget.customList["Kategori"] ?? "";
    String _phone = widget.customList["Telefon"] ?? "";
    String _city = widget.customList["Sehir"] ?? "";
    String _county = widget.customList["Ilce"] ?? "";
    String _adres = widget.customList["Adres"] ?? "";
    String _taxNo = widget.customList["VergiNo"] ?? "";
    String _taxOffice = widget.customList["VergiDairesi"] ?? "";
    bool? isActive = widget.customList["GercekKisiBool"];
    List contactList = widget.customList["KontakListe"] ?? "";

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Card(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          color: blueColor,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15),
                                      child: Text(
                                        "Müşteri Adı",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: TextFormField(
                                        initialValue: _customerName,
                                        decoration: InputDecoration(
                                          helperStyle: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15),
                                      child: Text(
                                        "Yetkililer",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: TextFormField(
                                        readOnly: true,
                                        decoration: InputDecoration(
                                          helperStyle: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15),
                                      child: Text(
                                        "Kategoriler",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: TextFormField(
                                        initialValue: _categoryName,
                                        decoration: InputDecoration(
                                          helperStyle: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15),
                                      child: Text(
                                        "Telefon Numarası",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: TextFormField(
                                        initialValue: _phone,
                                        decoration: InputDecoration(
                                          helperStyle: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                        keyboardType: TextInputType.number,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15),
                                      child: Text(
                                        "İl",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: TextFormField(
                                        initialValue: _city,
                                        decoration: InputDecoration(
                                          helperStyle: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15),
                                      child: Text(
                                        "İlçe",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: TextFormField(
                                        initialValue: _county,
                                        decoration: InputDecoration(
                                          helperStyle: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15),
                                      child: Text(
                                        "Adres",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: TextFormField(
                                        initialValue: _adres,
                                        keyboardType: TextInputType.multiline,
                                        minLines: 4,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          helperStyle: TextStyle(
                                              color: Colors.grey, fontSize: 17),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 15),
                                      child: Text(
                                        "Türü",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 10, right: 10, top: 10),
                                      child: Column(
                                        children: <Widget>[
                                          RadioListTile<bool>(
                                            title: const Text('Gerçek'),
                                            value: true,
                                            groupValue: isActive,
                                            onChanged: (value) {
                                              setState(() {
                                                isActive = value;
                                              });
                                            },
                                          ),
                                          RadioListTile<bool>(
                                              title: Text('Tüzel'),
                                              value: false,
                                              groupValue: isActive,
                                              onChanged: (value) {
                                                setState(() {
                                                  isActive = value;
                                                });
                                              }),
                                        ],
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Tüzel",
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
                                  initialValue: _taxNo.toString()==null?"":_taxNo.toString(),
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  initialValue: _taxOffice.toString()==null?"":_taxOffice.toString(),
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.black, fontSize: 17),
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
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(290, 45), primary: blueColor),
                            child: Text("Kaydet"),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                updateCustomer(
                                  Hive.box("userbox").get("UyeID"),
                                  Hive.box("userbox").get("MusteriID"),
                                  _customerName,
                                  _phone.toString(),
                                  _adres,
                                  _city,
                                  _county,
                                  Hive.box("userbox").get("KontakListeIds"),
                                );
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Lütfen zorunlu alanları giriniz."),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Kapat"))
                                        ],
                                      );
                                    });
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("")
                      ],
                    ),
                  )),
            ),

      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

/*  categoryDropdownList() {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.customers;
    for (var i = 0; i < customer.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              "Kategori Seçiniz...",
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
  }*/

/*  contactDropdownList() {
    List<DropdownMenuItem<int>> dropdownItemList = [];
    List customer = widget.customers;
    for (var i = 0; i < customer.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              "Yetkili Seçiniz...",
              style: TextStyle(color: Colors.black),
            ),
            value: 0,
          ),
        );
      } else {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              customer[i - 1]["KontakAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );
      }
    }
    return dropdownItemList;
  }*/

  Future updateCustomer(int id, int? uyeId, String musteriAdi, String telefon,
      String adres, String il, String ilce, int kontakId) async {
    try {
      var response = await Dio().post(AppUrl.updateCustomer, data: {
        "UyeId": uyeId,
        "MusteriID": id,
        "MusteriAdi": musteriAdi,
        "Sehir": il,
        "Telefon": telefon,
        "KontakListe": [
          {
            "KontakID": 0,
            "KontakAdi": "string",
            "MusteriAdi": "string",
            "Departman": "string",
            "Gorevi": "string",
            "Email": "string",
            "CepTelefonu": "string",
            "IsTelefonu": "string",
            "OlusKullanici": "string",
            "AdresSatiri1": "string",
            "Ulke": "string",
            "Sehir": "string",
            "OlusTarihi": "string",
            "Ilce": "string",
            "MusteriID": "string",
            "Notlar": "string",
            "Telefon": "string",
            "DogumTarihi": "string",
            "Hobileri": "string",
            "Title": "string",
            "DogumTarihiFormatli": "string",
            "FormDogumTarihiFormatli": "string"
          }
        ],
        "KontakListeID": "string",
        "GercekKisiBool": true,
        "OlusTarihi": "string",
        "Adres": adres,
        "Ilce": ilce,
        "TcNo": "string",
        "VergiNo": "string",
        "VergiDairesi": "string",
        "Turu": "string",
        "OlusKullanici": "string",
        "KategoriId": "string",
        "KontakListeIds": [kontakId],
        "GercekKisiMi": true,
        "Kategori": "string"
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
                      "Müşteri Güncenllendi",
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context,
                            "/customer_list", (Route<dynamic> route) => false);
                      },
                      child: Text("Kapat"))
                ],
              );
            });
      });
      print("..................................$response");
      return response;
    } on DioError catch (e) {
      print("..............................................${e}");
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
