import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:remainder/model/remainder_model.dart';
import 'package:remainder/screens/home_screen.dart';
import 'package:remainder/screens/login_screen.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static Future<void> register(
      BuildContext context, String email, String password, String name) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = userCredential.user?.uid ?? "";

      await users.doc(uid).set({'email': email, 'name': name});

      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Account created')));
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  static Future<User?> signIn(
      BuildContext context, String email, String pass) async {
    try {
      UserCredential userCredential =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      User? user = userCredential.user;

      if (user != null) {
        if (context.mounted) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('User doesn\'t exist')));
        }
      }
      return user;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Login fail! please check email and password')));
      }
    }
    return null;
  }

  static Future<void> addRemainder(String uid, TimeOfDay time) async {
    try {
      DateTime d = DateTime.now();
      DateTime dateTime = DateTime(d.year, d.month, time.hour, time.minute);
      Timestamp timestamp = Timestamp.fromDate(dateTime);
      RemainderModel remainderModel =
          RemainderModel(time: timestamp, onOff: false);
      if (time != TimeOfDay.now()) {
        return await fireStore
            .collection('users')
            .doc(uid)
            .collection('remainder')
            .doc()
            .set(remainderModel.toJson())
            .then((value) {
          Fluttertoast.showToast(msg: 'Remainder added');
        });
      } else {
        Fluttertoast.showToast(msg: 'Please check your selected time');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static Future<void> deleteRemainder(String uid, String id) async {
    try {
      await fireStore
          .collection('users')
          .doc(uid)
          .collection('remainder')
          .doc(id)
          .delete();
      Fluttertoast.showToast(msg: 'Successfully deleted');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static Future<void> updateRemainder(
      String uid, String id, RemainderModel model) async {
    await fireStore
        .collection('users')
        .doc(uid)
        .collection('remainder')
        .doc(id)
        .update({"onOff": model.onOff, "time": model.time}).then(
            (value) => Fluttertoast.showToast(msg: "Successfully updated!"),
            onError: (e) => Fluttertoast.showToast(msg: e.toString()));
  }
}
