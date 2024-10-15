import 'package:crud_get/core/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crud_get/presentation/controllers/task_controller.dart';
import 'package:crud_get/data/data_sources/task_remote_data_source.dart';
import 'package:crud_get/domain/repositories/task_repository_impl.dart';
import 'presentation/pages/home_page.dart';

void main() {
  Dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => TaskController(
            repository: TaskRepositoryImpl(
                remoteDataSource: TaskRemoteDataSource())));
      }),
      home: HomePage(),
    );
  }
}
