import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generalshops/widgets/textfield_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'code_auth_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String firstName, lastName, email, password, phoneNumber, countryCode = '- -';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16),
            child: ResponsiveBuilder(
              builder: (context, sizingInfo) => Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'First Name',
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'First Name cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            firstName = value;
                          });
                        },
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'Last Name',
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Last Name cannot be empty';
                          }
                          return null;
                        },
                        onChanged: (String value) {
                          setState(() {
                            lastName = value;
                          });
                        },
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'Email',
                        onChanged: (String value) {
                          setState(() {
                            email = value;
                          });
                        },
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                        type: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        hint: 'Password',
                        isPassword: true,
                        onChanged: (String value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        isPassword: true,
                        hint: 'Confirm Password',
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'The password cannot be empty';
                          } else if (value != password) {
                            return 'The password is not matching';
                          }
                          return null;
                        },
                        type: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        onChanged: (newValue) {
                          setState(() {
                            phoneNumber = countryCode + newValue;
                          });
                        },
                        prefixIcon: TextButton(
                          child: Text(
                            countryCode,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (country) {
                                  setState(() {
                                    countryCode = '+' + country.phoneCode;
                                  });
                                });
                          },
                        ),
                        hint: 'Phone Number',
                        validator: (String value) {
                          if (value == null ||
                              value.isEmpty ||
                              countryCode == '- -') {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                        type: TextInputType.number,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => CodeAuthScreen(
                                    firstName: firstName,
                                    lastName: lastName,
                                    email: email,
                                    password: password,
                                    phoneNumber: phoneNumber),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(sizingInfo.screenSize.width * 0.4,
                              sizingInfo.screenSize.width * 0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
