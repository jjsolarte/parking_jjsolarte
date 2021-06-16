import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parking_jjsolarte/ui/clima/buscar_ciudad.dart';
import 'package:parking_jjsolarte/ui/home/activos_ui.dart';
import 'package:parking_jjsolarte/ui/home/historial_ui.dart';
import 'package:parking_jjsolarte/ui/home/register_car_ui.dart';
import 'package:parking_jjsolarte/ui/splash/splash_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  PageController pageController = PageController();
  int indexPage = 0;

  final DatabaseReference db = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String user;

  void inputData() async {
    user = auth.currentUser.uid;
  }

  @override
  void initState() {
    inputData();

    // if(user!=null)
    // db.child(user!).child('ABC123D').set({
    //   'tipo':'carro',
    //   'color':'AZUL'
    // });
    // db.child(user!).once().then((value) => {
    //   print(value.value['tipo'])
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('parking'),
        backgroundColor: Colors.black,
        actions: [
          TextButton(
            onPressed: () async{
              Navigator.of(context)
                  .push(
                  MaterialPageRoute(builder: (context) => BuscarCiudad()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.wb_sunny),
            ),
          ),
          TextButton(
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushReplacement(
                  MaterialPageRoute(builder: (context) => SplashScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [

            //Lista Vehículos
            Positioned(
                top: 0,
                left: width * 0.05,
                child: Container(
                  width: width * 0.9,
                  height: height * 0.8,
                  child: PageView(
                    onPageChanged: (_){
                      indexPage = _;
                    },
                    controller: pageController,
                    children: [
                      RegisterCarUI(),
                      ActivosUI(
                        onSelected: (v){
                          indexPage = 2;
                          pageController.animateToPage(indexPage,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.decelerate);
                          setState(() {

                          });
                        },
                      ),
                      HistorialUI(),
                    ],
                  ),
                )),

            //menu
            Positioned(
                bottom: width * 0.05,
                left: width * 0.05,
                child: Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            indexPage = 0;
                            pageController.animateToPage(indexPage,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                            setState(() {

                            });
                          },
                          child: indexPage == 0 ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.car_rental,
                                color: Colors.black,
                                size: height * 0.045,
                              )) : Icon(
                            Icons.car_rental,
                            color: Colors.white,
                            size: height * 0.045,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            indexPage = 1;
                            pageController.animateToPage(indexPage,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                            setState(() {

                            });
                          },
                          child: indexPage == 1 ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.how_to_reg,
                                color: Colors.black,
                                size: height * 0.045,
                              )) : Icon(
                            Icons.how_to_reg,
                            color: Colors.white,
                            size: height * 0.045,
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            indexPage = 2;
                            pageController.animateToPage(indexPage,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate);
                            setState(() {

                            });
                          },
                          child: indexPage == 2 ? CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.history,
                                color: Colors.black,
                                size: height * 0.045,
                              )) : Icon(
                            Icons.history,
                            color: Colors.white,
                            size: height * 0.045,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
