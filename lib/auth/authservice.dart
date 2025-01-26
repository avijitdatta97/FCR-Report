import 'package:fcr_report/db/dbhelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<bool> UserLogIn(String email, String password) async {
    final credential =
        await _auth.signInWithEmailAndPassword(email: email, password: password);
    return DbHelper.isUser(credential.user!.uid);
  }
  
  static Future<void> SignOut(){
    return _auth.signOut();
  }

  static Future<void> resetPassword(String useremail) async{
    return await _auth.sendPasswordResetEmail(email: useremail);
  }
}
