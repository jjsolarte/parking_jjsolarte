// To parse this JSON data, do
//
//     final userParking = userParkingFromJson(jsonString);

import 'dart:convert';

List<UserParking> userParkingFromJson(String str) => List<UserParking>.from(json.decode(str).map((x) => UserParking.fromJson(x)));

String userParkingToJson(List<UserParking> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserParking {
  UserParking({
    this.uid,
    this.reg,
    this.ser,
  });

  String uid;
  List<Reg> reg;
  List<Ser> ser;

  factory UserParking.fromJson(Map<String, dynamic> json) => UserParking(
    uid: json["uid"],
    reg: List<Reg>.from(json["reg"].map((x) => Reg.fromJson(x))),
    ser: List<Ser>.from(json["ser"].map((x) => Ser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "reg": List<dynamic>.from(reg.map((x) => x.toJson())),
    "ser": List<dynamic>.from(ser.map((x) => x.toJson())),
  };
}

class Reg {
  Reg({
    this.placa,
    this.tipo,
    this.color,
  });

  String placa;
  String tipo;
  String color;

  factory Reg.fromJson(Map<String, dynamic> json) => Reg(
    placa: json["placa"],
    tipo: json["tipo"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "placa": placa,
    "tipo": tipo,
    "color": color,
  };
}

class Ser {
  Ser({
    this.placa,
    this.hrEntrada,
    this.hrSalida,
    this.valor,
    this.pago
  });

  String placa;
  String hrEntrada;
  String hrSalida;
  String valor;
  String pago;

  factory Ser.fromJson(Map<String, dynamic> json) => Ser(
    placa: json["placa"],
    hrEntrada: json["hrEntrada"],
    hrSalida: json["hrSalida"],
    valor: json["valor"],
    pago: json["pago"],
  );

  Map<String, dynamic> toJson() => {
    "placa": placa,
    "hrEntrada": hrEntrada,
    "hrSalida": hrSalida,
    "valor": valor,
    "pago": pago,
  };
}


