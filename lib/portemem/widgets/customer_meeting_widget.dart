import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/bottom_appBar.dart';

class CustomerMeetingWidget extends StatefulWidget {
  Map customerList;
  CustomerMeetingWidget({
    Key? key,
    required this.customerList,
  }) : super(key: key);

  @override
  State<CustomerMeetingWidget> createState() => _CustomerMeetingWidgetState();
}

class _CustomerMeetingWidgetState extends State<CustomerMeetingWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Not",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Başlangıç Tarihi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Bitiş Tarihi",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                  ),
                  child: Text(""),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 16),
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }
}
