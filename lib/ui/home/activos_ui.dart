import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:parking_jjsolarte/model/models.dart';

class ActivosUI extends StatefulWidget {

  final Function(int) onSelected;

  ActivosUI({@required this.onSelected});

  @override
  _ActivosUIState createState() => _ActivosUIState();
}

class _ActivosUIState extends State<ActivosUI> {
  final DatabaseReference db = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String user;

  int estado = 0;

  UserParking userParking = UserParking();
  List<Ser> listSer = List<Ser>();
  List<String> fechas = List<String>();

  String dropdownValue = '';
  String serId;
  List<String> carros = [''];

  Ser serIncompleto = Ser();

  List<Reg> listReg = List<Reg>();
  var valorPagar;

  void parseReg(DataSnapshot value) {
    Map<dynamic, dynamic> values = value.value['reg'];
    values.forEach((key, values) {
      Reg reg = Reg(
        placa: values['placa'],
        color: values['color'],
        tipo: values['tipo'],
      );
      listReg.add(reg);
      carros.add(reg.placa);
      dropdownValue = carros[0];
    });
    setState(() {});
  }

  void inputData() {
    user = auth.currentUser.uid;

    if (user != null) {
      db
          .child(user)
          .once()
          .then((value) => {print(value.value['ser']), parseSer(value)});
      db
          .child(user)
          .once()
          .then((value) => {print(value.value['reg']), parseReg(value)});
    }
  }

  void parseSer(DataSnapshot value) {
    Map<dynamic, dynamic> values = value.value['ser'];
    values.forEach((key, values) {
      Ser ser = Ser(
        placa: values['placa'],
        hrEntrada: values['hrEntrada'],
        hrSalida: values['hrSalida'],
        valor: values['valor'],
        pago: values['pago'],
      );
      fechas.add(key);
      listSer.add(ser);
      if(ser.pago=='no') {
        serIncompleto = ser;
        serId = key;
      }
    });
    if (serIncompleto.hrSalida.length < 1) {
      estado = 1;
    } else if (serIncompleto.pago == 'no') {
      estado = 2;
    } else {
      estado = 0;
    }
    setState(() {});
  }

  void calcularDiff(){
    var diff = DateTime.now()
        .difference(DateTime(
        int.parse(serId.toString().substring(0, 4)),
        int.parse(serId.toString().substring(5, 7)),
        int.parse(serId.toString().substring(8, 10)),
        int.parse(
            serId.toString().substring(11, 13)),
        int.parse(
            serId.toString().substring(14, 16)),
        int.parse(
            serId.toString().substring(17, 19))
    ));
    valorPagar = diff.inMinutes*0.01666;
    estado = 2;
    db.child(user).child('ser').child(serId).set({
      'placa': serIncompleto.placa,
      'hrEntrada': serIncompleto.hrEntrada,
      'hrSalida':
      DateTime.now().toString().substring(11, 16).toString(),
      'valor': valorPagar.toString(),
      'pago': 'no'
    });
    setState(() {
    });
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (carros.length > 0)
              if (estado == 0)
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        'Seleccione Vehículo',
                        style: TextStyle(fontSize: width * 0.04),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      height: height * 0.05,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: dropdownValue,
                          items: carros.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              dropdownValue = value;
                            });
                          },
                        ),
                      ),
                    )),
                  ],
                )
              else
                Container(
                  child: Center(
                    child: Text(listSer.first.placa),
                  ),
                )
            else
              Container(
                child: Center(
                  child: Text('No hay vehículos disponibles'),
                ),
              ),

            //infoControlTime
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    if (estado == 1 || estado == 2)
                      Text(
                        'Hr. Entrada',
                        style: TextStyle(fontSize: width * 0.05),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (estado == 2)
                      Text(
                        'Hr. Salida',
                        style: TextStyle(fontSize: width * 0.05),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (estado == 2)
                      Text(
                        'Valor',
                        style: TextStyle(fontSize: width * 0.05),
                      ),
                  ],
                ),
                Column(
                  children: [
                    if (estado == 1 || estado == 2)
                      Text(
                        serIncompleto.hrEntrada != null ?
                        serIncompleto.hrEntrada == '' ?
                        DateTime.now().toString().substring(11,16): serIncompleto.hrEntrada : '',
                        style: TextStyle(fontSize: width * 0.05),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (estado == 2)
                      Text(
                        serIncompleto.hrSalida != null ?
                        serIncompleto.hrSalida == '' ?
                        DateTime.now().toString().substring(11,16) :
                        serIncompleto.hrSalida : '',
                        style: TextStyle(fontSize: width * 0.05),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    if (estado == 2)
                      Text(
                        estado == 2 ? '\$'+serIncompleto.valor : '\$'+valorPagar.toString(),
                        style: TextStyle(fontSize: width * 0.05),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            //Btns
            if (estado == 0 && dropdownValue != '')
              InkWell(
                onTap: () {
                  estado = 1;
                  setState(() {});
                  db
                      .child(user)
                      .child('ser')
                      .child(DateTime.now().toString().substring(0, 19))
                      .set({
                    'placa': dropdownValue,
                    'hrEntrada':
                        DateTime.now().toString().substring(11, 16).toString(),
                    'hrSalida': '',
                    'valor': '',
                    'pago': 'no'
                  });
                  widget.onSelected(1);
                },
                child: Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      ':)  Empezar  (:',
                      style: TextStyle(
                          fontSize: width * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
              ),
            if (estado == 1)
              InkWell(
                onTap: () {
                  calcularDiff();
                  widget.onSelected(1);
                },
                child: Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      ':)  Stop  (:',
                      style: TextStyle(
                          fontSize: width * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
              ),
            if (estado == 2)
              InkWell(
                onTap: () {
                  estado = 0;
                  setState(() {});
                  db.child(user).child('ser').child(serId).set({
                    'placa': serIncompleto.placa,
                    'hrEntrada': serIncompleto.hrEntrada,
                    'hrSalida': serIncompleto.hrSalida,
                    'valor': serIncompleto.valor,
                    'pago': 'si'
                  });
                  widget.onSelected(1);
                },
                child: Container(
                  width: width * 0.9,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      ':)  Pagar  (:',
                      style: TextStyle(
                          fontSize: width * 0.05,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

