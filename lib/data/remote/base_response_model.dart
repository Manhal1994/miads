class BaseResModel<T> {
  dynamic data;
  String? message;
  int? status;

  BaseResModel({this.data, this.message, this.status});

  BaseResModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? json['statusCode'];
    data = json["data"];
    message = json["message"].toString() ?? '';
  }
}
