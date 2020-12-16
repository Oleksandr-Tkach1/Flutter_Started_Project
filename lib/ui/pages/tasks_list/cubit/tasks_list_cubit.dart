import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/models/entity/task/task.dart';
import 'package:bounty_hub_client/data/repositories/tasks_repository.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/ui/pages/tasks_list/cubit/tasks_list_state.dart';
import 'package:logger/logger.dart';

class TasksListCubit extends Cubit<TasksListState> {

  final log = Logger();
  final TaskRepository _taskRepository;
  final UserRepository _userRepository;
  int page = 1;
  bool fetching = false;

  TasksListCubit(this._taskRepository, this._userRepository) : super(TasksListState());

  void refresh() {
    page = 1;
    fetching = false;

    emit(state.copyWith(
      status: TasksListStatus.initial,
      tasks: <Task>[],
      hasReachedMax: false,
    ));
  }

  void fetchTasks() async {
    if (state.hasReachedMax) {
      emit(state);
      return;
    }

    String userId = await _userRepository.getUserId();
    if (state.status == TasksListStatus.initial && !fetching) {
      final tasks = await _fetchTasks(userId, 0);
      emit(state.copyWith(
        status: TasksListStatus.success,
        tasks: tasks,
        hasReachedMax: false,
      ));
      return;
    }

    if(fetching) return;
    final tasks = await _fetchTasks(userId, page);
    if(tasks == null || tasks.isEmpty) {
      emit(state.copyWith(hasReachedMax: true));
    } else {
      emit(state.copyWith(
        status: TasksListStatus.success,
        tasks: List.of(state.tasks)..addAll(tasks),
        hasReachedMax: false,
      ));
      page++;
    }
  }

  Future<List<Task>> _fetchTasks(String userId, int page) async {
    fetching = true;
    return _taskRepository.getTasks(userId, page)
        .then((value) => value.content)
        .whenComplete(() => fetching = false)
        .catchError((Object obj) {
          log.e(obj);
          fetching = false;
          emit(state.copyWith(status: TasksListStatus.failure));
        });
  }
}