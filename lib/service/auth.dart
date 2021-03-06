import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Giriş Yap
  Future<User?>sigIn(String email, String password) async{
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return user.user;
  }

  //Çıkış Yap
  signOuth() async{
    return await _auth.signOut();
  }


  //Kayıt ol
  Future<User?>createPerson(String email, String password) async{
    var user = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    await _firestore
        .collection("Person")
    .doc(user.user!.uid)
    .set({
      'email' : email,
      'password' : password
    });
    return user.user;
  }
}

