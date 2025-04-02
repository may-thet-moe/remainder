import 'package:flutter/material.dart';
import 'package:remainder/utils/app_colors.dart';

class RoundTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final FormFieldValidator? validator;
  final ValueChanged<String>? onChange;
  final String hintText;
  final String icon;
  final Widget? rightIcon;
  final TextInputType textInputType;
  final bool isObscureText;

  const RoundTextField(
      {super.key,
      this.textEditingController,
      this.validator,
      this.onChange,
      required this.hintText,
      required this.icon,
      this.rightIcon,
      required this.textInputType,
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrayColor,
        borderRadius: BorderRadius.circular(15)
      ),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: textInputType,
        obscureText: isObscureText,
        onChanged: onChange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: hintText,
          prefixIcon: Container(
            alignment: Alignment.center,
            width: 20,
            height: 20,
            child: Image.asset(
              icon,
              height: 20,
              width: 20,
              fit: BoxFit.contain,
              color: AppColors.grayColor,
            ),
          ),
          suffixIcon: rightIcon,
          hintStyle: TextStyle(fontSize: 12, color: AppColors.grayColor)
        ),
        validator: validator,
      ),
    );
  }
}
