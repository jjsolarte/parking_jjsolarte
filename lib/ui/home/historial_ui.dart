import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parking_jjsolarte/model/models.dart';

class HistorialUI extends StatefulWidget {
  const HistorialUI({Key key}) : super(key: key);

  @override
  _HistorialUIState createState() => _HistorialUIState();
}

class _HistorialUIState extends State<HistorialUI> {

  final DatabaseReference db = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String user;

  UserParking userParking = UserParking();
  List<Ser> listSer = List<Ser>();
  List<String> fechas = List<String>();

  void inputData(){
    user = auth.currentUser.uid;

    if(user!=null)
      db.child(user).once().then((value) => {
        print(value.value['ser']),
        parseReg(value)
      });
  }

  void parseReg(DataSnapshot value){
    Map<dynamic, dynamic> values = value.value['ser'];
    values.forEach((key, values) {
      Ser ser = Ser(
        placa: values['placa'],
        hrEntrada: values['hrEntrada'],
        hrSalida: values['hrSalida'],
        valor: values['valor'],
      );
      fechas.add(key);
      listSer.add(ser);
    });
    setState(() {});
  }

  @override
  void initState() {
    inputData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              if(listSer.length>0)
                Container(
                  height: height*0.75,
                  width: width,
                  child: ListView.builder(
                      itemCount: listSer.length,
                      itemBuilder: (context, item){
                        return itemCar(width, height, listSer[item].placa, item);
                      }),
                )
              else
                Container(
                  height: height*0.6,
                  width: width,
                  child: Center(
                    child: Text('Aún no tienes servicios registrados',
                      style: TextStyle(
                          fontSize: width*0.05
                      ),),
                  ),
                )
              ,
            ],
          ),
        ),
      ),
    );
  }

  Widget itemCar(double width, double height, String placa, int item){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(fechas[item].substring(0,10), style: TextStyle(
                    fontSize: width*0.05
                ),),
                SizedBox(height: 10,),
                CircleAvatar(
                  backgroundColor: Colors.black12,
                  radius: height * 0.04,
                  child: Icon(
                    Icons.motorcycle,
                    color: Colors.black,
                    size: height * 0.05,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'PLACA',
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  'Hr. Entrada',
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  'Hr. Salida',
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  'Valor',
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  placa,
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  listSer[item].hrEntrada,
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  listSer[item].hrSalida,
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  '\$'+listSer[item].valor,
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: width*0.9,
            height: 1,
            color: Colors.black12,
          ),
        ),
      ],
    );
  }
}
