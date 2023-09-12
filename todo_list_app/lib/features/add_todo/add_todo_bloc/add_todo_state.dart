part of 'add_todo_bloc.dart';

abstract class AddTodoState extends Equatable {
  const AddTodoState();
  
  @override
  List<Object> get props => [];
}

final class AddTodoInitialState extends AddTodoState {}

class LoadingAddTodoState extends AddTodoState {}

class AddTodoSuccessState extends AddTodoState {}

class AddTodoErrorState extends AddTodoState {
  final String message;
  const AddTodoErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
