import 'package:flutter_test/flutter_test.dart';
import 'package:maids/data/models/page_data.dart';
import 'package:maids/data/models/task.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/domain/repositories/task_repository.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:maids/domain/usecases/get_tasks_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../generated_test_dependency_test.mocks.dart';


void main() {

  late MockTaskRepository mockTaskRepository ;
  late GetTasksUseCases getTasksUseCases ;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getTasksUseCases = GetTasksUseCases(mockTaskRepository);
  });

  final taskModel = TaskModel(todo: "Todo example");
  final tasksPageData = PageData<TaskModel>(total: 1, skip: 0, limit: 1, items: [taskModel]);

  test(
    'should get List of [TaskModel] from the TaskRepository',
        () async {
      // arrange
      when(mockTaskRepository.getTasks(limit: 1, skip: 0))
          .thenAnswer((_) async =>tasksPageData);
      // act
      final result = await getTasksUseCases.call(limit: 1, skip: 0);
      // assert
      expect(result, tasksPageData);
      verify(mockTaskRepository.getTasks(limit: 1, skip: 0));
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );
}