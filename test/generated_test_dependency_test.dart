import 'package:maids/data/local/local_data_source.dart';
import 'package:maids/data/remote/remote_data_source.dart';
import 'package:maids/domain/repositories/auth_repository.dart';
import 'package:maids/domain/repositories/task_repository.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([AuthRepository, TaskRepository, RemoteDataSource, LocalDataSource])
void main(){

}