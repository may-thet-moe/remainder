// To parse this JSON data, do
//
//     final remainderModel = remainderModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RemainderModel remainderModelFromJson(String str) =>
    RemainderModel.fromJson(json.decode(str));

String remainderModelToJson(RemainderModel data) => json.encode(data.toJson());

class RemainderModel {
  Timestamp? time;
  bool? onOff;

  RemainderModel({
    this.time,
    this.onOff,
  });

  factory RemainderModel.fromJson(Map<String, dynamic> json) => RemainderModel(
        time: json["time"],
        onOff: json["onOff"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "onOff": onOff,
      };
}
