import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/bottom_appBar.dart';

class MeetingContactDetails extends StatefulWidget {
  Map contactList;
  MeetingContactDetails({
    Key? key,
    required this.contactList,
  }) : super(key: key);

  @override
  State<MeetingContactDetails> createState() => _MeetingContactDetailsState();
}

class _MeetingContactDetailsState extends State<MeetingContactDetails> {
  @override
  Widget build(BuildContext context) {
    String _nameSurname = widget.contactList["KontakAdi"] ?? "";
    String _email = widget.contactList["Email"] ?? "";
    String _phone = widget.contactList["CepTelefonu"] ?? "";
    String _departman = widget.contactList["Departman"] ?? "";
    String _task = widget.contactList["Gorevi"] ?? "";
    String _birthDay = widget.contactList["DogumTarihiFormatli"] ?? "";
    String _address = widget.contactList["AdresSatiri1"] ?? "";

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Card(
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
                                  "Ad/Soyad",
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
                                  initialValue: _nameSurname,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
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
                                  "E-posta",
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
                                  initialValue: _email,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
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
                                  "Cep Telefonu",
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
                                  initialValue: _phone,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
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
                                  "Departman",
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
                                  initialValue: _departman,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
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
                                  "Görevi",
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
                                  initialValue: _task,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
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
                                  "Doğum Tarihi",
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
                                  initialValue: _birthDay,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
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
                                  "Adres",
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
                                  minLines: 4,
                                  maxLines: null,
                                  initialValue: _address,
                                  decoration: InputDecoration(
                                    helperStyle:
                                    TextStyle(color: Colors.grey, fontSize: 17),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("")
                      ],
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
