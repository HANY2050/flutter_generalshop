import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:generalshops/api/authentication.dart';
import 'package:generalshops/screens/home_page.dart';

class CodeAuthScreen extends StatefulWidget {
  final String firstName, lastName, email, password, phoneNumber;

  @override
  _CodeAuthScreenState createState() => _CodeAuthScreenState();

  const CodeAuthScreen(
      {this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.phoneNumber});
}

class _CodeAuthScreenState extends State<CodeAuthScreen> {
  final StringBuffer code1 = StringBuffer(),
      code2 = StringBuffer(),
      code3 = StringBuffer(),
      code4 = StringBuffer(),
      code5 = StringBuffer(),
      code6 = StringBuffer();

  final StringBuffer verificationID = StringBuffer();

  @override
  void initState() {
    super.initState();
    verifyPhoneNumber(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusScope.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please enter the code to verify your phone number',
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        onChanged: (newValue) {
                          code1.clear();
                          code1.write(newValue);
                          focusNode.nextFocus();
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (newValue) {
                          code2.clear();
                          code2.write(newValue);
                          focusNode.nextFocus();
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (newValue) {
                          code3.clear();
                          code3.write(newValue);
                          focusNode.nextFocus();
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (newValue) {
                          code4.clear();
                          code4.write(newValue);
                          focusNode.nextFocus();
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (newValue) {
                          code5.clear();
                          code5.write(newValue);
                          focusNode.nextFocus();
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: TextField(
                        textAlign: TextAlign.center,
                        onChanged: (newValue) {
                          code6.clear();
                          code6.write(newValue);
                          focusNode.nextFocus();
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          contentPadding: EdgeInsets.all(10),
                          fillColor: Colors.grey[300],
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationID.toString(),
                      smsCode: '$code1$code2$code3$code4$code5$code6');
                  await FirebaseAuth.instance
                      .signInWithCredential(credential)
                      .then((user) async {
                    if (user != null) {
                      var user = await Authentication().register(
                          widget.firstName,
                          widget.lastName,
                          widget.email,
                          widget.password,
                          widget.phoneNumber);
                      if (user != null) {
                        print('TOOOOOOOOOOOOOOOOOOOOOOOOOOOT');
                        print(user.mobile);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      } else {
                        print('false');
                      }
                    }
                  });
                }, //verifyPhoneNumber,
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('Doneeeeeeeeeeeeeeeeeeeeeeeeee');
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Erorrrrrrrrrrrrrrrrrrrrrrrrrr');
        print(e.message);
      },
      codeSent: (String verificationId, int resendToken) async {
        print('Sentttttttttttttttttttttttttt');
        verificationID.clear();
        verificationID.write(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationID.clear();
        verificationID.write(verificationId);
        print('Time outtttttttttttttttttttt');
      },
    );
  }
}
