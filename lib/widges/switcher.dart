import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remainder/model/remainder_model.dart';
import 'package:remainder/utils/api.dart';

class Switcher extends StatefulWidget {
  final String uid;
  final String id;
  final Timestamp time;
  final bool onOff;

  const Switcher({super.key, required this.uid, required this.id, required this.time, required this.onOff});

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  late bool _isSwitchOn;
  @override
  void initState() {
    _isSwitchOn = widget.onOff;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isSwitchOn, onChanged: (value){
        setState(() {
          _isSwitchOn = value;
        });
        APIs.updateRemainder(widget.uid, widget.id, RemainderModel(time: widget.time, onOff: _isSwitchOn));
      });
  }
}