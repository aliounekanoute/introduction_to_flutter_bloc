import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/data/models/todo.dart';
import 'package:todo_list_app/data/services/database_service.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final DatabaseService databaseService = DatabaseService.instance;
  
  AddTodoBloc() : super(AddTodoInitialState()) {
    on<AddTodoEvent>((event, emit) async {

      if(event is AddTodoInitialEvent) {
        emit(AddTodoInitialState());
      }
      
      if(event is AddTodoButtonPressed) {
        try {
          Todo todo = event.todo;

          await databaseService.insertTodo(todo);
          emit(AddTodoSuccessState());
        } catch (e) {
          emit(const AddTodoErrorState(message: 'Une erreur est surveneue'));
        }
      }
    });
  }
}
