import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/base_response_model.dart';

import '../../core/error/handle_exception.dart';
import 'remote_data_source.dart';

class DioRemoteDataSourceImpl extends RemoteDataSource{
  final Dio _dio;

  DioRemoteDataSourceImpl(this._dio);

  @override
  Future<dynamic> delete({required String endpoint, data, params, String? token}) async{
    try {
      Response response = await _dio.delete(endpoint,
        data: json.encode(data),
      );
      return response.data;

    } on DioError catch (e) {
      if(e.type == DioErrorType.response) {
        return BaseResModel(status: e.response?.statusCode ?? 400,
            message: "User or email incorrect");
      }
      else if(e.type == DioErrorType.connectTimeout|| e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout) {
        return BaseResModel(status: e.response?.statusCode ?? 400,
            message: "Network Failure");
      }
      else {
        return BaseResModel(status: e.response?.statusCode ?? 400,
            message: "Something went wrong");
      }
    }
  }

  @override
  Future<dynamic> get({required String endpoint, String? token, params}) async {
   final res = await _dio.get(endpoint,queryParameters: params);
   try {
     return res.data;
   }
   on DioError catch (e) {
     if(e.type == DioErrorType.response) {
       return BaseResModel(status: e.response?.statusCode ?? 400,
           message: "User or email incorrect");
     }
     else if(e.type == DioErrorType.connectTimeout|| e.type == DioErrorType.receiveTimeout || e.type == DioErrorType.sendTimeout) {
       return BaseResModel(status: e.response?.statusCode ?? 400,
           message: "Network Failure");
     }
     else {
       return BaseResModel(status: e.response?.statusCode ?? 400,
           message: "Something went wrong");
     }
   }
  }

  @override
  Future<dynamic> post({required String endpoint,Map<String,dynamic>? data, params, String? token}) async{
    try {
      Response response = await _dio.post(endpoint,
          data: json.encode(data),
      );
      return response.data;

    }
    on Exception catch(e, t){
      debugPrint(e.toString());
      debugPrintStack(stackTrace: t);
      handleException(e);
    }

  }

  @override
  Future<dynamic> put({required String endpoint, data, params, String? token}) async {
    try {
      Response response = await _dio.put(endpoint,
        data: json.encode(data),
      );
      return response.data;

    } on Exception catch(e, t){
      debugPrint(e.toString());
      debugPrintStack(stackTrace: t);
      handleException(e);
    }
  }

}