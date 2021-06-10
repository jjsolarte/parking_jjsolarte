import 'package:flutter/material.dart';

class SignInUI extends StatefulWidget {
  const SignInUI({Key? key}) : super(key: key);

  @override
  _SignInUIState createState() => _SignInUIState();
}

class _SignInUIState extends State<SignInUI> {
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
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Usuario'
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
                              decoration: InputDecoration(
                                  hintText: 'Contraseña'
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
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text('Ingresar', style: TextStyle(
                            color: Colors.white,
                            fontSize: width*0.04
                        ),),
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
}
