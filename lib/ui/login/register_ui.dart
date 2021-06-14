import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_jjsolarte/ui/home/home_ui.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({Key key}) : super(key: key);

  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();

  void register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      Navigator.of(context)
          .pushReplacement(
          MaterialPageRoute(builder: (context) => HomeUI()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: height * 0.1,
              left: width * 0.05,
              child: Text(
                'Register',
                style: TextStyle(
                    fontSize: size.width * 0.08, color: Colors.white),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width * 0.9,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                          color: Colors.black,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Correo',
                                fillColor: Colors.white,
                                suffixStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width * 0.9,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                          color: Colors.black,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              obscureText: true,
                              controller: passwordController,
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Contraseña',
                                fillColor: Colors.white,
                                suffixStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width * 0.9,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                          color: Colors.black,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              obscureText: true,
                              controller: password2Controller,
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Repetir Contraseña',
                                fillColor: Colors.white,
                                suffixStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: doRegister,
                    child: Container(
                      width: width * 0.9,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            'Registrar',
                            style: TextStyle(
                                color: Colors.black, fontSize: width * 0.04),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: height * 0,
              child: Container(
                  width: width,
                  color: Colors.white,
                  child: Center(
                      child: Image.asset(
                    'assets/icon/parking.png',
                    height: size.height * 0.1,
                  ))),
            )
          ],
        ),
      ),
    );
  }

  void doRegister() {
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
      else if(passwordController.text != password2Controller.text){
        print('4');
        //las contraseñas no coinciden
      }else{
        register();
      }
    }
  }
}
