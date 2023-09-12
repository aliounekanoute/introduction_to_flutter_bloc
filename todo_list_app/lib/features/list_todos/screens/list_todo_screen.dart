
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/data/models/todo.dart';
import 'package:todo_list_app/features/add_todo/screens/add_todo_screen.dart';
import 'package:todo_list_app/features/list_todos/list_bloc/list_todo_bloc.dart';
import 'package:todo_list_app/widgets/custom_loader.dart';

class ListTodoScreen extends StatefulWidget {
  const ListTodoScreen({super.key});

  @override
  State<ListTodoScreen> createState() => _ListTodoScreenState();
}

class _ListTodoScreenState extends State<ListTodoScreen> {

  @override
  void initState() {
    BlocProvider.of<ListTodoBloc>(context).add(FetchListTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoApp'),
        centerTitle: true,
        elevation: 2,
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => const AddTodoScreen(),
            )
          );
        }, 
        icon: const Icon(
          Icons.add,
        )
      ),
      body: BlocBuilder<ListTodoBloc, ListTodoState>(
        builder: (context, state) {
          if(state is ListTodosSuccesState) {
            final List<Todo> todos = state.todos;
            return todos.isEmpty ? 
              const Center(child: Text('Pas de tache'),) : 
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 12
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: todos.asMap().entries.map((e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.value.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      Text(
                        e.value.content,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14
                        ),
                      ),
                      if(e.key != todos.length - 1) const Divider(
                        color: Colors.grey,
                      )
                    ],
                  )).toList()
                ),
              );
          } else if (state is ListTodosErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return const CustomLoader();
          }
        },
      ),
    );
  }
}
