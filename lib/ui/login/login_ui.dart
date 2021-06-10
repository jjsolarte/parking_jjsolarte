import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:parking_jjsolarte/ui/login/register_ui.dart';
import 'package:parking_jjsolarte/ui/login/signin_ui.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            LiquidSwipe(pages: [
              SignInUI(),
              RegisterUI()
            ],
              enableLoop: true,
              slideIconWidget: Icon(Icons.arrow_back, color: Colors.red,),
            )
          ],
        ),
      ),
    );
  }
}
