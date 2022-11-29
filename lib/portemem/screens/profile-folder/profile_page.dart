import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../constants/colors.dart';
import '../../widgets/bottom_appBar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: blueColor,
        elevation: 0.0,
        toolbarHeight: 80,
        title: Container(
          margin: EdgeInsets.only(right: 35),
          child: Center(
            child: Text("Profilim"),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/images.png"),
                ),
              ],
            ),
          ),
          ListTile(
            title: Center(child: Text("")),
            subtitle: Center(child: Text("")),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ad",
                    style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        ),
                    child: TextFormField(
                      initialValue: Hive.box("userbox").get("AdiSoyadi").toString(),
                      decoration: InputDecoration(
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Soyad",
                    style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      initialValue: Hive.box("userbox").get("AdiSoyadi").toString(),
                      decoration: InputDecoration(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "E-Posta",
                  style: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    initialValue: Hive.box("userbox").get("KullaniciAdi").toString(),
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Telefon Numarası",
                  style: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    initialValue: Hive.box("userbox").get("GSM").toString(),
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kullanıcı Adı",
                    style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      initialValue: Hive.box("userbox").get("AdiSoyadi").toString(),
                      decoration:
                          InputDecoration(),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Doğum Tarihi",
                    style: TextStyle(
                        color: Color(0xff4F4F4F),
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    width: 160,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      initialValue: Hive.box("userbox").get("DogumTarihi").toString(),
                      decoration:
                          InputDecoration(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Adres",
                  style: TextStyle(
                      color: Color(0xff4F4F4F),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    initialValue: Hive.box("userbox").get("Adres").toString(),
                    minLines: 4,
                    maxLines: null,
                    decoration: InputDecoration(),
                  ),
                ),
              ],
            ),
          ),
          /*SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.only(left: 35, right: 35),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(290, 45),
                  primary: blueColor
                ),
                onPressed: () {}, child: Text("Kaydet", style: TextStyle(fontSize: 17),)),
          ),
          SizedBox(height: 30,),
          Text("")*/
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
