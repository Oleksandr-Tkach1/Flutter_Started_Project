import 'package:bounty_hub_client/data/models/api/response/tasks_response.dart';
import 'package:bounty_hub_client/data/source/task_data_source.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class TaskRepository extends TaskDataSource {

  final RestClient client;

  TaskRepository(this.client);

  @override
  Future<TasksResponse> getTasks(int page) {
    return client.getTasks(page, 10, 'APPROVED', 'rewardAmount,desc', true, 'PUBLIC');
  }
}