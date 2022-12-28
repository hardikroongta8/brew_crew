import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/myuser.dart';

import 'database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _userFromFirebaseUser(User user){
    return MyUser(uid: user.uid);    
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map((User? user){
      if(user != null){
        return _userFromFirebaseUser(user);
      }
      else{
        return null;
      }
    });
  }


  Future registerEmail(String email, String password) async{
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData('0', 'Your Name', 100);

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
        
  }

  Future signInEmail(String email, String password) async{
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      print(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
        
  }

  Future signOut() async{
    try {
      return(await _auth.signOut());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}