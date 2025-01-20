import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoggedInMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? user = context.watch<UserProvider>().user;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Welcome, ' + user!['username']),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login_signup');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              context.read<UserProvider>().clearUser();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
