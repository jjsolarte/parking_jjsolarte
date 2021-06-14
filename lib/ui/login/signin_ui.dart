import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_jjsolarte/ui/home/home_ui.dart';

class SignInUI extends StatefulWidget {
  const SignInUI({Key key}) : super(key: key);

  @override
  _SignInUIState createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void signIn()async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      Navigator.of(context)
          .pushReplacement(
          MaterialPageRoute(builder: (context) => HomeUI()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: height*0.1,
              left: width*0.05,
              child: Text(
                'Ingresar',
                style: TextStyle(fontSize: size.width * 0.08),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Container(
                    width: width*0.9,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Correo',
                              ),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: width*0.9,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                  hintText: 'Contraseña'
                              ),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: doLogin,
                    child: Container(
                      width: width*0.9,
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text('Ingresar', style: TextStyle(
                              color: Colors.white,
                              fontSize: width*0.04
                          ),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: height*0,
              child: Container(
                  width: width,
                  child: Center(child: Image.asset('assets/icon/parking.png', height: size.height*0.1,))),)
          ],
        ),
      ),
    );
  }

  void doLogin() {
    final validEmail =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(validEmail);
    if (emailController.text.isEmpty) {
      //completa este campo
      print('1');
    } else if (!regExp.hasMatch(emailController.text)) {
      //correo inválido
      print('2');
    }else {
      if(passwordController.text.length<5)
      {
        print('3');
      }//contraseña mayor a 6 caracteres
      else{
        signIn();
      }
    }
  }
}
