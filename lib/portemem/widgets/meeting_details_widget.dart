import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/bottom_appBar.dart';

class MeetingDetailsWidget extends StatefulWidget {
  Map meeting;
  MeetingDetailsWidget({
    Key? key,
    required this.meeting,
  }) : super(key: key);

  @override
  State<MeetingDetailsWidget> createState() => _MeetingDetailsWidgetState();
}

class _MeetingDetailsWidgetState extends State<MeetingDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    final _meetingNo = widget.meeting["AktiviteKodu"] ?? "";
    final _customerName = widget.meeting["MusteriAdi"] ?? "";
    final _startDate = widget.meeting["BaslangicTarihiFormatli"];
    final _endDate = widget.meeting["BitisTarihiFormatli"] ?? "";

    final contactList = widget.meeting["ToplantiYetkilileri"];

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: contactList.length,
          itemBuilder: (context, index) {
            final contactName= contactList[index]["KontakAdi"] ?? "";
            return Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    elevation: 8.0,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Toplantı No",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  initialValue: _meetingNo.toString(),
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
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
                                  "Müşteri Adı",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  initialValue: _customerName,
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
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
                                  "Toplantı Yetkilileri",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  initialValue: contactName,
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
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
                                  "Başlangıç Tarihi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  initialValue: _startDate,
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
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
                                  "Bitiş Tarihi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 17),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 10.0,
                                  right: 10,
                                ),
                                child: TextFormField(
                                  initialValue: _endDate,
                                  decoration: InputDecoration(
                                    helperStyle: TextStyle(
                                        color: Colors.grey, fontSize: 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Center(

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: blueColor,
                              minimumSize: Size(290, 50)
                            ),
                            child: Text("Kaydet"),
                            onPressed: (){},
                          )
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("")
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
