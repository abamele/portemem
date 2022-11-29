import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portemem/portemem/constants/colors.dart';
import '../../widgets/bottom_appBar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: blueColor,
          toolbarHeight: 80,
          elevation: 0.0,
          title: Center(
              child: Text(
            "Şirket Ayarları",
            style: TextStyle(color: Colors.white),
          ))),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: Card(
              elevation: 8.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    color: blueColor,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Text(
                      "",
                      style: new TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Firma Unvan ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("FirmaUnvan")==null?"":Hive.box("userbox").get("FirmaUnvan")}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Müşteri Adı ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("AdiSoyadi")==null?"":Hive.box("userbox").get("AdiSoyadi")}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Adres ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("Adres")==null?"":Hive.box("userbox").get("Adres")}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Ülke ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("Ulke")==null?"":Hive.box("userbox").get("Ulke") }",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Şehir ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("Sehir")==null?"":Hive.box("userbox").get("Sehir")}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "İlçe ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("Ilce")==null?"":Hive.box("userbox").get("Ilce")}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Posta Kodu ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("PostaKodu")==null?"":Hive.box("userbox").get("PostaKodu")}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "E-Posta Adresi ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("KullaniciAdi")==null?"":Hive.box("userbox").get("KullaniciAdi")}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Telefon ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("GSM")==null?"":Hive.box("userbox").get("GSM")}",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Web Sitesi ",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "${Hive.box("userbox").get("WebSitesi")==null?"":Hive.box("userbox").get("WebSitesi")}",
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text("")
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
