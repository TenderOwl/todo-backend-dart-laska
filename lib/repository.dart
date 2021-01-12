import 'models.dart';

/// Basic repository class uses as in-memory storage.
class TodoRepository {
  List<Todo> todos = [];
  int nextId = 1;

  /// Returns `Todo` by its `todoId` from the storage.
  Todo get(int todoId) =>
      todos.firstWhere((element) => element.id == todoId, orElse: () => null);

  /// Returns list of `Todo` objects from the storage.
  List<Todo> getAll() => todos;

  /// Puts new `Todo` into the storage.
  Todo create(Todo todo) {
    todo.id = nextId;
    todos.add(todo);
    nextId++;
    return todo;
  }

  /// Deletes `Todo` object by its `todoId` from the storage.
  void delete(int todoId) {
    todos.removeWhere((element) => element.id == todoId);
  }

  /// Deletes all of the `Todo` objects from the storage.
  void deleteAll() {
    todos = [];
  }

  /// Update `Todo` object by its `todoId`.
  /// Returns `null` if no `Todo` found with given `todoId`.
  Todo update(Todo todo) {
    final index = todos.indexWhere((element) => element.id == todo.id);
    if (index == -1) return null;
    todos[index] = todo;
    return todo;
  }
}
