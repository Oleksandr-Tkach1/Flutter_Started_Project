import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';
import 'package:bounty_hub_client/data/models/api/response/user_tasks_response.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/models/entity/user_task/user_task.dart';

abstract class TaskDataSource {

  Future<UserTasksResponse> getUserTasks(String userId, int page);

  Future<TasksResponse> getTasks(String userId, int page);

  Future<Task> getTask(String taskId);

  Future<UserTask> getUserTask(String userId, String taskId);

  Future<UserTask> takeTask(String userId, String taskId);
}