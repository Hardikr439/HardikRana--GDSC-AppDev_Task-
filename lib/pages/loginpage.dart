import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPagestate createState() => LoginPagestate();
}

class LoginPagestate extends State<LoginPage> {
  bool isSelected = true;
  bool _indicate = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  String _error = '';
  String _error1='';

  signInWithEmailAndPassword() async {
    try {
      setState(() {
        _indicate = true;
      });
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email.text, password: _pass.text);
      
    } on FirebaseAuthException catch (e) {
      setState(() {
        _indicate = false;
      });
      if (e.code == 'invalid-email') {
      
           _error = "Invalid E-mail Address";
      
       
      } else if (e.code == 'wrong-password') {
         
            _error1 = "Wrong Password";
       
       
      } else if(e.code=='user-not-found'){
         
           _error = 'User not found';
      }
        _formkey.currentState!.validate();
        _error='';
        _error1='';
    }
  }
  

  Widget toggle() {
    return IconButton(
      onPressed: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      icon: isSelected
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                height: 200,
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  "assets/images/gdsc-social-share.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Welcome to App Dev",
                style: TextStyle(
                    fontSize: 24, color: Color.fromRGBO(117, 117, 117, 1)),
              ),
              const SizedBox(height: 5),
              const Text(
                "Login Here",
                style: TextStyle(
                    fontSize: 24, color: Color.fromRGBO(117, 117, 117, 1)),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: TextFormField(
                  controller: _email,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Email is Empty';
                    }
                    else if(_error!='')
                    {
                      return _error;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 79, 163),
                            width: 1.5)),
                    hintText: "Email",
                    labelText: "Email",
                    floatingLabelStyle:
                        TextStyle(color: Color.fromARGB(255, 103, 79, 163)),
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: Colors.grey,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: TextFormField(
                  controller: _pass,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Password is Empty";
                    }
                    else if(_error1!='')
                    {
                      return _error1;
                    }
                    return null;
                  },
                  maxLength: 20,
                  obscureText: isSelected,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 103, 79, 163),
                            width: 1.5)),
                    hintText: "Password",
                    labelText: "Password",
                    floatingLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 103, 79, 163)),
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: Colors.grey,
                    suffixIcon: toggle(),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                width: 300,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        backgroundColor:
                            const Color.fromARGB(255, 103, 79, 163)),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        signInWithEmailAndPassword();
                      } 
                        _error = '';
                      
                    },
                    child: _indicate
                        ? const CircularProgressIndicator(color: Colors.white,)
                        : const Text("Login")),
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
