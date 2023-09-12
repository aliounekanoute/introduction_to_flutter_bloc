import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/data/models/todo.dart';
import 'package:todo_list_app/data/services/database_service.dart';
import 'package:todo_list_app/features/add_todo/add_todo_bloc/add_todo_bloc.dart';

part 'list_todo_event.dart';
part 'list_todo_state.dart';

class ListTodoBloc extends Bloc<ListTodoEvent, ListTodoState> {
  final DatabaseService databaseService = DatabaseService.instance;
  final AddTodoBloc addTodoBloc;
  late StreamSubscription streamSubscription;

  ListTodoBloc({required this.addTodoBloc}) : super(ListTodoInitialState()) {
    on<ListTodoEvent>((event, emit) async {
      monitorAddToDo();
      
      if(event is FetchListTodoEvent) {
        
        emit(LoadingListTodosState());
        
        try {
          List<Todo> todos = await databaseService.getTodos();
          emit(ListTodosSuccesState(todos: todos));
        } catch (e) {
          emit(const ListTodosErrorState(message: 'Une erreur est survenue'));
        }
      }
    });
  }

  void monitorAddToDo() {
    streamSubscription = addTodoBloc.stream.listen((state) async {
      if(state is AddTodoSuccessState) {
        emit(LoadingListTodosState());
        List<Todo> todos = await databaseService.getTodos();
        emit(ListTodosSuccesState(todos: todos));
      }
    });
  }

  @override
  Future<void> close() {
    streamSubscription.cancel();
    return super.close();
  }

}
