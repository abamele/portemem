import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:portemem/portemem/constants/colors.dart';
import 'package:portemem/portemem/screens/task-folder/task_type_details.dart';

import '../../constants/apiUrl.dart';
import '../../widgets/bottom_appBar.dart';

class TaskTypeList extends StatefulWidget {
  const TaskTypeList({Key? key}) : super(key: key);

  @override
  State<TaskTypeList> createState() => _TaskTypeListState();
}

class _TaskTypeListState extends State<TaskTypeList> {
  final ValueNotifier<Map> _loginLoading =
      ValueNotifier<Map>({"state": 0, "message": ""});
  final ValueNotifier<int> take = ValueNotifier<int>(50);
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");
  TextEditingController cargoName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isActive = false;

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
                  "Görev Tipi Listesi",
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
                                          "Ekle",
                                          style: new TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
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
                                                left: 10,
                                                right: 10,
                                              ),
                                              child: TextFormField(
                                                controller: cargoName,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                minLines: 4,
                                                maxLines: null,
                                                decoration: InputDecoration(
                                                  hintText: 'Yazınız...',
                                                  helperStyle: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 17),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10, top: 20),
                                              child: Text("Aktiflik",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17)),
                                            ),
                                            Switch(
                                                value: isActive,
                                                onChanged: (value) {
                                                  setState(() {
                                                    isActive = value;
                                                    print(isActive);
                                                  });
                                                }),
                                            SizedBox(
                                              height: 30,
                                            ),
                                            Center(
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          minimumSize:
                                                              Size(290, 45),
                                                          primary: blueColor),
                                                  child: Text("Kaydet"),
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      formKey.currentState!
                                                          .save();
                                                      /*showBusinessLoginDialog();
                                                          addCargo(Hive.box("userbox").get("UyeID"),
                                                              cargoName.text, isActive);*/
                                                    }
                                                  }),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text("")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                            future: getTaskList(takeValue),
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
                                    final _taskType = task[index]["Numune"]
                                        .toString()
                                        .toLowerCase();
                                    final _createdDate = task[index]
                                            ["OlusturulmaTarihiFormatli"]
                                        .toString()
                                        .toLowerCase();
                                    final _persCreated = task[index]
                                            ["OlusturanKisi"]
                                        .toString()
                                        .toLowerCase();
                                    final _updateDate = task[index]
                                            ["GuncellemeTarihiFormatli"]
                                        .toString()
                                        .toLowerCase();
                                    final _persUpdated = task[index]
                                            ["GuncelleyenKisi"]
                                        .toString()
                                        .toLowerCase();

                                    if (_taskType.contains(searchValue) ||
                                        _createdDate.contains(searchValue) ||
                                        _persCreated.contains(searchValue) ||
                                        _persUpdated.contains(searchValue)) {
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
                                                      "Görev Tipi :",
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
                                                      "${_taskType}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Oluşturulma Tarihi :",
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
                                                      "${_createdDate}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Oluşturan Kişi :",
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
                                                      "${_persCreated}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Güncelleme Tarihi :",
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
                                                      "${_updateDate}",
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Text(
                                                      "Güncelleyen Kişi :",
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
                                                      "${_persUpdated}",
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
                                                                    Size(290,
                                                                        45),
                                                                primary: Colors
                                                                    .white),
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          TaskTypeDetails(
                                                                            taskList:
                                                                                task[index],
                                                                          )));
                                                        },
                                                        child: Text(
                                                          "Görev Tipi Detayları",
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

  Future getTaskList(int take) async {
    try {
      var response = await Dio().post(AppUrl.tasktypeList, data: {
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
}
