import 'package:flutter/material.dart';
import 'package:sky_nova/screens/chats/view.dart'; // Import your Chat screen
import 'package:sky_nova/screens/profile/view.dart'; // Import your Profile screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Sky Nova'.toUpperCase()),
          bottom: TabBar(
            indicatorColor: Colors.blueAccent,
            indicatorWeight: 4.0,
            unselectedLabelColor: Colors.white70, // Improved contrast
            labelColor: Colors.white,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Chats'),
              Tab(text: 'Profile'),
            ],
          ),
        ),
        endDrawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple, Colors.black],
                  ),
                ),
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
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profile"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  // Add your logout logic here
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
                child: Text(
                    "Home Screen Content")), // Replace with your Home content
            ChatsPage(),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
