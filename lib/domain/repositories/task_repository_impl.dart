import 'package:crud_get/data/data_sources/task_remote_data_source.dart';
import 'package:crud_get/data/models/task_model.dart';
import 'package:crud_get/data/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository{

  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Task>> getTasks() => remoteDataSource.fetchTasks();

  @override
  Future<Task> addTask(Task task) => remoteDataSource.addTask(task);

  @override
  Future<void> updateTask(Task task) => remoteDataSource.updateTask(task);

  @override
  Future<void> deleteTask(int id) => remoteDataSource.deleteTask(id);
}
