import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:parking_jjsolarte/bloc/ciudad/ciudad_logic.dart';
import 'package:parking_jjsolarte/model/ciudad.dart';
import 'package:parking_jjsolarte/model/ciudad_detalle.dart';

part 'ciudad_event.dart';
part 'ciudad_state.dart';

class CiudadBloc extends Bloc<CiudadEvent, CiudadState> {

  CiudadLogic ciudadLogic;

  CiudadBloc({this.ciudadLogic}) : super(CiudadInitial());

  @override
  Stream<CiudadState> mapEventToState(
    CiudadEvent event,
  ) async* {
    if(event is CiudadBuscarEvent){
      yield* ciudadLogic.buscarCiudad(nombre: event.nombre);
    }if(event is CiudadDetalleEvent){
      yield* ciudadLogic.detalleCiudad(id: event.id);
    }else{
      yield CiudadInitial();
    }
  }
}
