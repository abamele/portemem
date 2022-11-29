import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../widgets/customer_contact_details_widget.dart';
import '../../widgets/customer_details_widget.dart';
import '../../widgets/customer_meeting_widget.dart';


class CustomerDetails extends StatefulWidget {
  Map customList;
  Map contact;
  CustomerDetails({Key? key, required this.customList, required this.contact}) : super(key: key);

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: blueColor,
          elevation: 0.0,
          toolbarHeight: 80, // Set this height
          flexibleSpace: Container(
            margin: EdgeInsets.only(top: 30),
            color: blueColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Center(
                        child: Text(
                          "Müşteri Detayları",
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
              Tab(text: 'Detay',),
              Tab(text: 'Yetkiler',),
              Tab(text: 'Görüşmeler',),
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
            CustomerDetailsWidget(customList: widget.customList as dynamic,),
            CustomerContactWidget(contactList: widget.contact as dynamic),
            CustomerMeetingWidget(customerList:widget.customList )
          ],
        ),
      ),
    );
  }

  userTypeTitle(int userType) {
    if (userType == 1) {
      return const Text("Müşteri Detayları");
    } else if (userType == 2) {
      return const Text("Müşteri Yetkilileri");
    } else if (userType == 3) {
      return const Text("Müşteri Detayları");
    }
  }
}


