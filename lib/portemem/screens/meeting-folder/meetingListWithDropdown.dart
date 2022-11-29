import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portemem/portemem/screens/meeting-folder/meetings_list.dart';

import '../../constants/apiUrl.dart';


class MeetingListWithDropdown extends StatefulWidget {
  const MeetingListWithDropdown({Key? key}) : super(key: key);

  @override
  State<MeetingListWithDropdown> createState() => _MeetingListWithDropdownState();
}

class _MeetingListWithDropdownState extends State<MeetingListWithDropdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: getCustomerList(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Bir şeyler yanlış gitti.'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            Map<String, dynamic> data1 = snapshot.data.data as Map<String, dynamic>;

            List metting = data1["Veri"];
            return FutureBuilder(
              future: getContactList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Bir şeyler yanlış gitti.'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                Map<String, dynamic> data2 =
                snapshot.data.data as Map<String, dynamic>;

                List contact = data2["Veri"];

                return MeetingList(customer: metting, contact: contact);
              },
            );
          },
        ));
  }

  Future getCustomerList() async {
    try {
      var response = await Dio().post(AppUrl.meetingList, data: {

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
        "take": 50,
        "userDatas": [

          {
            "SelectedField": "string",
            "SelectedValue": "string"
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

      });
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }

  Future getContactList() async {
    try {
      var response = await Dio().post(AppUrl.contactList, data: {

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
        "take": 50,
        "userDatas": [

          {
            "SelectedField": "string",
            "SelectedValue": "string"
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

      });
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }
}