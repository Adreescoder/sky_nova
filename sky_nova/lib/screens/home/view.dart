import 'package:flutter/material.dart';
import 'package:sky_nova/screens/chats/view.dart';
import 'package:sky_nova/screens/profile/view.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('sky nova'.toUpperCase()),
        bottom: TabBar(
          indicatorColor: Colors.blueAccent,
          indicatorWeight: 4.0,
          unselectedLabelColor: Colors.black54,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          mouseCursor: MouseCursor.defer,
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Chats'),
            Tab(text: 'Person'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          Text("OK"),
          ChatsPage(),
          ProfilePage(),
        ],
      ),
    );
  }
}
