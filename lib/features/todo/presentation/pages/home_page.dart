import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/blocs/theme_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/app_colors.dart';
import 'package:trainig_project_aug2025/core/constants/size_constants.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/core/constants/theme_constants.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/widgets/app_widgets.dart';
import 'package:trainig_project_aug2025/helpers/animation_helpers.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';
import 'package:trainig_project_aug2025/models/todo.dart';
import '../widgets/todo_item.dart';
import '../widgets/animated_theme_toggle.dart';
import '../pages/todo_details.dart';

class HomePage extends StatefulWidget {
  final ThemeBloc? themeBloc;

  const HomePage({super.key, this.themeBloc});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TodoBloc? todoBloc;
  ThemeBloc? themeBloc;
  List<Todo>? todos;

  @override
  void initState() {
    todoBloc = TodoBloc();
    // Use passed themeBloc or create new one
    themeBloc = widget.themeBloc ?? ThemeBloc();
    todoBloc!.getTodos();
    super.initState();
  }

  @override
  void dispose() {
    todoBloc?.dispose();
    // Only dispose if we created the themeBloc (not passed from parent)
    if (widget.themeBloc == null) {
      themeBloc?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Todo todo = Todo('', '', '', 0);
    todos = todoBloc?.todoList;
    return Scaffold(
      appBar: AppBar(
        title: Text(TextConstants.appTitle),
        actions: [
          if (themeBloc != null)
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: AnimatedThemeToggle(themeBloc: themeBloc!),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AnimationHelpers().animatedFAB(
        child: Icon(Icons.add),
        onPressed: () {
          AnimationHelpers.navigateWithAnimation(
            context: context,
            page: TodoDetails(todo, true),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(top: SizeConstants.paddingM),
        child: StreamBuilder<List<Todo>>(
          stream: todoBloc?.todos,
          initialData: todoBloc?.todoList ?? [],
          builder: (context, snapshot) {
            final todos = snapshot.data;
            // 1️⃣ حالة الشيمر (Loading)
            if (todos == null) {
              return AnimationHelpers.shimmerTodoList(
                itemCount: 5,
              ); // عدد افتراضي
            }
            // 2️⃣ حالة القائمة فارغة
            if (todos.isEmpty) {
              final isDark = Theme.of(context).brightness == Brightness.dark;
              return Center(
                child: Text(
                  TextConstants.emptyTasks,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ThemeConstants.getEmptyStateTextColor(isDark),
                  ),
                ),
              );
            }
            // 3️⃣ حالة وجود عناصر
            return RefreshIndicator(
              onRefresh: () async {
                await todoBloc!.refreshTodos();
              },
              color: AppColors.primary,
              backgroundColor: AppColors.surface,
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  if (newIndex > oldIndex) newIndex -= 1;
                  final item = todos.removeAt(oldIndex);
                  todos.insert(newIndex, item);
                  // إرسال القائمة الجديدة للـ BLoC لحفظ الترتيب
                  todoBloc!.todoUpdateOrderSink.add(todos);
                },
                children: [
                  for (int index = 0; index < todos.length; index++)
                    AppWidgets.dismissibleWrapper(
                      key: Key(todos[index].id.toString()),
                      context: context,
                      onDelete: () {
                        todoBloc!.todoDeleteSink.add(todos[index]);
                        if (context.mounted) {
                          HelperMethods.showSuccess(
                            context,
                            TextConstants.deleteSuccess,
                          );
                        }
                      },
                      child: AnimationHelpers.animatedTodoItem(
                        index: index,
                        child: TodoItem(
                          index: index,
                          todo: todos[index],
                          bloc: todoBloc!,
                          parentContext: context,
                          onEdit: () => AnimationHelpers.navigateWithAnimation(
                            context: context,
                            page: TodoDetails(todos[index], false),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
