import 'package:flutter/material.dart';


import '../../constants/colors.dart';
import '../../widgets/meeting_contact_widget.dart';
import '../../widgets/meeting_details_widget.dart';


class MeetingDetails extends StatefulWidget {
  Map? meeting;
  Map contact;
  MeetingDetails({Key? key, required this.meeting, required this.contact}) : super(key: key);

  @override
  State<MeetingDetails> createState() => _MeetingDetailsState();
}

class _MeetingDetailsState extends State<MeetingDetails> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: blueColor,
          elevation: 0.0,
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: 30),
            color: blueColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Center(
                        child: Text(
                          "Toplantı Detayları",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ))),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Görüşme',),
              Tab(text: 'Yetkili',),
            ],
            isScrollable: true,
            labelStyle: TextStyle(fontSize: 20),
            physics: NeverScrollableScrollPhysics(),
            indicatorColor: Colors.white,
            indicatorWeight: 6.0,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            MeetingDetailsWidget(meeting: widget.meeting as dynamic,),
            MeetingContactDetails(contactList: widget.contact==null?"":widget.contact as dynamic,),
          ],
        ),
      ),
    );
  }

}


