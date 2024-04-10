import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:maids/core/error/app_error.dart';

handleException(Exception e) {
  if (e is DioError) {
    if (e.type == DioErrorType.response) {
      throw AppError(
          message: e.response?.data["message"] ?? e.message, errorCode: 100);
    } else if (e.type == DioErrorType.connectTimeout ||
        e.type == DioErrorType.receiveTimeout ||
        e.type == DioErrorType.sendTimeout) {
      throw AppError(message: "Network Failure", errorCode: 102);
    } else if (e.type == DioErrorType.other) {
      if (e.message.contains("host lookup")) {
        throw AppError(message: "Network Failure", errorCode: 102);
      } else {
        throw AppError(
            message: e.response?.data["message"] ?? e.message, errorCode: 104);
      }
    } else {
      throw AppError(message: e.message, errorCode: 104);
    }
  } else {
    throw AppError(message: "Something went wrong", errorCode: 106);
  }
}
