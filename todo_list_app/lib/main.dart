import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/features/add_todo/add_todo_bloc/add_todo_bloc.dart';
import 'package:todo_list_app/features/list_todos/list_bloc/list_todo_bloc.dart';
import 'package:todo_list_app/features/list_todos/screens/list_todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AddTodoBloc addTodoBloc = AddTodoBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<ListTodoBloc>(
          create: (context) => ListTodoBloc(addTodoBloc: addTodoBloc),
        ),
        BlocProvider<AddTodoBloc>(
          create: (context) => addTodoBloc,
        )
      ],
      child: MaterialApp(
        title: 'TodoApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          inputDecorationTheme: const InputDecorationTheme(
      
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.5,
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide(
                color: Colors.grey,
                width: 1.5,
              )
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey
              )
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 14
            )
          ),
    
        ),
        home: const ListTodoScreen(),
      ),
    );
  }
}
