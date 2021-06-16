import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_jjsolarte/bloc/ciudad/ciudad_bloc.dart';
import 'package:parking_jjsolarte/bloc/ciudad/ciudad_logic.dart';
import 'package:parking_jjsolarte/ui/home/home_ui.dart';
import 'package:parking_jjsolarte/ui/splash/splash_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context){
          return CiudadBloc(ciudadLogic: CiudadInitialLogic());
        }),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LoadingPage(),
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Scaffold(
            body: Center(
              child: Text('Error ${snapshot.error}'),
            ),
          );
        if (snapshot.connectionState == ConnectionState.done)
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  Object user = snapshot.data;
                  if (user == null) {
                    return SplashScreen();
                  } else {
                    return HomeUI();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Text('Checking Authentication ...'),
                  ),
                );
              });
        else
          return Scaffold(
            body: Center(
              child: Text('Connecting to the App..'),
            ),
          );
      },
    );
  }
}
