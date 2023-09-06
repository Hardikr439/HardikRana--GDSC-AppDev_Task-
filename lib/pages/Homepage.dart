import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color.fromARGB(255, 103, 79, 163),
        actions: [
          IconButton(
            onPressed: () async
          {
            await FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.login))
        ],
      ),
      body:const Center(
        child: Text("User has logged in"),
      )
    );
  }

  
}