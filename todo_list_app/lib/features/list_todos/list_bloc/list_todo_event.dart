part of 'list_todo_bloc.dart';


abstract class ListTodoEvent extends Equatable {
  const ListTodoEvent();

  @override
  List<Object> get props => [];

}

class FetchListTodoEvent extends ListTodoEvent {}
