import 'package:firebase_auth/firebase_auth.dart';

class FireHelper{
  final FirebaseAuth auth = FirebaseAuth.instance;

  get user => auth.currentUser;

  Future<String?> signUp({required String mail,required String password}) async{
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code){
        case 'email-already-in-use':
          return "The email is already in use by another account";
        case 'Invalid-email':
          return "The email is not valid";
        case 'Weak password':
          return "The password is too weak. Please choose a stronger password";
        default:
          return e.message;
      }
    } catch (e) {
      return "An unknown error occured";
    }
  }

  Future<String?> signIn({required String mail,required String password}) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: mail,
          password: password
      );
    } on FirebaseAuthException catch (e) {
    if(e.code == 'user-not-found')
      {
        return "No user found with this email";
      }
    else if(e.code == 'Wrong-password')
      {
        return "Incorrect password. Please try again";
      }
    else if(e.code == 'Invalid-email')
    {
      return "The email adress is not valid";
    }
    else if(e.code == 'User-desabled')
    {
      return "The user account has been disabled";
    }
    else
      {
        return e.message;
      }
    }
    catch (e)
    {
      return "Unknown error occured. Please try again later";
    }
  }
  Future<String?> signout() async{
    await auth.signOut();


  }

}

