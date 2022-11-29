import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'apiUrl.dart';

Future hiveMeetingData(context) async{
  try {
    var response = await Dio().post(AppUrl.meetingList,
        data: {
          "sort": [
            {"selector": "string", "desc": true}
          ],
          "group": {},
          "requireTotalCount": true,
          "searchOperation": "string",
          "skip": 0,
          "take": 50,
          "userDatas": [
            {"SelectedField": "string", "SelectedValue": "string"}
          ],
          "filter": [""],
          "filterSearchField": "string",
          "filterSearchValue": "string",
          "multiFilterSearch": {},
          "sortingFieldValue": "string",
          "sortingFieldDesc": "string",
          "multipleFilters": ["string"]
        }).then((value) {
      Hive.box("userbox").putAll({
        "customId": value.data["Veri"]["MusteriID"],
      });
    });
    print(response);
    return response;
  } on DioError catch (e) {

  }
}