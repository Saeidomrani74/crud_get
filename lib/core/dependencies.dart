import 'package:crud_get/data/data_sources/task_remote_data_source.dart';
import 'package:crud_get/domain/repositories/task_repository_impl.dart';
import 'package:crud_get/presentation/controllers/task_controller.dart';
import 'package:get/get.dart';

class Dependencies {
  static void init() {
    Get.lazyPut(() => TaskRemoteDataSource());
    Get.lazyPut(() => TaskRepositoryImpl(remoteDataSource: Get.find<TaskRemoteDataSource>()));
    Get.lazyPut(() => TaskController(repository: Get.find<TaskRepositoryImpl>()));
  }
}
