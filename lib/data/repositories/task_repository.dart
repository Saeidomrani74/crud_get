import 'package:crud_get/data/models/task_model.dart';

abstract class TaskRepository {

  Future<List<Task>> getTasks();

  Future<Task> addTask(Task task);

  Future<void> updateTask(Task task);

  Future<void> deleteTask(int taskId);
}
