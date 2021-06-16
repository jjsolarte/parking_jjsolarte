part of 'ciudad_bloc.dart';

abstract class CiudadEvent extends Equatable {
  const CiudadEvent();
}

class CiudadBuscarEvent extends CiudadEvent{
  final String nombre;

  CiudadBuscarEvent({@required this.nombre});

  @override
  List<Object> get props => [nombre];
}

class CiudadDetalleEvent extends CiudadEvent{
  final String id;

  CiudadDetalleEvent({@required this.id});

  @override
  List<Object> get props => [id];

}

