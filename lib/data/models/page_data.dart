import 'package:equatable/equatable.dart';

class PageData<T> extends Equatable {
  int total;
  int skip;
  int limit;
  List<T> items;

  PageData({
    required this.total,
    required this.skip,
    required this.limit,
    required this.items,
  });

  PageData.fromJson(
      Map<String, dynamic> json, T Function(dynamic map) fromJsonModel)
      : limit = json['limit'],
        skip = json['skip'],
        total = json['total'],
        items =
            (json['todos'] as Iterable).map((e) => fromJsonModel(e)).toList();

  @override
  List<Object?> get props => [total, skip, limit, items];
}
