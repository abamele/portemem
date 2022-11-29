import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portemem/portemem/constants/context_extension.dart';
import 'package:portemem/portemem/screens/task-folder/my_responsible_tasklist.dart';
import 'package:portemem/portemem/screens/setting-folder/setting_page.dart';
import 'package:portemem/portemem/screens/task-folder/allTask_list.dart';
import 'package:portemem/portemem/screens/task-folder/task_type_list.dart';
import 'package:portemem/portemem/screens/user-folder/user_list.dart';
import '../../constants/colors.dart';

import '../calendar-folder/my_calendar.dart';
import '../customer-folder/addTaskWithDropdown.dart';
import '../customer-folder/customerListWithDropdown.dart';
import '../customer-folder/customer_contact_list.dart';
import '../financial-statement-folder/financial_statement.dart';
import '../meeting-folder/meetingListWithDropdown.dart';

class MenuList extends StatefulWidget {
  const MenuList({Key? key}) : super(key: key);

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  final ValueNotifier<int> selectButton = ValueNotifier<int>(0);

  List itemMenu = [
    "Kullanıcılar",
    "Müşteriler",
    "Müşteri Yetkilileri",
    "Toplantılar",
    "Tüm Görevler",
    "Görevlerim",
    "Atadığım Görevler",
    "Takvim",
    "Görev Tipi \nListesi",
    "Mali Tablo",
    "Ayarlarım",
    "Çıkış"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: blueColor,
          elevation: 0.0,
          title: Container(
            margin: EdgeInsets.only(right: 35),
            child: Center(
              child: Text(
                "Menu",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(1,FontAwesomeIcons.user ,itemMenu[0])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(2,FontAwesomeIcons.userGroup ,itemMenu[1])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(3,FontAwesomeIcons.cube ,itemMenu[2])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(4,FontAwesomeIcons.bullseye ,itemMenu[3])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(5,Icons.star_border_outlined,itemMenu[4])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(6,FontAwesomeIcons.tasks ,itemMenu[5])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(7,Icons.clear ,itemMenu[6])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(8,Icons.check_box_outlined ,itemMenu[7])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(9,FontAwesomeIcons.peopleCarryBox ,itemMenu[8])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(10,FontAwesomeIcons.coins ,itemMenu[9])
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      selectMenuWidget(11,Icons.add ,itemMenu[10])
                    ],
                  ),
                  Row(
                    children: [
                      selectMenuWidget(12,FontAwesomeIcons.xmark ,itemMenu[11])
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Text("")
          ],
        ),
      ),
    );
  }

  Widget selectMenuWidget(int index, IconData icon, String text) {
    return ValueListenableBuilder(
      valueListenable: selectButton,
      builder: (BuildContext context, int value, Widget? child) {
        return MaterialButton(
          child: Card(
            elevation: 5.0,
            color: value==index?blueColor:Colors.white,
            margin: EdgeInsets.only(top: 30),
            child: Container(
              width: context.dynamicWidth(0.40),
              height: context.dynamicHeight(0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      size: 25,
                      color:value==index?Colors.white: blueColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(text,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: value==index?Colors.white: Color(0xff4F4F4F))),
                  ),
                ],
              ),
            ),
          ),
          onPressed: () {
            if(index==1){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserList()));
            }else if(index==2){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerListWithDropdown()));
            }else if(index==3){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerContactList(customer: [],)));
            }else if(index==4){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MeetingListWithDropdown()));
            }else if(index==5){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllTaskList()));
            }else if(index==6){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyResponsibleTaskList()));
            }else if(index==7){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addTaskWithDropdown()));
            }else if(index==8){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyCalendarPage()));
            }else if(index==9){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskTypeList()));
            }else if(index==10){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FinancialStatementPage()));
            }else if(index==11){
              selectButton.value=index;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SettingPage()));
            }else if(index==12){
              selectButton.value=index;
              Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
            }

          },
        );
      },
    );
  }
}

