import 'package:flutter_test/flutter_test.dart';
import 'package:maids/data/remote/dto/basic_response.dart';
import 'package:maids/domain/usecases/create_task_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../generated_test_dependency_test.mocks.dart';


void main() {

  late MockTaskRepository mockTaskRepository ;
  late CreateTaskUseCase createTaskUseCase = CreateTaskUseCase(mockTaskRepository);

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    createTaskUseCase = CreateTaskUseCase(mockTaskRepository);
  });

  const todo = "Todo example";
  final basicResponse = BasicResponse(todo: todo, id: 1);

  test(
    'should get baseResponse from the TaskRepository',
    () async {
      // arrange
      when(mockTaskRepository.createTask(todo: "Todo example"))
          .thenAnswer((_) async => basicResponse);
      // act
      final result = await createTaskUseCase.call(todo: "Todo example");
      // assert
      expect(result, basicResponse);
      verify(mockTaskRepository.createTask(todo: todo));
      verifyNoMoreInteractions(mockTaskRepository);
    },
  );
}
