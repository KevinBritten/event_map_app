import 'package:flutter/material.dart';

class LoggedOutMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            leading: Icon(Icons.login),
            title: Text('Login'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login_signup');
            },
          ),
          ListTile(
            leading: Icon(Icons.app_registration),
            title: Text('Sign Up'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/login_signup', arguments: 1);
            },
          ),
        ],
      ),
    );
  }
}
