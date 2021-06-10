import 'package:flutter/material.dart';
import 'package:parking_jjsolarte/ui/login/login_ui.dart';
import 'package:parking_jjsolarte/ui/login/register_ui.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), (){
      Navigator.of(context)
          .push(
          MaterialPageRoute(builder: (context) => LoginUI()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset('assets/icon/parking.png', width: size.width*0.9, height: size.height*0.4,),
          ),
          Positioned(
              bottom: size.height * 0.1,
              child: Container(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Jeison Solarte',
                        style: TextStyle(fontSize: size.width * 0.05),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
