import 'package:flutter/material.dart';
import 'package:remainder/utils/api.dart';

deleteRemainder(BuildContext context, String uid, String id){
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      title: Text('Delete Remainder'),
      content: Text('Are your sure, your want to delete this alarm'),
      actions: [
        TextButton(onPressed: (){
          APIs.deleteRemainder(uid, id);
          Navigator.pop(context);
        }, child: Text('Confirm')),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel'))
      ],
    );
  });
}