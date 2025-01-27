import 'package:flutter/material.dart';

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
    rethrow;
  }
}

Future<void> signIn({required String email, required String password}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print('User signed in successfully!');
  } catch (e) {
    print('Sign in error: $e');
    rethrow;
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

  String signInError = "";
  String signUpError = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int? defaultTabIndex =
          ModalRoute.of(context)?.settings.arguments as int?;
      _tabController = TabController(
        length: 2,
        vsync: this,
        initialIndex: defaultTabIndex ?? 0,
      );
      setState(() {});
    });
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
                  Text(
                    signInError,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        signInError = "";
                      });
                      if (_loginFormKey.currentState!.validate()) {
                        try {
                          await signIn(
                              email: _loginEmailController.text.trim(),
                              password: _loginPasswordController.text);
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        } catch (e) {
                          setState(() {
                            signInError = e.toString();
                          });
                        }
                      }
                      print("user is: ");
                      print(FirebaseAuth.instance.currentUser!);
                    },
                    child: Text('Login'),
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
                  Text(
                    signUpError,
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        signUpError = "";
                      });
                      if (_signupFormKey.currentState!.validate()) {
                        try {
                          await signUp(
                              email: _signupEmailController.text,
                              password: _signupPasswordController.text,
                              username: _signupUsernameController.text);

                          print(
                              'Signed up as: ${_signupUsernameController.text}');
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                        } catch (e) {
                          setState(() {
                            signUpError = e.toString();
                          });
                        }
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
