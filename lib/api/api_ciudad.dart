import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:parking_jjsolarte/model/ciudad.dart';
import 'package:parking_jjsolarte/model/ciudad_detalle.dart';

class Api{

  Dio _dio = Dio();

  Future<List<Ciudad>> getCiudadLista({@required String nombre})async{

    try{
      final url = 'https://www.metaweather.com/api/location/search/?query='+nombre;

      final get = await _dio.get(url);

      if(get.statusCode == 200){
        final json = get.data;
        List<Ciudad> list = List<Ciudad>();

        var ciudad = Ciudad.fromJson(json[0]);

        list.add(ciudad);
        print(ciudad);
        return list;
      }else{
        return null;
      }
    }catch(e){
      print(e);
    }

  }

  Future<CiudadDetalle> getDetalleCiudadLista({@required String id})async{

    try{
      final url = 'https://www.metaweather.com/api/location/'+id;

      final get = await _dio.get(url);

      if(get.statusCode == 200){
        final json = get.data;
        CiudadDetalle detalle= CiudadDetalle();

        detalle = CiudadDetalle.fromJson(json);
        print(detalle);
        return detalle;
      }else{
        return null;
      }
    }catch(e){
      print(e);
    }

  }


}