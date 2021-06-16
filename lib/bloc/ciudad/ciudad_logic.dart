
import 'package:flutter/material.dart';
import 'package:parking_jjsolarte/api/api_ciudad.dart';
import 'package:parking_jjsolarte/bloc/ciudad/ciudad_bloc.dart';

abstract class CiudadLogic {
  Stream<CiudadState> buscarCiudad({@required String nombre});
  Stream<CiudadState> detalleCiudad({@required String id});
}

class CiudadInitialLogic implements CiudadLogic{
  @override
  Stream<CiudadState> buscarCiudad({String nombre}) async*{
    try{
      yield CiudadCargandoState();
      final res = await Api().getCiudadLista(nombre: nombre);
      if(res!=null){
        yield CiudadResultadoState(list: res);
      }else
        yield CiudadErrorState(msj: 'Por favor intente más tarde');
    }catch(e){

    }
  }

  @override
  Stream<CiudadState> detalleCiudad({String id}) async*{
    try{
      yield CiudadCargandoState();
      final res = await Api().getDetalleCiudadLista(id: id);
      if(res!=null){
        yield CiudadResulDetalleState(detalle: res);
      }else
        yield CiudadErrorState(msj: 'Por favor intente más tarde');
    }catch(e){

    }
  }
}