import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/pages/home_page.dart';
import 'package:trainig_project_aug2025/helpers/animation_helpers.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';
import 'package:trainig_project_aug2025/models/todo.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/widgets/app_widgets.dart';

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
            AppPaddedTextField(
              controller: txtName,
              hint: 'Name',
              padding: padding,
            ),
            AppPaddedTextField(
              controller: txtDescription,
              hint: 'Description',
              padding: padding,
              maxLines: 3,
            ),
            AppPaddedTextField(
              controller: txtCompleteBy,
              hint: 'Complete by',
              padding: padding,
            ),
            AppPaddedTextField(
              controller: txtPriority,
              hint: 'Priority',
              padding: padding,
              keyboardType: TextInputType.number,
            ),
            AppPadded(
              all: padding,
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

class AppPadded extends StatelessWidget {
  final Widget child;
  final double all;
  final EdgeInsets? padding;

  const AppPadded({super.key, required this.child, this.all = 20.0, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(all),
      child: child,
    );
  }
}
