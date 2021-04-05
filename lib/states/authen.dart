import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungmitrphol/utility/dialog.dart';
import 'package:ungmitrphol/widgets/show_alert.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  String user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Account ? '),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/createAccount');
                        },
                        child: Text('Create Account')),
                  ],
                ),
              ],
            ),
            buildCenter(),
          ],
        ),
      ),
    );
  }

  Center buildCenter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildText(),
          buildUser(),
          buildPassword(),
          buildLoginButton()
        ],
      ),
    );
  }

  Container buildLoginButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
                normalDialog(context, 'Have Space ?', 'Please Fill Every Blank');
              } else {
                checkAuthen();
              }
            },
            child: Text('Login'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ],
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
        obscureText: redEye,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: 'Password :',
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: IconButton(
              icon: Icon(Icons.remove_red_eye),
              onPressed: () {
                setState(() {
                  redEye = !redEye;
                });
              }),
        ),
      ),
    );
  }

  Text buildText() {
    return Text(
      'Login',
      style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  

  checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      print('### initialApp Success');
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/showResult', (route) => false))
          .catchError((onError) => normalDialog(context ,onError.code, onError.message));
    });
  }
}
