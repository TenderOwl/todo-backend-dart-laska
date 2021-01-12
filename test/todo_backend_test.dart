import 'package:test/test.dart';
import 'package:todo_backend/models.dart';
import 'package:todo_backend/repository.dart';

void main() {
  TodoRepository repo;
  setUp(() {
    repo = TodoRepository();
    repo.create(Todo(title: 'todo 1'));
    repo.create(Todo(title: 'todo 2', completed: true));
  });

  test('getAll todos', () {
    expect(repo.getAll().length, 2);
  });

  test('delete todo with id = 2', () {
    repo.delete(2);
    final todos = repo.getAll();
    expect(todos.length, 1);
    expect(todos[0].id, 1);
  });

  test('create todo', () {
    repo.create(Todo(title: 'todo 3'));
    final todo = repo.get(3);
    expect(todo.title, 'todo 3');
    expect(todo.id, 3);
  });

  test('get todo with id = 2', () {
    final todo = repo.get(2);
    expect(todo.title, 'todo 2');
    expect(todo.id, 2);
    expect(todo.completed, true);
  });

  test('update todo with id = 3', () {
    expect(repo.get(2).title, 'todo 2');
    repo.update(Todo(id: 2, title: 'todo 3/4', completed: true));
    expect(repo.get(2).title, 'todo 3/4');
  });

  test('delete all todos', () {
    expect(repo.getAll().length, 2);
    repo.deleteAll();
    expect(repo.getAll().length, 0);
  });

  test('get todo with invalid id', () {
    final todo = repo.get(3);
    expect(todo, null);
  });

  test('delete todo with invalid id', () {
    repo.delete(3);
  });

  test('update todo with invalid id', () {
    final todo = repo.update(Todo(id: 3, title: 'todo 3/4'));
    expect(todo, null);
  });
}
