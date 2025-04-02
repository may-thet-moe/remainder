import 'package:flutter/material.dart';
import 'package:remainder/utils/api.dart';
import 'package:remainder/widges/addRemainder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(

      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        addRemainder(context, APIs.auth.currentUser!.uid);
      }, child: Icon(Icons.add),),
    );
  }
}