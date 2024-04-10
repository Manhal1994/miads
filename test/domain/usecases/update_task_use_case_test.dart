import 'package:flutter_test/flutter_test.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/domain/repositories/task_repository.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:maids/domain/usecases/update_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../generated_test_dependency_test.mocks.dart';


@GenerateMocks([TaskRepository])
void main() {

  late MockTaskRepository mockTaskRepository ;
  late UpdateTaskUseCase updateTaskUseCase ;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    updateTaskUseCase = UpdateTaskUseCase(mockTaskRepository);
  });

  final taskModel = TaskModel(todo:"Todo example", id: 1);
  final basicResponse = BasicResponse(todo: "Todo example", id: 1);

  test(
    'should get baseResponse from the TaskRepository after update task',
        () async {
      // arrange
      when(mockTaskRepository.updateTask(taskModel: taskModel))
          .thenAnswer((_) async => basicResponse);
      // act
      final result = await updateTaskUseCase.call(taskModel: taskModel);
      // assert
      expect(result, basicResponse);
      verify(mockTaskRepository.updateTask(taskModel: taskModel));
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );
}
