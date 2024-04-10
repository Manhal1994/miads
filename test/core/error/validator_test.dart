import 'package:flutter_test/flutter_test.dart';
import 'package:maids/core/error/validator.dart';

void main(){
  late AuthValidator authValidator;
  late AddTaskValidator addTaskValidator;

// AuthValidator

  test(
    'should return true',
        () async {
     const pass = "ghjh6777";
     const userName = "dgbhdhgdh";

     authValidator = AuthValidator(pass: pass, userName: userName);
     // act
      final result =  authValidator.validate();
      // assert
      expect(result,true);
    },
  );

  test(
    'should return false',
        () async {
      const pass = "123";
      const userName = "dgbhdhgdh";

      authValidator = AuthValidator(pass: pass, userName: userName);
      // act
      final result =  authValidator.validate();
      // assert
      expect(result,false);
    },
  );

  test(
    'should return false',
        () async {
      const pass = "ghghh";
      const userName = "fgf";

      authValidator = AuthValidator(pass: pass, userName: userName);
      // act
      final result =  authValidator.validate();
      // assert
      expect(result,false);
    },
  );

  // addTaskValidator
  test(
    'should return true',
        () async {
      const todo = "ghjh6777";

      addTaskValidator = AddTaskValidator(todo: todo);

      // act
      final result = addTaskValidator.validate();
      // assert
      expect(result,true);
    },
  );

  test(
    'should return false',
        () async {
          const todo = "gh";
          addTaskValidator = AddTaskValidator(todo: todo);

      // act
      final result =  addTaskValidator.validate();
      // assert
      expect(result,false);
    },
  );
}