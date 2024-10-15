import 'package:crud_get/presentation/controllers/task_controller.dart';
import 'package:crud_get/presentation/pages/task_form_page.dart';
import 'package:crud_get/presentation/widgets/task_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final TaskController controller = Get.find<TaskController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Obx(() {
            return DropdownButton<TaskFilter>(
              value: controller.currentFilter.value,
              icon: const Icon(Icons.filter_list, color: Colors.black),
              items: const [
                DropdownMenuItem(
                  value: TaskFilter.all,
                  child: Text('All Tasks'),
                ),
                DropdownMenuItem(
                  value: TaskFilter.completed,
                  child: Text('Completed Tasks'),
                ),
                DropdownMenuItem(
                  value: TaskFilter.incomplete,
                  child: Text('Incomplete Tasks'),
                ),
              ],
              onChanged: (TaskFilter? newFilter) {
                if (newFilter != null) {
                  controller.setTaskFilter(newFilter);
                }
              },
            );
          })
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.filteredTasks.isEmpty) {
          return const Center(
            child: Text(
              'No tasks available for the selected filter.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 64),
          itemCount: controller.filteredTasks.length,
          itemBuilder: (context, index) {
            final task = controller.filteredTasks[index];
            return TaskItem(task: task);
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => TaskFormPage());
        },
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
