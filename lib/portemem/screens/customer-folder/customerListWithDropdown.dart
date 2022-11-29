import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/apiUrl.dart';
import 'customer_list.dart';

class CustomerListWithDropdown extends StatefulWidget {
  CustomerListWithDropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerListWithDropdown> createState() =>
      _CustomerListWithDropdownState();
}

class _CustomerListWithDropdownState extends State<CustomerListWithDropdown> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f6f9),
      body: FutureBuilder(
        future: getCategoryList(),
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
          List data = snapshot.data.data;

          List category = data;
          return FutureBuilder(
            future: getContactList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                Map<String, dynamic> data = snapshot.data.data as Map<String, dynamic>;

                List contact = data["Veri"];
                return CustomerList(category: category, contact: contact,);
              });
        },
      ),
    );
  }

  Future getCategoryList() async {
    try {
      var response = await Dio().post(AppUrl.allCategory, data: {});
      print(response);
      return response;
    } catch (e) {
      print(".......................$e");
    }
  }

  Future getContactList() async {
    try {
      var response = await Dio().post(AppUrl.customerList, data: {

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
