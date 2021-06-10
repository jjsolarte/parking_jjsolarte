import 'package:flutter/material.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({Key? key}) : super(key: key);

  @override
  _RegisterUIState createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
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
              top: height*0.1,
              left: width*0.05,
              child: Text(
                'Register',
                style: TextStyle(fontSize: size.width * 0.08, color: Colors.white),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Container(
                    width: width*0.9,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Usuario'
                              ),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: width*0.9,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Contraseña'
                              ),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: width*0.9,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Repetir Contraseña',
                              ),
                            ),
                          )),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: width*0.9,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Center(
                        child: Text('Registrar', style: TextStyle(
                          color: Colors.black,
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
                  color: Colors.white,
                  child: Center(child: Image.asset('assets/icon/parking.png', height: size.height*0.1,))),)
          ],
        ),
      ),
    );
  }
}
