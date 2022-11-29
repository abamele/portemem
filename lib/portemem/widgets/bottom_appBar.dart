import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portemem/portemem/screens/home-page-folder/home_page.dart';
import 'package:portemem/portemem/widgets/test.dart';

import '../constants/colors.dart';
import '../screens/customer-folder/customerListWithDropdown.dart';
import '../screens/menu-folder/menu_list.dart';
import '../screens/profile-folder/profile_page.dart';
import '../screens/task-folder/allTask_list.dart';

class BottomAppBarWidget extends StatelessWidget {
  BottomAppBarWidget({Key? key}) : super(key: key);

  final ValueNotifier<int> selectButton = ValueNotifier<int>(0);
  List text = [
    "Menu",
    "Görevler",
    "Anasayfa",
    "Müşteriler",
    "Profili",
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 20.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          selectItemWidget(1, Icons.menu, text[0]),
          selectItemWidget(2, FontAwesomeIcons.cube, text[1]),
          selectItemWidget(3, Icons.home_outlined, text[2]),
          selectItemWidget(4, Icons.group, text[3]),
          selectItemWidget(5, FontAwesomeIcons.user, text[4]),
        ],
      ),
    );
  }

  Widget selectItemWidget(
    int index,
    IconData icon,
    String txt,
  ) {
    return ValueListenableBuilder(
      valueListenable: selectButton,
      builder: (BuildContext context, int value, Widget? child) {
        return Container(
          child: Row(
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        icon,
                        color: value == index ? blueColor : Colors.grey,
                        size: 25,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        txt,
                        style: TextStyle(
                            color: value == index ? blueColor : Colors.grey),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (index == 1) {
                    selectButton.value = index;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuList()));
                  } else if (index == 2) {
                    selectButton.value = index;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllTaskList()));
                  } else if (index == 3) {
                    selectButton.value = index;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalendarPage()));
                  } else if (index == 4) {
                    selectButton.value = index;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerListWithDropdown()));
                  } else if (index == 5) {
                    selectButton.value = index;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Profile()));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
