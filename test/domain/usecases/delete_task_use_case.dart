import 'package:flutter_test/flutter_test.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/domain/repositories/task_repository.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:maids/domain/usecases/delete_task_use_case.dart';
import 'package:maids/domain/usecases/update_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../generated_test_dependency_test.mocks.dart';


void main() {

  late MockTaskRepository mockTaskRepository ;
  late DeleteTaskUseCase deleteTaskUseCase ;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    deleteTaskUseCase = DeleteTaskUseCase(mockTaskRepository);
  });

  final taskModel = TaskModel(todo:"Todo example", id: 1);
  final basicResponse = BasicResponse(todo: "Todo example", id: 1);

  test(
    'should get baseResponse from the TaskRepository after delete task',
        () async {
      // arrange
      when(mockTaskRepository.deleteTask(taskModel: taskModel))
          .thenAnswer((_) async => basicResponse);
      // act
      final result = await deleteTaskUseCase.call(taskModel);
      // assert
      expect(result, basicResponse);
      verify(mockTaskRepository.deleteTask(taskModel: taskModel));
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );
}
