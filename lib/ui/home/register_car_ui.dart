import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parking_jjsolarte/model/models.dart';

class RegisterCarUI extends StatefulWidget {
  const RegisterCarUI({Key key}) : super(key: key);

  @override
  _RegisterCarUIState createState() => _RegisterCarUIState();
}

class _RegisterCarUIState extends State<RegisterCarUI> {

  final DatabaseReference db = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String user;

  UserParking userParking = UserParking();
  List<Reg> listReg = List<Reg>();

  void parseReg(DataSnapshot value){
    Map<dynamic, dynamic> values = value.value['reg'];
    values.forEach((key, values) {
      Reg reg = Reg(
        placa: values['placa'],
        color: values['color'],
        tipo: values['tipo'],
      );
      listReg.add(reg);
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

              if(listReg.length>0)
              Container(
                height: height*0.6,
                width: width,
                child: ListView.builder(
                  itemCount: listReg.length,
                    itemBuilder: (context, item){
                  return itemCar(width, height, listReg[item].placa);
                }),
              )
              else
                Container(
                  height: height*0.6,
                  width: width,
                  child: Center(
                    child: Text('Aún no tiene vehículos registrados',
                      style: TextStyle(
                        fontSize: width*0.05
                      ),),
                  ),
                )
              ,

              //AddCar
              SizedBox(height: 25,),
              InkWell(
                onTap: (){
                  addCar(context: context, user: user, auth: auth);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.add,color: Colors.white,),
                    ),
                    SizedBox(width: 5,),
                    Text('Registrar Vehículo', style: TextStyle(fontSize: width*0.06, fontWeight: FontWeight.bold),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static void addCar(
      {@required BuildContext context, String user, FirebaseAuth auth}){
    final size = MediaQuery.of(context).size;
    TextEditingController placaController = TextEditingController();
    Dialog errorDialog = Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
      child: Container(
        height: size.width*0.8,
        width: size.width*0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('¡Nuevo Vehículo!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue, fontSize: size.width*0.05, fontFamily: 'Poppins-Medium')),
            Column(
              children: [
                Container(
                  width: size.width*0.7,
                  child: Center(
                    child: Text('Por favor ingrese la placa',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: size.width*0.04, fontFamily: 'Poppins-Regular'),),
                  ),
                ),
                Container(
                  width: size.width*0.7,
                  child: Center(
                    child: TextFormField(
                      controller: placaController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.lightBlueAccent,
                      style: TextStyle(
                        color: Colors.black38,
                      ),
                      decoration: InputDecoration(
                          labelText: 'Placa',
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: Colors.black38,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.black38,
                          )),
                    ),
                  ),
                ),
                Container(
                  width: size.width*0.7,
                  height: 1,
                  color: Colors.black38,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                    child: Text('Cancelar', style: TextStyle(color:
                    Colors.blue, fontSize: size.width*0.04, fontFamily: 'Poppins-Regular'),)),
                TextButton(onPressed: ()async{
                  final DatabaseReference db = FirebaseDatabase.instance.reference();
                    user = auth.currentUser.uid;
                  if(user!=null)
                  db.child(user).child('reg').child(placaController.text).set({
                    'placa':placaController.text,
                    'tipo':'carro',
                    'color':'AZUL'
                  });
                  Navigator.of(context).pop();
                },
                    child: Text('Aceptar', style: TextStyle(color:
                    Colors.blue, fontSize: size.width*0.05, fontFamily: 'Poppins-Medium'),)),
              ],
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);
  }

  Widget itemCar(double width, double height, String placa){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              backgroundColor: Colors.black12,
              radius: height * 0.04,
              child: Icon(
                Icons.motorcycle,
                color: Colors.black,
                size: height * 0.05,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vehículo',
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  'Tipo',
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  'Color',
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placa,
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  'CARRO',
                  style: TextStyle(fontSize: width * 0.04,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5,),
                Text(
                  'AZUL',
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

  void inputData(){
    user = auth.currentUser.uid;

    if(user!=null)
      db.child(user).once().then((value) => {
        print(value.value['reg']),
        parseReg(value)
      });
  }

}

