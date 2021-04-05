import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungmitrphol/utility/dialog.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String name, user, password;

  Container buildName() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: 'Name :',
          prefixIcon: Icon(Icons.fingerprint),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: 'User :',
          prefixIcon: Icon(Icons.perm_identity),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: 'Password :',
          prefixIcon: Icon(Icons.lock_outline),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Center(
        child: Column(
          children: [buildName(), buildUser(), buildPassword(), buildUpload()],
        ),
      ),
    );
  }

  Container buildUpload() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              if ((name?.isEmpty ?? true) ||
                  (user?.isEmpty ?? true) ||
                  (password?.isEmpty ?? true)) {
                normalDialog(context, 'มีช่องว่าง ?', 'กรุณา กรอกทุกช่องสิ คะ');
              } else {
                registerFirebase();
              }
            },
            child: Icon(Icons.cloud_upload),
          ),
        ],
      ),
    );
  }

  Future<Null> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        await value.user.updateProfile(displayName: name);
        await value.user
            .sendEmailVerification()
            .then((value) => print('######## Sent Email ########'));
      }).catchError((onError) =>
              normalDialog(context, onError.code, onError.message));
    });
  }
}
