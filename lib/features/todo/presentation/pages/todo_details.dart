import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/pages/home_page.dart';
import 'package:trainig_project_aug2025/helpers/animation_helpers.dart';
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
  
  Widget _paddedTextField({
    required TextEditingController controller,
    required String hint,
    required double padding,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
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
            _paddedTextField(
              controller: txtName,
              hint: 'Name',
              padding: padding,
            ),
            _paddedTextField(
              controller: txtDescription,
              hint: 'Description',
              padding: padding,
            ),
            _paddedTextField(
              controller: txtCompleteBy,
              hint: 'Complete by',
              padding: padding,
            ),
            _paddedTextField(
              controller: txtPriority,
              hint: 'Priority',
              padding: padding,
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.all(padding),
              child: AnimationHelpers().animatedSaveButton(
                child: Text('Save'),
                onPressed: () async {
                  // ✅ استدعاء الفحص
                  var errorMessage = HelperMethods.validateTaskFields(
                    name: txtName.text.trim(),
                    description: txtDescription.text.trim(),
                    completeBy: txtCompleteBy.text.trim(),
                    priority: txtPriority.text.trim(),
                  );
                  if (errorMessage != null) {
                    HelperMethods.showError(context, errorMessage);
                    return;
                  }
                  // ✅ لو الفحص مرّ، نكمل الحفظ
                  await HelperMethods.saveTodo(
                    bloc: bloc,
                    todo: Todo(
                      txtName.text.trim(),
                      txtDescription.text.trim(),
                      txtCompleteBy.text.trim(),
                      int.tryParse(txtPriority.text.trim())!,
                    )..id = todo.id,
                    isNew: isNew,
                    context: context,
                  );

                  // ✅ نرجع للهوم
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(key: super.key),
                    ),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
