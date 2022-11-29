import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portemem/portemem/constants/colors.dart';

import '../../constants/apiUrl.dart';
import '../../constants/phone_number_format.dart';
import '../../widgets/bottom_appBar.dart';
import '../../widgets/dropdown-extrait/searchable_dropdown_extrait.dart';
import 'customer_details.dart';

class CustomerList extends StatefulWidget {
  List category;
  List contact;
  CustomerList({Key? key, required this.category, required this.contact})
      : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");

  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final ValueNotifier<int> take = ValueNotifier<int>(50);

  final UsNumberTextInputFormatter _phoneNumberFormatter =
      UsNumberTextInputFormatter();

  TextEditingController customerName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController tcNo = TextEditingController();
  TextEditingController taxNo = TextEditingController();
  TextEditingController tax = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController email = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? selectedValue;
  int value = 0;

  @override
  void initState() {
    _getCitiesList();
    super.initState();
  }
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
                  "Müşteri Listesi",
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
                                        "Müşteri Ekle",
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
                                              "Kategoriler",
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
                                            child: SearchableDropdownT.single(
                                              isExpanded: true,
                                              value: _category,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                              hint: Text('Seçiniz...'),
                                              onChanged: (String? newValue) {
                                                setState(() {
                                                  _category = newValue;
                                                  print(
                                                      ".........statatttttttt........................${newValue}");
                                                  _getCitiesList();
                                                  print(
                                                      "....stssssssss.......................${_category}");

                                                });
                                              },
                                              items: categoryList!.map((item) {
                                                return DropdownMenuItem(
                                                    value: item['KategoriID']
                                                        .toString(),
                                                    child: Row(
                                                      children: [
                                                        Text("${item['KategoriID']}:"),
                                                        SizedBox(width: 5.0,),
                                                        Text("${item['KategoriAdi']}"),
                                                      ],
                                                    ));
                                              }).toList(),
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "Adres",
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
                                              controller: address,
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
                                              "İl",
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
                                              controller: city,
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
                                              "İlçe",
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
                                              controller: county,
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
                                            formKey.currentState!.save();
                                            //showBusinessLoginDialog();
                                            addCustomer(
                                                Hive.box("userbox")
                                                    .get("UyeID"),
                                                customerName.text,
                                                _category,
                                                phone.text,
                                                address.text,
                                                city.text,
                                                county.text);
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
                    "Müşteri Ekle",
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
                              List customer = data["Veri"];
                              return ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: customer.length,
                                  itemBuilder: (context, index) {
                                    final _customerName = customer[index]
                                            ["MusteriAdi"]
                                        .toString()
                                        .toLowerCase();
                                    final _phone = customer[index]["Telefon"]
                                        .toString()
                                        .toLowerCase();
                                    final _category = customer[index]
                                            ["Kategori"]
                                        .toString()
                                        .toLowerCase();

                                    if (_customerName.contains(searchValue) ||
                                        _phone.contains(searchValue) ||
                                        _category.contains(searchValue)) {
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Kategori :",
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
                                                      "${_category}",
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
                                                          print(".................custommmmmmmmmm..................${customer[index]}");
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CustomerDetails(
                                                                            customList:
                                                                                customer[index],
                                                                            contact:
                                                                                widget.contact[index],
                                                                          )));
                                                        },
                                                        child: Text(
                                                          "Müşteri Detayları",
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

/*  categoryDropdownList(String title) {
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
  }*/

  List? categoryList;
  String? _category;

  //String cityInfoUrl = 'https://crm.mnsbilisim.com/api/musteri/kontak-listesi-getir?musteriID=${_myState}';
  Future<String?> _getCitiesList() async {
    var res = await Dio().post(
        'https://crm.portemem.com:443/api/musteri/tüm-kategorileri-getir',
        data: {});
    //var data = json.decode(response.data);
    List item = res.data;
    setState(() {
      categoryList = item;
    });

    print("........................categggggggggggggggggggggg....................${categoryList}");
  }

  categoryDropdownList(String title) {
    List<String> items = [];
    List<DropdownMenuItem<String>> dropdownItemList = [];
    List customer = widget.category;
    for (var i = 0; i < customer.length + 1; i++) {
      if (i == 0) {
        dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              title,
              style: TextStyle(color: Colors.grey),
            ),
            value: "",
          ),
        );
      } else {
        items.add(customer[i - 1]["KategoriAdi"].toString());
        /*dropdownItemList.add(
          DropdownMenuItem(
            child: Text(
              customer[i - 1]["MusteriAdi"].toString(),
              style: TextStyle(color: Colors.black),
            ),
            value: i,
          ),
        );*/
      }
    }
    items.forEach((word) {
      dropdownItemList.add(DropdownMenuItem(
        child: Text(word),
        value: word,
      ));
      /* if (wordPair.isEmpty) {
        wordPair = word + " ";

      } else {
        wordPair;
        if (items.indexWhere((item) {
          return (item == wordPair);
        }) == -1) {
          dropdownItemList.add(DropdownMenuItem(
            child: Text(wordPair),
            value: wordPair,
          ));
        }
        wordPair = "";
      }*/
    });
    return dropdownItemList;
  }

  Future getCustomerList(int take) async {
    try {
      var response = await Dio().post(AppUrl.customerList, data: {
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

  Future addCustomer(
    int? uyId,
    String musteriAdi,
    String? kategoryId,
    String telefon,
    String adres,
    String sehir,
    String ilce,
  ) async {
    try {
      var response = await Dio().post(AppUrl.addCustomer, data: {
        "UyeId": uyId,
        "MusteriID": 0,
        "KategoriId": kategoryId,
        "Telefon": telefon,
        "Adres": adres,
        "Sehir": sehir,
        "Ilce": ilce,
        "Turu": "string",
        "MusteriAdi": musteriAdi,
        "GercekKisiBool": true,
        "OlusTarihi": "string",
        "TcNo": "string",
        "VergiNo": "string",
        "VergiDairesi": "string",
        "OlusKullanici": "string"
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
