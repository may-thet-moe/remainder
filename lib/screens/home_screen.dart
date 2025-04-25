import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:remainder/service/notification_service.dart';
import 'package:remainder/utils/api.dart';
import 'package:remainder/widges/addRemainder.dart';
import 'package:remainder/widges/deleteRemainder.dart';
import 'package:remainder/widges/switcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAlarmOn = true;
  @override
  void initState() {
    super.initState();
    NotificationService.localNotificationInitialization(
        context, APIs.currentUser!.uid);
  }

  void listenNotification() {
    NotificationService.behaviorSubjectForNotification.listen((value) {});
  }

  void onClickedNotification(String? payload) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: APIs.getAllRemainder(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                      const Color.fromARGB(255, 49, 141, 153)),
                ),
              );
            }
            if (snapshots.data?.docs ==null || snapshots.data?.docs.isEmpty == true) {
              return Center(
                child: Text('No information'),
              );
            } else {
              final data = snapshots.data;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: data?.docs.length,
                  itemBuilder: (context, index) {
                    
                    Timestamp t = data?.docs[index].get('time');
                    DateTime date = DateTime.fromMicrosecondsSinceEpoch(
                        t.microsecondsSinceEpoch);
                    String formattedTime = DateFormat.jm().format(date);
                    isAlarmOn = data!.docs[index].get('onOff');
                    if (isAlarmOn) {
                      NotificationService.showNotification(
                          storedDatetime: date,
                          id: 0,
                          title: 'It is the Time',
                          body: 'Don\'t forget to drink water');
                    }
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Card(
                        child: ListTile(
                          title: Text(
                            formattedTime,
                            style: TextStyle(fontSize: 30),
                          ),
                          subtitle: Text("Everyday"),
                          trailing: SizedBox(
                            width: 110,
                            child: Row(
                              children: [
                                Switcher(
                                    uid: APIs.currentUser!.uid,
                                    id: data.docs[index].id,
                                    time: data.docs[index].get('time'),
                                    onOff: isAlarmOn),
                                IconButton(
                                    onPressed: () {
                                      deleteRemainder(
                                          context,
                                          APIs.currentUser!.uid,
                                          data.docs[index].id);
                                    },
                                    icon: FaIcon(FontAwesomeIcons.circleXmark))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addRemainder(context, APIs.currentUser!.uid);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Icon(Icons.add),
      ),
    );
  }
}
