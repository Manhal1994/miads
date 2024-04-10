class AppError implements Exception{
  final String message;
  int errorCode;
  AppError({required this.message, this.errorCode = 0});

}