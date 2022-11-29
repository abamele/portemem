import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../widgets/bottom_appBar.dart';

class CustomerContactDetails extends StatefulWidget {
  Map contactList;
  CustomerContactDetails({
    Key? key,
    required this.contactList,
  }) : super(key: key);

  @override
  State<CustomerContactDetails> createState() => _CustomerContactDetailsState();
}

class _CustomerContactDetailsState extends State<CustomerContactDetails> {
  @override
  Widget build(BuildContext context) {
    String _emailController = widget.contactList["Email"] ?? "";
    String _phoneController = widget.contactList["CepTelefonu"] ?? "";
    String _departmanController = widget.contactList["Departman"] ?? "";
    String _birthdayController = widget.contactList["DogumTarihiFormatli"] ?? "";
    String _adresController = widget.contactList["AdresSatiri1"] ?? "";
    String _contactController = widget.contactList["KontakAdi"] ?? "";

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: NestedScrollView(
        headerSliverBuilder: (context, isScroll) {
          return [
            SliverAppBar(
                backgroundColor: blueColor,
                elevation: 0.0,
                toolbarHeight: 80,
                title:Center(child: Text("Detay", style: TextStyle(color: Colors.white),))
            )
          ];
        },
        body: ListView(
          children: [
            Column(
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
                          "${_contactController}",
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
                                "E-mail",
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
                                initialValue: _emailController,
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
                                "Telefon",
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
                                initialValue: _phoneController,
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
                                initialValue: _departmanController,
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
                                initialValue: _birthdayController,
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
                                initialValue: _adresController,
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
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
