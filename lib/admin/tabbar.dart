import 'package:elite_events/admin/randomtry.dart';
import 'package:elite_events/allExtract.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adminSlider.dart';
import 'adminbooking.dart';
import 'adminCategory.dart';
import 'menuITems.dart';

class AdminTabPage extends StatefulWidget {
  const AdminTabPage({Key? key}) : super(key: key);

  @override
  _AdminTabPageState createState() => _AdminTabPageState();
}

class _AdminTabPageState extends State<AdminTabPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;

      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choco World'),
          bottom: TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
            tabs: const [
              Tab(text: 'Order'),
              Tab(text: 'categories'),
              Tab(text: 'menuitems'),
              Tab(text: 'Slider'),
            ],
          ),
        ),drawer: Drawer(child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Admin Drawer",style: TextStyle(color: Colors.white60,fontSize: 24),)),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              signout(context);
            },
          ),
        ],
      ),),
        body: TabBarView(
          controller: _tabController,
          children: [
            AllOrdersPage(),
            CategoriesPage(),
            menuItms(),
            AdminPage(),
          ],
        ),
      ),
    );
  }
}
