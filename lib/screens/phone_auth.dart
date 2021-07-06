import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:generalshops/screens/code_auth_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  String countryCode = '- -', phoneNumber = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Please enter your phone number'),
              SizedBox(
                height: 15,
              ),
              TextField(
                onChanged: (newValue) {
                  setState(() {
                    phoneNumber = countryCode + newValue;
                    print(phoneNumber);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
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
                  contentPadding: EdgeInsets.all(10),
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Phone Number',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) =>
                        CodeAuthScreen(phoneNumber: phoneNumber),
                  ),
                ), //verifyPhoneNumber,
                child: Text('Send OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
