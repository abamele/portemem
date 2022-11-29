import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:portemem/portemem/constants/colors.dart';
import 'package:portemem/portemem/screens/task-folder/my_responsible_task_details.dart';

import '../../constants/apiUrl.dart';
import '../../widgets/bottom_appBar.dart';

class MyResponsibleTaskList extends StatefulWidget {
  const MyResponsibleTaskList({Key? key}) : super(key: key);

  @override
  State<MyResponsibleTaskList> createState() => _MyResponsibleTaskListState();
}

class _MyResponsibleTaskListState extends State<MyResponsibleTaskList> {
  final ValueNotifier<String> _searchTextNotify = ValueNotifier<String>("");

  final ValueNotifier<int> take = ValueNotifier<int>(50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: blueColor,
          elevation: 0.0,
          toolbarHeight: 80,
          title: Center(
              child: Text(
            "Sorumlu Olduğum Görevler",
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
       /*   Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(290, 45), primary: blueColor),
                onPressed: () {},
                child: Text(
                  "Görev Ekle",
                  style: TextStyle(fontSize: 17),
                )),
          ),*/
          ValueListenableBuilder(
            valueListenable: _searchTextNotify,
            builder: (BuildContext context, String searchValue, Widget? child) {
              return ValueListenableBuilder(
                  valueListenable: take,
                  builder: (BuildContext context, int takeValue, Widget? child) {
                    return FutureBuilder(
                        future: getMyTaskList(takeValue),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Bir şeyler yanlış gitti');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.data == null) {
                            return const Center(child: CircularProgressIndicator());
                          }
                          Map<String, dynamic> data = snapshot.data.data as Map<String, dynamic>;
                          List task = data["Veri"];
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: task.length,
                              itemBuilder: (context, index) {
                                final _taskNo = task[index]["GorevID"].toString().toLowerCase();
                                final _startDate =
                                    task[index]["FormGorevBaslangicFormatli"].toString().toLowerCase();
                                final _endDate =
                                    task[index]["FormGorevBitisFormatli"].toString().toLowerCase();
                                final _taskState =
                                    task[index]["GorevinDurumuText"].toString().toLowerCase();

                                List _taskResp = task[index]["GorevSorumlulari"] ?? "";

                                if(_taskNo.contains(searchValue) || _startDate.contains(searchValue) || _endDate.contains(searchValue) || _taskResp.contains(searchValue) || _taskState.contains(searchValue)){
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _taskResp.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                                      padding: const EdgeInsets.symmetric(
                                                          horizontal: 10.0),
                                                      child: new Text(
                                                        "${_taskResp[index]["AdiSoyadi"]}",
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Text(
                                                        "Görev No :",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(left: 15.0),
                                                      child: Text(
                                                        "${_taskNo}",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Text(
                                                        "Görev Sorumlusu :",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Text(
                                                        "${_taskResp[index]["AdiSoyadi"]}",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Text(
                                                        "Başlangıç Tarihi :",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(left: 15.0),
                                                      child: Text(
                                                        "${_startDate}",
                                                        style: TextStyle(fontSize: 15),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Text(
                                                        "Bitiş Tarihi :",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(left: 15.0),
                                                      child: Text(
                                                        "${_endDate}",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Text(
                                                        "Görev Durumu :",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(left: 15.0),
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
                                                              minimumSize: Size(290, 45),
                                                              primary: Colors.white),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        MyResponsibleTaskDetails(taskList: task[index],)));
                                                          },
                                                          child: Text(
                                                            "Görev Detayları",
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
                                  );
                                }
                                return Container();
                              });
                        });
                  });
            }
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  Future getMyTaskList(int take,) async {
    try {
      var response = await Dio().post(AppUrl.myTaskRespList, data: {

        "sort": [
          {
            "selector": "string",
            "desc": true
          }

        ],
        "group": {},
        "requireTotalCount": true,
        "searchOperation": "string",
        "skip": 0,
        "take": take,
        "userDatas": [
          {
            "SelectedField": "UyeID",
            "SelectedValue": "1"
          }
        ],
        "filter": [
          ""
        ],
        "filterSearchField": "string",
        "filterSearchValue": "string",
        "multiFilterSearch": {},
        "sortingFieldValue": "string",
        "sortingFieldDesc": "string",
        "multipleFilters": [
          "string"
        ]

      } );
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }
}
