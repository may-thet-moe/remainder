import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remainder/utils/api.dart';
import 'package:remainder/utils/app_colors.dart';

addRemainder(BuildContext context, String uid) {
  TimeOfDay _selectedTime = TimeOfDay.now();

  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Text('Add Remainder'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Select a Time for Remainder"),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        final TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: _selectedTime,
                        );

                        if (pickedTime != null && pickedTime != _selectedTime) {
                          setState(() {
                            _selectedTime = pickedTime;
                          });
                        }
                        if(context.mounted){
                          Navigator.canPop(context);
                        }
                      },
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.clock,
                            color: AppColors.primaryColor1,
                            size: 38,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            _selectedTime.format(context).toString(),
                            style: TextStyle(
                                color: AppColors.primaryColor1, fontSize: 24),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      APIs.addRemainder(uid, _selectedTime);
                      Navigator.of(context).pop();
                    },
                    child: Text("Add"))
              ],
            );
          },
        );
      });
}
