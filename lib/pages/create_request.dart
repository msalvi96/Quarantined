import 'package:flutter/material.dart';
import 'package:quarantined/pages/org_request.dart';
import 'package:quarantined/pages/personal_request.dart';
import 'package:quarantined/pages/general_request.dart';

class CreateRequests extends StatefulWidget {
  CreateRequests({Key key}) : super(key: key);

  @override
  _CreateRequestsState createState() => _CreateRequestsState();
}

class _CreateRequestsState extends State<CreateRequests> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Requests'),
        bottom: TabBar(
          tabs: [
            Tab(
              text: "General",
              icon: Icon(Icons.info),
            ),
            Tab(
              text: "Personal",
              icon: Icon(Icons.person)
            ),
            Tab(
              text: "Organization",
              icon: Icon(Icons.business),
            ),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          GeneralRequest(),
          PersonalRequest(),
          OrgRequest(),
        ],
        controller: _tabController,
      ),
    );
  }
}