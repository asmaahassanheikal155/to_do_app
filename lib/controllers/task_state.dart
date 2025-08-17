part of 'task_cubit.dart';

@immutable
sealed class TaskState extends Equatable {
  final List<TaskModel> TaskList;
  TaskState(this.TaskList);
  @override
  List<Object?> get props => [TaskList];
}

final class TaskInitial extends TaskState {
  TaskInitial() : super([]);
}

final class TaskUpdate extends TaskState {
  TaskUpdate(super.TaskList);
}
