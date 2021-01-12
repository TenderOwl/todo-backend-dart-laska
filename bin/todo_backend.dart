import 'dart:io';

import 'package:laska/laska.dart';
import 'package:todo_backend/handlers.dart';

void main(List<String> arguments) async {
  final app = Laska();

  app.GET('/todos', getAllTodos);
  app.POST('/todos', createTodo);
  app.DELETE('/todos', deleteAllTodos);

  app.GET('/todos/:todoId', getTodo);
  app.PATCH('/todos/:todoId', updateTodo);
  app.DELETE('/todos/:todoId', deleteTodo);

  await app.run();

  // Catch Ctrl+C
  ProcessSignal.sigint.watch().listen((signal) {
    // Finalize app, save db, etc.
    print('\nGood bye!');
    exit(0);
  });
}
