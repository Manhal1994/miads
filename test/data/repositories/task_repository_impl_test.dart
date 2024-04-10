import 'package:flutter_test/flutter_test.dart';
import 'package:maids/data/models/page_data.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/data/remote/dto/login_response.dart';
import 'package:maids/data/remote/remote_data_source.dart';
import 'package:maids/data/repositories/auth_repository_impl.dart';
import 'package:maids/data/repositories/task_repository_impl.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../generated_test_dependency_test.mocks.dart';

void main() {
  late TaskRepositoryImpl taskRepositoryImpl;
  late MockLocalDataSource mockLocalDataSource;

  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    taskRepositoryImpl =
        TaskRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });
  const todo = "todo";

  final BasicResponse basicResponse = BasicResponse(id: 1, todo: todo);
  test(
    'should  return [BasicResponse] for create task',
    () async {
      const endpoint = "/products/add";
      final data = {"title": todo};
      // arrange
      when(mockRemoteDataSource.post(
        endpoint: endpoint,
        data: data,
      )).thenAnswer((_) async => {"id": 1, "title": todo});

      // act
      final result = await taskRepositoryImpl.createTask(todo: todo,me: false);
      // assert
      expect(result, basicResponse);
    },
  );
  test(
    'should  return [BasicResponse] for update task',
    () async {
      const endpoint = "/products/1";
      final data = {"title": todo};
      // arrange
      when(mockRemoteDataSource.put(
        endpoint: endpoint,
        data: data,
      )).thenAnswer((_) async => {"id": 1, "title": todo});

      // act
      final result = await taskRepositoryImpl.updateTask(
          taskModel: TaskModel(todo: todo, id: 1));
      // assert
      expect(result, basicResponse);
    },
  );

  test(
    'should return [BasicResponse] after delete task',
    () async {
      const endpoint = "/products/1";
      final data = {"title": todo};
      // arrange
      when(mockRemoteDataSource.delete(
        endpoint: endpoint,
        data: data,
      )).thenAnswer((_) async => {"id": 1, "title": todo});

      // act
      final result = await taskRepositoryImpl.deleteTask(
          taskModel: TaskModel(todo: todo, id: 1));
      // assert
      expect(result, basicResponse);
    },
  );

  test(
    'should get PageData<TaskModel>',
        () async {
      const endpoint = "/todos";
      const skip = 0;
      const limit = 10;
      final param = {
        "skip": skip,
        "limit": limit
      };

      // arrange
      when(mockLocalDataSource.getMyTasks(true)).thenAnswer((_)async=> []);

      when(mockRemoteDataSource.get(
        endpoint: endpoint,
        params: param,
      )).thenAnswer((_) async => {"total": 1, "limit": 10, "skip": 0, "todos": [{
        "id": 1,
        "todo": "todo"
      }]});

      // act
      final result = await taskRepositoryImpl.getTasks(
          skip: skip, limit: 10);
      // assert
      expect(result, PageData<TaskModel>(total: 1, skip: 0, limit: 10, items: [TaskModel(todo: todo, id: 1)]));
    },
  );
}
