import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc/pages/Homepage.dart';
import 'package:gdsc/pages/loginpage.dart';

class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body:
      StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,AsyncSnapshot<User?> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const CircularProgressIndicator();
          }
          else
          {
            if(snapshot.hasData)
            {
              return const Homepage();
            }
            else
            {
              return const LoginPage();
            }
          }
          
        },
      )
    );
  }

}