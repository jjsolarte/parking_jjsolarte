import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking_jjsolarte/bloc/ciudad/ciudad_bloc.dart';
import 'package:parking_jjsolarte/model/ciudad.dart';
import 'package:parking_jjsolarte/model/ciudad_detalle.dart';

class BuscarCiudad extends StatefulWidget {
  const BuscarCiudad({Key key}) : super(key: key);

  @override
  _BuscarCiudadState createState() => _BuscarCiudadState();
}

class _BuscarCiudadState extends State<BuscarCiudad> {

  CiudadBloc ciudadBloc;
  TextEditingController ciudadController;
  Ciudad ciudad = Ciudad();
  CiudadDetalle ciudadDetalle = CiudadDetalle();

  @override
  void initState() {
    ciudadBloc = BlocProvider.of<CiudadBloc>(context);
    ciudadController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima App'),
      ),
      body: BlocListener<CiudadBloc, CiudadState>(
        listener: (context, state){
          if(state is CiudadResultadoState)
            ciudad = state.list.first;
          if(state is CiudadResulDetalleState)
            ciudadDetalle = state.detalle;
        },
        child: BlocBuilder<CiudadBloc, CiudadState>(builder: (context, state){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      controller: ciudadController,
                      decoration: InputDecoration(
                          border: InputBorder.none
                      ),
                      onChanged: (_){
                        buscar(_);
                      },
                    ),
                  ),
                ),
              ),

              //Resultado de ciudades
              if(ciudad.title!=null)
              Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.location_city, size: 50,),
                      ),
                      InkWell(
                        onTap: (){
                          verDetalle();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ciudad.title ?? 'Nombre', style: TextStyle(fontSize: width*0.06),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('Lat : '+ciudad.lattLong.split(',').first ?? '', style: TextStyle(fontSize: width*0.04),),
                                SizedBox(width: 10,),
                                Text('Lon : '+ciudad.lattLong.split(',').last ?? '', style: TextStyle(fontSize: width*0.04),),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 20,),

                  if(ciudadDetalle.title!=null)
                  Column(
                    children: [
                      Text('Detalles', style: TextStyle(fontSize: width*0.07),),
                      SizedBox(height: 10,),
                      Container(
                        width: width*0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(ciudadDetalle.locationType ?? 'Nombre', style: TextStyle(fontSize: width*0.06),),
                            SizedBox(height: 10,),
                            Text(ciudadDetalle.timezone ?? 'Nombre', style: TextStyle(fontSize: width*0.06),),
                            SizedBox(height: 10,),
                            Text(ciudadDetalle.sunRise.toString() ?? 'Nombre', style: TextStyle(fontSize: width*0.06),),
                            SizedBox(height: 10,),
                            Text(ciudadDetalle.time.toString() ?? 'Nombre', style: TextStyle(fontSize: width*0.06),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }

  void buscar(String s) {
    if(s!='')
      ciudadBloc.add(CiudadBuscarEvent(nombre: s));
  }

  void verDetalle() {
    ciudadBloc.add(CiudadDetalleEvent(id: ciudad.woeid.toString()));
  }
}
