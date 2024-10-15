import 'package:crud_get/data/models/task_model.dart';
import 'package:crud_get/domain/repositories/task_repository_impl.dart';
import 'package:get/get.dart';

enum TaskFilter {
  all,
  completed,
  incomplete,
}

class TaskController extends GetxController {
  final TaskRepositoryImpl repository;
  var tasks = <Task>[].obs;
  var isLoading = false.obs;

  var currentFilter = TaskFilter.all.obs;

  TaskController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    try {

      isLoading(true);
      tasks.value = await repository.getTasks();

    } finally {

      isLoading(false);

    }
  }

  void addTask({required String title, required bool isCompleted}) {

    final newTask = Task(
      id: tasks.length + 1,
      title: title,
      completed: isCompleted,
    );

    tasks.add(newTask);
    repository.addTask(newTask);

  }

  void toggleTaskCompletion(Task task) {

    task.completed = !task.completed;
    tasks.refresh();
    repository.updateTask(task);

  }

  void deleteTask(Task task) {

    tasks.remove(task);
    repository.deleteTask(task.id);

  }

  List<Task> get filteredTasks {

    switch (currentFilter.value) {

      case TaskFilter.completed:
        return tasks.where((task) => task.completed).toList();

      case TaskFilter.incomplete:
        return tasks.where((task) => !task.completed).toList();

      case TaskFilter.all:

      default:
        return tasks;

    }
  }

  void setTaskFilter(TaskFilter filter) {

    currentFilter.value = filter;
  }
}
