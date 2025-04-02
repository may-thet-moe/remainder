import 'package:flutter/material.dart';
import 'package:remainder/screens/login_screen.dart';
import 'package:remainder/utils/api.dart';
import 'package:remainder/utils/app_colors.dart';
import 'package:remainder/widges/round_gradient_button.dart';
import 'package:remainder/widges/round_text_field.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isAgree = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                Text(
                  "Create An Account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Warmly welcome 🤝',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                RoundTextField(
                  hintText: 'Name',
                  icon: 'images/user.png',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _nameController,
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'Please Enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RoundTextField(
                  hintText: 'email',
                  icon: 'images/email.png',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                  validator: (value) {
                    if (value == null || value.toString().isEmpty) {
                      return 'email is required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RoundTextField(
                  hintText: 'password',
                  icon: 'images/padlock.png',
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  validator: (value) {
                    if (value == null || value.toString().length < 6) {
                      return 'password length must have at least 6 characters';
                    }
                    return null;
                  },
                  isObscureText: _isObscure,
                  rightIcon: Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Image.asset(
                          _isObscure
                              ? 'images/eye.png'
                              : 'images/visibility.png',
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                        value: _isAgree,
                        activeColor: AppColors.primaryColor1,
                        onChanged: (value) {
                          setState(() {
                            _isAgree = !_isAgree;
                          });
                        }),
                    Text('I accepted all terms & conditions')
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                RoundGradientButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate() && _isAgree){
                      APIs.register(context, _emailController.text, _passwordController.text, _nameController.text);
                    }
                  },
                  title: 'Create Account',
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 1,
                      width: double.maxFinite,
                      color: AppColors.grayColor.withValues(alpha: 0.5),
                    )),
                    Text(
                      ' or ',
                      style: TextStyle(
                          color: AppColors.grayColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w400),
                    ),
                    Expanded(
                        child: Container(
                      height: 1,
                      width: double.maxFinite,
                      color: AppColors.grayColor.withValues(alpha: 0.5),
                    ))
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primaryColor1,
                            )),
                        child: Image.asset(
                          'images/google.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.primaryColor1,
                            )),
                        child: Image.asset(
                          'images/facebook.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            children: [
                          TextSpan(text: 'Already have an account?'),
                          TextSpan(
                              text: ' Login ',
                              style: TextStyle(color: Colors.blue))
                        ])))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
