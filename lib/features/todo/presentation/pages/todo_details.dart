import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/size_constants.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/pages/home_page.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/widgets/app_widgets.dart';
import 'package:trainig_project_aug2025/helpers/animation_helpers.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';
import 'package:trainig_project_aug2025/models/todo.dart';

class TodoDetails extends StatefulWidget {
  final Todo todo;
  final bool isNew;

  const TodoDetails(this.todo, this.isNew, {super.key});

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtCompleteBy = TextEditingController();
  final TextEditingController txtPriority = TextEditingController();

  // Date controllers
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  DateTime? selectedReminderDate;

  final TodoBloc bloc = TodoBloc();
  @override
  void initState() {
    super.initState();
    txtName.text = widget.todo.name;
    txtDescription.text = widget.todo.description;
    txtCompleteBy.text = widget.todo.completeBy;
    txtPriority.text = widget.todo.priority.toString();

    // Initialize date fields
    selectedStartDate = widget.todo.startDate;
    selectedEndDate = widget.todo.endDate;
    selectedReminderDate = widget.todo.reminderDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo Details')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            AppWidgets.customTextField(
              controller: txtName,
              hintText: TextConstants.nameLabel,
              padding: SizeConstants.paddingXL,
            ),
            AppWidgets.customTextField(
              controller: txtDescription,
              hintText: TextConstants.descriptionLabel,
              padding: SizeConstants.paddingXL,
            ),
            AppWidgets.customTextField(
              controller: txtCompleteBy,
              hintText: TextConstants.completeByLabel,
              padding: SizeConstants.paddingXL,
            ),
            AppWidgets.customTextField(
              controller: txtPriority,
              hintText: TextConstants.priorityLabel,
              padding: SizeConstants.paddingXL,
              keyboardType: TextInputType.number,
            ),

            // Date picker widgets
            AppWidgets.customDatePicker(
              label: TextConstants.startDateLabel,
              selectedDate: selectedStartDate,
              onDateSelected: (date) =>
                  setState(() => selectedStartDate = date),
              state: this,
            ),

            AppWidgets.customDatePicker(
              label: TextConstants.endDateLabel,
              selectedDate: selectedEndDate,
              onDateSelected: (date) => setState(() => selectedEndDate = date),
              state: this,
            ),

            AppWidgets.customDatePicker(
              label: TextConstants.reminderDateLabel,
              selectedDate: selectedReminderDate,
              onDateSelected: (date) =>
                  setState(() => selectedReminderDate = date),
              state: this,
            ),

            Padding(
              padding: EdgeInsets.all(SizeConstants.paddingXL),
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
                      startDate: selectedStartDate,
                      endDate: selectedEndDate,
                      reminderDate: selectedReminderDate,
                    )..id = widget.todo.id,
                    isNew: widget.isNew,
                    context: context,
                  );

                  // ✅ نرجع للهوم
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
                  } else {
                    // Handle unmounted case - show success message and stay on current screen
                    if (context.mounted) {
                      HelperMethods.showError(
                        context,
                        TextConstants.saveSuccessNavigationError,
                      );
                    }
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
