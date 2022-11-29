import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../widgets/bottom_appBar.dart';

class TaskTypeDetails extends StatefulWidget {
  Map taskList;
  TaskTypeDetails({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  @override
  State<TaskTypeDetails> createState() => _TaskTypeDetailsState();
}

class _TaskTypeDetailsState extends State<TaskTypeDetails> {
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

    String _comment = widget.taskList["Numune"] ?? '';
    bool isActive = widget.taskList["Aktiflik"];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: blueColor,
          elevation: 0.0,
          title: Center(
              child: Text(
                "Numune List Detayları",
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
                                    left: 10, top: 20),
                                child: Text(
                                  "Görev Tipi",
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
                                    helperStyle:
                                    TextStyle(
                                        color: Colors
                                            .grey,
                                        fontSize:
                                        17),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15.0),
                                child: Text("Aktiflik",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17)),
                              ),
                              Switch(
                                  value: isActive,
                                  onChanged: (value) {
                                    setState(() {
                                      isActive = value;
                                    });
                                  })
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


}
