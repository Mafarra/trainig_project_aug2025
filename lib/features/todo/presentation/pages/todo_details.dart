import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/pages/home_page.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';
import 'package:trainig_project_aug2025/models/todo.dart';

class TodoDetails extends StatelessWidget {
  final Todo todo;
  final bool isNew;
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtCompleteBy = TextEditingController();
  final TextEditingController txtPriority = TextEditingController();

  final TodoBloc bloc;
  TodoDetails(this.todo, this.isNew, {super.key}) : bloc = TodoBloc();
  @override
  Widget build(BuildContext context) {
    final double padding = 20.0;
    txtName.text = todo.name;
    txtDescription.text = todo.description;
    txtCompleteBy.text = todo.completeBy;
    txtPriority.text = todo.priority.toString();
    return Scaffold(
      appBar: AppBar(title: Text('Todo Details')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: txtName,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: txtDescription,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: txtCompleteBy,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Complete by',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: TextField(
                controller: txtPriority,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Priority',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: MaterialButton(
                color: Colors.green,
                child: Text('Save'),
                onPressed: () async {
                  // تحقق من القيم إذا كانت الحقول غير فارغة
                  if (!HelperMethods.areFieldsEmpty([
                        txtName,
                        txtDescription,
                        txtCompleteBy,
                        txtPriority,
                      ]) &&
                      HelperMethods.isInteger(txtPriority.text)) {
                    await HelperMethods.saveTodo(
                      bloc: bloc,
                      todo: Todo(
                        txtName.text,
                        txtDescription.text,
                        txtCompleteBy.text,
                        int.tryParse(txtPriority.text)!,
                      )..id = todo.id,
                      isNew: isNew,
                      context: context,
                    );
                    print("::::::::::saveTodo 1::::::::");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(key: super.key),
                      ),
                      (route) => false,
                    );
                  } else {
                    if (!HelperMethods.isInteger(txtPriority.text)) {
                      HelperMethods.showError(
                        context,
                        TextConstants.errorOccurredInvalidPriority,
                      );
                      return;
                    }
                    HelperMethods.showError(
                      context,
                      TextConstants.errorOccurredEmptyFields,
                    );
                    print("error occured empty fields 115");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
