import 'package:fcr_report/HomePage.dart';
import 'package:fcr_report/auth/authservice.dart';
import 'package:fcr_report/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LogInPage extends StatefulWidget {
  static const String routeName = '/loginpage';

  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errMsg = '';
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/login_background.png"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  "images/f1.png",
                  height: 100,
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome  !",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: "User Email",
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Email Address";
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _passwordController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.white),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Password (At Least 6 characters)";
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              _errMsg,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 10, right: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)))),
                                onPressed: _authenticate,
                                child: const Text(
                                  "Log In",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: null,
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(color: Colors.white),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 50.0, right: 50.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50)))),
                              onPressed: null,
                              child: const Text(
                                "Create Account",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              "Don't Have an Account?",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "www.avijitdatta.xyz",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _authenticate() async{
    if (_formkey.currentState!.validate()) {
      EasyLoading.show(status: "Please Wait", dismissOnTap: false);
      final email = _emailController.text;
      final password = _passwordController.text;
      try{
        final status = await AuthService.UserLogIn(email, password);
        if(status){
          EasyLoading.dismiss();
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
        else{
          AuthService.SignOut();
          EasyLoading.dismiss();
          setState(() {
            _errMsg = 'You are not a User. Please try with a user account or create an account.';
          });
        }
      }on FirebaseAuthException catch (error){
        EasyLoading.dismiss();
        setState(() {
          _errMsg = 'Please Enter Valid Email or Password.';
        });
      }
    }
    else{
      setState(() {
        _errMsg = 'Please Enter Valid Email or Password.';
      });
    }
  } //authenticate end
}
