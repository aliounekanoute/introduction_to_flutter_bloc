part of 'add_todo_bloc.dart';

abstract class AddTodoEvent extends Equatable {
  const AddTodoEvent();

  @override
  List<Object> get props => [];
}

class AddTodoInitialEvent extends AddTodoEvent {}

class AddTodoButtonPressed extends AddTodoEvent {
  final Todo todo;

  const AddTodoButtonPressed({required this.todo});

  @override
  List<Object> get props => [todo];
}
