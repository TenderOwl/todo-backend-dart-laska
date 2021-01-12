import 'dart:io';

/// Class to store Todo data. Simple yet enough.
class Todo {
  int id;
  String title;
  int order;
  bool completed;
  String url;

  Todo({this.id, this.title, this.order, this.url, this.completed = false});

  /// Generate JSON data from the `Todo` object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': title,
      'completed': completed,
      'order': order,
      'url': url
    };
  }

  /// Create new `Todo` object from the given `json`.
  Todo.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        completed = json['completed'] ?? false,
        order = json['order'],
        url = json['url'];
}

/// Custom response class.
/// It is a simple class with `toJson()` method
/// which returns required JSON structure.
class APIResponse {
  dynamic data;
  dynamic status;
  int code;

  APIResponse({this.data, this.status = 'ok', this.code = HttpStatus.ok});

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'status': status,
      'code': code,
    };
  }
}
