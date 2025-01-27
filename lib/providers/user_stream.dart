import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Stream<Map<String, dynamic>?> userStream() async* {
  await for (final user in FirebaseAuth.instance.authStateChanges()) {
    if (user == null) {
      yield null;
    } else {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      yield {
        'uid': user.uid,
        'email': user.email,
        'username': userDoc.data()?['username'],
      };
    }
  }
}
