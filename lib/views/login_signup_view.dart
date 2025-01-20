import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> signUp({
  required String email,
  required String password,
  required String username,
}) async {
  try {
    print("making user");
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print("user made");
    User? user = userCredential.user;
    if (user == null) throw Exception('User is null');
    print("printing user");
    print(user);
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      'username': username,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    print('User created with UID: ${user.uid} and username: $username');
  } on Exception catch (e) {
    print('Error creating user: $e');
  }
}

Future<void> signIn({required String email, required String password}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print('User signed in successfully!');
  } catch (e) {
    print('Sign in error: $e');
  }
}

Future<void> signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    print('User signed out successfully!');
  } catch (e) {
    print('Error signing out: $e');
  }
}

Future<void> setUserData(BuildContext context) async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser == null) {
    context.read<UserProvider>().clearUser();
  } else {
    try {
      String uid = currentUser.uid;
      DocumentSnapshot<Map<String, dynamic>> userDataSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      Map<String, dynamic>? userData = userDataSnapshot.data();

      if (userData == null) {
        throw Exception("User data not found in Firestore.");
      }

      context.read<UserProvider>().setUser(userData);
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  final TextEditingController _signupUsernameController =
      TextEditingController();
  final TextEditingController _signupPasswordController =
      TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupUsernameController.dispose();
    _signupPasswordController.dispose();
    _signupEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login/Signup'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Login'),
            Tab(text: 'Sign Up'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Login Tab
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _loginEmailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _loginPasswordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        await signIn(
                            email: _loginEmailController.text.trim(),
                            password: _loginPasswordController.text);
                        await setUserData(context);
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                      print("user is: ");
                      print(FirebaseAuth.instance.currentUser!);
                    },
                    child: Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await signOut();
                      await setUserData(context);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      print("user is: ");
                      print(FirebaseAuth.instance.currentUser);
                    },
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _signupFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _signupUsernameController,
                    decoration: InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _signupEmailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _signupPasswordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      if (_signupFormKey.currentState!.validate()) {
                        await signUp(
                            email: _signupEmailController.text,
                            password: _signupPasswordController.text,
                            username: _signupUsernameController.text);

                        print(
                            'Signed up as: ${_signupUsernameController.text}');
                        await setUserData(context);
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
