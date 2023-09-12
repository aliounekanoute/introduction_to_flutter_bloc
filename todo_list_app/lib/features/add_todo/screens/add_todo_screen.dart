

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_app/data/controllers/add_todo_controller.dart';
import 'package:todo_list_app/data/models/todo.dart';
import 'package:todo_list_app/features/add_todo/add_todo_bloc/add_todo_bloc.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  late AddTodoController addTodoController;
  late GlobalKey<FormState> formKey;

  @override
  void initState() {
    BlocProvider.of<AddTodoBloc>(context).add(AddTodoInitialEvent());
    addTodoController = AddTodoController();
    formKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une tache'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 0.8,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<AddTodoBloc, AddTodoState>(
                builder: (context, state) {
                  if (state is AddTodoErrorState) {
                    return messageText(message: state.message, type: 'error');
                  } else if(state is AddTodoSuccessState) {
                    return messageText(message: 'Tâche ajouté', type: 'success');
                  }

                  return Container();
                },
              ),
              const SizedBox(height: 12,),
              formField(controller: addTodoController.title, hintText: 'Titre'),
              const SizedBox(height: 12,),
              formField(controller: addTodoController.content, hintText: 'Contenu'),
              const SizedBox(height: 12,),
              ElevatedButton(
                onPressed: () {
                  if(isFormValid()) {
                    Todo todo = Todo(
                      title: addTodoController.title.value.text, 
                      content: addTodoController.content.value.text
                    );
                    BlocProvider.of<AddTodoBloc>(context).add(AddTodoButtonPressed(todo: todo));
                  }
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  fixedSize: Size(
                    MediaQuery.of(context).size.width, 
                    30
                  )
                ),
                child: const Text('Ajouter', style: TextStyle(
                  color: Colors.white
                ),)
              ),
            ],
          )
        ),
      ),
    );
  }

  TextFormField formField({
  required TextEditingController controller, 
  required String hintText,
  bool isRequired = true,
  }) => TextFormField(
    controller: controller,
    keyboardType: TextInputType.text,
    cursorColor: Colors.black,
    validator: (value) {
        if (isRequired) {
          if (value == null || value.isEmpty) {
            return 'Ce champ est obligatoire.';
          }
        }
        return null;
      },

    decoration: InputDecoration(
      hintText: hintText
    ),
  );

  bool isFormValid() => addTodoController.title.text.isNotEmpty && addTodoController.content.text.isNotEmpty;

  Center messageText({
    required String message,
    required String type,
  }) => Center(
    child: Text(
      message,
      style: TextStyle(
        color: type == 'success' ? Colors.green.shade700 : Colors.red.shade700,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      ),
    ),
  );

}


