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
      endDrawer: Drawer(
          child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.black],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    "https://upload.wikimedia.org/wikipedia/commons/5/5f/Alberto_conversi_profile_pic.jpg",
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Muhammad Adrees Nazir",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "m.adrees@example.com",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Profile"),
          onTap: () {
            // Add navigation to Profile screen
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {
            // Add navigation to Settings screen
          },
        ),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Logout"),
          onTap: () {
            // Add logout functionality
          },
        ),
      ])),
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
