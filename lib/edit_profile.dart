import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fcr_report/auth/authservice.dart';
import 'package:fcr_report/providers/user_provider.dart';
import 'package:fcr_report/utils/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  static const String routeName = '/editprofile';

  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _userEmailController = TextEditingController();
  String _userEmail = '';

  final _editProfileFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _userEmail = Provider.of<UserProvider>(context).userModel!.email.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
        key: _editProfileFormKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 25, color: Colors.green),
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _userEmailController,
                decoration: InputDecoration(
                    label: Text('Enter your email'),
                    prefixIcon: Icon(Icons.email),
                    filled: true,
                    fillColor: Colors.green[50],
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 3),
                    )),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please enter your email address";
                  }
                },
              ),

              SizedBox(height: 10,),

              Align(alignment: Alignment.topLeft,child: ElevatedButton(onPressed: _save, child: Text('Send Email'))),

            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    print(_userEmail);
    EasyLoading.show(status: 'Please Wait', dismissOnTap: false,);
    if(_userEmail != _userEmailController.text){
      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: 'Email is not valid.',
        fontSize: 18,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }
    if (_editProfileFormKey.currentState!.validate()) {
      try {
        AuthService.resetPassword(_userEmailController.text).then((value) {
          EasyLoading.dismiss();
          Fluttertoast.showToast(
            msg: 'A link is send on your email.',
            fontSize: 18,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            timeInSecForIosWeb: 2,
            toastLength: Toast.LENGTH_LONG,
          );
        });
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: error.toString(),
          fontSize: 18,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          timeInSecForIosWeb: 2,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }else{
      EasyLoading.dismiss();
      Fluttertoast.showToast(
        msg: 'Please Enter a Valid Email ',
        fontSize: 18,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
