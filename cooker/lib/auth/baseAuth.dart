import 'dart:async';
import 'dart:convert';
import 'package:cooker/classes/user.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();
  Future<User> logInDatabase(String email, String password);

  Future<User> registerToDatabase(
    String firstname,
    String lastname,
    String username,
    String password,
    String address,
    String phone,
    String email,
  );

  Future<String> getUid();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 User currentUser;

  Future<User> registerToDatabase(
    String firstname,
    String lastname,
    String username,
    String password,
    String address,
    String phone,
    String email,
  ) async {
    final http.Response response = await http.post(
      'http://localhost:3030/register',
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstname': firstname,
        'lastname': lastname,
        'username': username,
        'password': password,
        'address': address,
        'phone': phone,
        'email': email
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      currentUser = User.fromJson(json.decode(response.body));
      return currentUser;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response.body);
    }
  }

  Future<User> logInDatabase(String email, String password) async {
    final http.Response response = await http.post(
      'http://localhost:3030/login',
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstname': 'login',
        'lastname': 'from',
        'username': 'app',
        'password': password,
        'address': 'this',
        'phone': 'no phone',
        'email': email
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      currentUser = User.fromJson(json.decode(response.body));
      return currentUser;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception(response.body);
    }
  }

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<User> getCurrentUser() async {
     return currentUser;
  }

  Future<String> getUid() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    String uid = user.uid;
    return uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
