import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:portemem/portemem/screens/calendar-folder/my_calendar.dart';
import 'package:portemem/portemem/screens/customer-folder/addTaskWithDropdown.dart';
import 'package:portemem/portemem/screens/customer-folder/customerListWithDropdown.dart';
import 'package:portemem/portemem/screens/customer-folder/customer_contact_list.dart';
import 'package:portemem/portemem/screens/financial-statement-folder/add_financial_statement.dart';
import 'package:portemem/portemem/screens/financial-statement-folder/financial_statement.dart';
import 'package:portemem/portemem/screens/calendar-folder/add_meeting.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'package:portemem/portemem/screens/home-page-folder/home_page.dart';
import 'package:portemem/portemem/screens/login-folder/login_page.dart';
import 'package:portemem/portemem/screens/meeting-folder/meetingListWithDropdown.dart';
import 'package:portemem/portemem/screens/menu-folder/menu_list.dart';
import 'package:portemem/portemem/screens/task-folder/my_responsible_tasklist.dart';
import 'package:portemem/portemem/screens/profile-folder/profile_page.dart';
import 'package:portemem/portemem/screens/setting-folder/setting_page.dart';
import 'package:portemem/portemem/screens/task-folder/allTask_list.dart';
import 'package:portemem/portemem/screens/task-folder/task_type_list.dart';
import 'package:portemem/portemem/screens/user-folder/user_list.dart';
import 'package:portemem/portemem/widgets/test.dart';

void main() async{
  await Hive.initFlutter("localdatabase");
  await Hive.openBox("userbox");
  // await Hive.openBox("rememberbox");

  // Hive.box("caybox").clear();
  // Hive.box("rememberbox").clear();
  // Hive.box("userbox").clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //ignore: always_specify_types
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      //ignore: always_specify_types
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        // ... other locales the app supports
      ],
      locale: const Locale('tr'),
      routes: {

        "/login":(context) =>LoginPage(),
        "/homepage":(context) =>CalendarPage(),

        "/program_list":(context) =>MenuList(),
        "/customer_list":(context) =>CustomerListWithDropdown(),
        "/meeting_list":(context) =>MeetingListWithDropdown(),
        "/task_list":(context) =>AllTaskList(),
        "/my_task_list":(context) =>MyResponsibleTaskList(),
        "/nominated_task_list":(context) =>addTaskWithDropdown(),
        "/task_type_list":(context) =>TaskTypeList(),
        "/user_list":(context) =>UserList(),
        "/financial_statement":(context) =>FinancialStatementPage(),
        "/customer_contact":(context) =>CustomerContactList(customer: [],),
        "/profile":(context) =>Profile(),
        "/setting":(context) =>SettingPage(),
        "/logout":(context) =>LoginPage(),
        "/test":(context) =>CalendarApi(),

        //Add Data
        "/add_meeting":(context) =>AddMeting(),
        "/my_calendar":(context) =>MyCalendarPage(),
        "/add_financial_statement":(context) =>AddFinancialStatement(),
      },
      initialRoute: "/login",

    );
  }
}

