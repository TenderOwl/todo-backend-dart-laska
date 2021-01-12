import 'dart:io';

import 'package:laska/laska.dart';
import 'package:todo_backend/repository.dart';

import 'models.dart';

var todoRepository = TodoRepository();

/// Returns all todos from the `TodoRepository`
void getAllTodos(Context context) async {
  final todos = todoRepository.getAll();
  await context.JSON(APIResponse(data: todos));
}

/// Deletes all todos from the `TodoRepository`
void deleteAllTodos(Context context) async {
  todoRepository.deleteAll();
  await context.JSON(APIResponse(code: HttpStatus.noContent),
      statusCode: HttpStatus.noContent);
}

/// Creates new `Todo` object and saves it to the `TodoRepository`
void createTodo(Context context) async {
  final httpBody = await context.body;

  // 7. Simple check for a content type
  if (httpBody.type != 'json') {
    return await context.JSON(
        APIResponse(
            status: 'Unsupported Media Type',
            code: HttpStatus.unsupportedMediaType),
        statusCode: HttpStatus.unsupportedMediaType);
  }
  var todo = Todo.fromJson(httpBody.body);
  todo = todoRepository.create(todo);
  await context.JSON(
      APIResponse(data: todo, status: 'created', code: HttpStatus.created),
      statusCode: HttpStatus.created);
}

/// Returns `Todo` from the `TodoRepository` by given `todoId`.
/// If no todo found it returns 404.
void getTodo(Context context) async {
  var todoId = getTodoId(context);
  final todo = todoRepository.get(todoId);
  if (todo == null) {
    return await sendNotFound(context);
  }
  return await context.JSON(APIResponse(data: todo));
}

/// Deletes `Todo` from the `TodoRepository` by given `todoId`.
/// If no todo found it returns 404.
void deleteTodo(Context context) async {
  var todoId = getTodoId(context);

  if (todoRepository.get(todoId) == null) {
    return await sendNotFound(context);
  }

  todoRepository.delete(todoId);
  await context.JSON(APIResponse(code: HttpStatus.noContent),
      statusCode: HttpStatus.noContent);
}

/// Updates `Todo` from the `TodoRepository` by given `todoId`.
/// If no todo found it returns 404.
void updateTodo(Context context) async {
  var todoId = getTodoId(context);

  if (todoRepository.get(todoId) == null) {
    return await sendNotFound(context);
  }

  final httpBody = await context.body;

  if (httpBody.type != 'json') {
    return await context.JSON(
        APIResponse(
            status: 'Unsupported Media Type',
            code: HttpStatus.unsupportedMediaType),
        statusCode: HttpStatus.unsupportedMediaType);
  }
  var newTodo = Todo.fromJson(httpBody.body);
  newTodo.id = todoId;

  todoRepository.update(newTodo);
  return context.JSON(APIResponse(data: newTodo));
}

/// Helper method to get `int` todoId from request params
int getTodoId(Context context) {
  return int.parse(context.param('todoId'));
}

/// Helper function to send NotFound response.
void sendNotFound(Context context) async {
  await context.JSON(
      APIResponse(status: 'not found', code: HttpStatus.notFound),
      statusCode: HttpStatus.notFound);
}
