import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/api/authentication.dart';
import 'package:generalshops/customer/user.dart';
import 'package:generalshops/screens/home_page.dart';
import 'package:generalshops/screens/utilities/screen_utilities.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Authentication authentication = Authentication();
  var _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Transform.translate(
          offset: Offset(0, -100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'تسجيل الدخول',
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'دخول لمتابعة تسجيل الحساب',
                    style: Theme.of(context).textTheme.subhead.copyWith(
                        fontSize: 18, color: ScreenUtilities.darkerGreyText),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: _loginFor(context),
              ),
              Container(
                width: double.infinity,
                height: 65,
                margin: EdgeInsets.only(top: 24, bottom: 24),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(34)),
                  color: ScreenUtilities.mainBlue,
                  child: (_loading)
                      ? Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Text(
                          'دخول',
                          style: Theme.of(context).textTheme.subhead.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                  onPressed: (_loading) ? null : _loginUser,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0, 0),
                    child: Text(
                      'لا تمتلك حساب ؟',
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          fontSize: 15, color: ScreenUtilities.darkerGreyText),
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'تسجيل حساب جديد',
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginFor(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'الايميل',
              hintStyle: TextStyle(fontSize: 20),
              labelStyle: TextStyle(fontSize: 20),
            ),
            style: TextStyle(fontSize: 24),
            validator: (value) {
              if (value.isEmpty) {
                return 'Email is required';
              }
              return null;
            },
          ),
          SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'كلمة المرور',
              hintStyle: TextStyle(fontSize: 20),
            ),
            style: TextStyle(fontSize: 24),
            validator: (value) {
              if (value.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  void _loginUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _loading = true;
      });

      String email = _emailController.text;
      String password = _passwordController.text;
      User user = await authentication.login(email, password);
      if (user != null) {
        setState(() {
          _loading = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        setState(() {
          _loading = false;
        });
      }
    }
  }
}
