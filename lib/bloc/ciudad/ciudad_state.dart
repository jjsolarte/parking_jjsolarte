part of 'ciudad_bloc.dart';

abstract class CiudadState extends Equatable {
  const CiudadState();
}

class CiudadInitial extends CiudadState {
  @override
  List<Object> get props => [];
}

class CiudadCargandoState extends CiudadState{

  @override
  List<Object> get props => [];

}

class CiudadResultadoState extends CiudadState{
  List<Ciudad> list;

  CiudadResultadoState({@required this.list});

  @override
  List<Object> get props => [list];
}

class CiudadResulDetalleState extends CiudadState{
  CiudadDetalle detalle;

  CiudadResulDetalleState({@required this.detalle});

  @override
  List<Object> get props => [detalle];
}

class CiudadErrorState extends CiudadState{
  String msj;

  CiudadErrorState({@required this.msj});

  @override
  List<Object> get props => [msj];

}