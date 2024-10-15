import 'package:crud_get/core/api_constants.dart';
import 'package:crud_get/data/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskRemoteDataSource {
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(Uri.parse(ApiConstants.baseUrl + ApiConstants.todosEndpoint));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['todos'];
      return data.map((task) => Task.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<Task> addTask(Task task) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.todosEndpoint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode == 200) {
      return Task.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add task');
    }
  }

  Future<void> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todosEndpoint}/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.todosEndpoint}/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
