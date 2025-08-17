import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/controllers/task_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _UiState();
}

class _UiState extends State<Home> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => TaskCubit(),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFB3E5FC), // أزرق فاتح
                        Colors.white, // أبيض
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80, right: 10, left: 20),
                  child: Column(
                    children: [
                      TextField(
                        cursorColor: Colors.white,
                        controller: controller,
                        decoration: const InputDecoration(
                          labelText: 'Enter a Task',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          filled: true,

                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            context.read<TaskCubit>().addTask(controller.text);
                            controller.clear();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4BA9F7),
                          foregroundColor: Colors.blueGrey,
                        ),
                        child: const Text(
                          'Add Task',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.TaskList.length,
                          itemBuilder: (context, index) {
                            final task = state.TaskList[index];
                            return ListTile(
                              leading: Checkbox(
                                hoverColor: Colors.grey,
                                activeColor: Colors.green,
                                value: task.isCompleted,
                                onChanged: (_) {
                                  context.read<TaskCubit>().toggleTask(task.id);
                                },
                              ),
                              title: Text(
                                task.title,
                                style: TextStyle(
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),
                              trailing: IconButton(
                                color: Colors.redAccent,
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  context.read<TaskCubit>().removeTask(task.id);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
