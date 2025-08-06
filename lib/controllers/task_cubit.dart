import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/models/task_model.dart';
import 'package:uuid/uuid.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  addTask(String title) {
    TaskModel model = TaskModel(
      id: Uuid().v4(),
      title: title,
      isCompleted: false,
    );
    emit(TaskUpdate([...state.TaskList, model]));
  }

  removeTask(String id) {
    final List<TaskModel> newList = state.TaskList.where(
      (task) => task.id != id,
    ).toList();
    emit(TaskUpdate(newList));
  }

  toggleTask(String id) {
    final List<TaskModel> newList = state.TaskList.map((task) {
      return task.id == id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();
    emit(TaskUpdate(newList));
  }
}
