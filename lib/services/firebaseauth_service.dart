import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

  class FirebaseAuthService{
    final FirebaseAuth _fbAuth = FirebaseAuth.instance;
    
    Future<User?> signIn({String? email, String? password}) async{
      try{
      UserCredential ucred = await _fbAuth.signInWithEmailAndPassword(
        email: email!, password: password!);
      User? user = ucred.user;
      debugPrint("Sign in successful! userid: $ucred.user.uid, user:$user. ");
      return user!;
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!, gravity:  ToastGravity.TOP);
      return null;
    } catch(e){
      return null;
    }
  }

  Future<User?> singUp({String? email, String? password}) async{
      try{
      UserCredential ucred = await _fbAuth.createUserWithEmailAndPassword(
        email: email!, password: password!);
      User? user = ucred.user;
      debugPrint("Sign up successful! userid: $ucred.user.uid, user:$user. ");
      return user!;
    } on FirebaseAuthException catch(e) {
      Fluttertoast.showToast(msg: e.message!, gravity:  ToastGravity.TOP);
      return null;
    } catch(e){
      return null;
    }
  }

  Future<void> signOut() async{
    await _fbAuth.signOut();
  }
}

  
