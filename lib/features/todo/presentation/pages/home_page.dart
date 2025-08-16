import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/widgets/app_widgets.dart';
import 'package:trainig_project_aug2025/helpers/animation_helpers.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';
import 'package:trainig_project_aug2025/models/todo.dart';
import '../widgets/todo_item.dart';
import '../pages/todo_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TodoBloc? todoBloc;
  List<Todo>? todos;

  @override
  void initState() {
    todoBloc = TodoBloc();
    todoBloc!.getTodos();
    super.initState();
  }

  @override
  void dispose() {
    todoBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Todo todo = Todo('', '', '', 0);
    todos = todoBloc?.todoList;
    return Scaffold(
      appBar: AppBar(title: Text(TextConstants.appTitle)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TodoDetails(todo, true)),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
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
              return Center(
                child: Text(
                  TextConstants.emptyTasks,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              );
            }

            // 3️⃣ حالة وجود عناصر
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                // 3a️⃣ عنصر TodoItem
                final todoWidget = TodoItem(
                  todo: todo,
                  bloc: todoBloc!,
                  parentContext: context,
                  onEdit: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TodoDetails(todo, false)),
                  ),
                );

                // 3b️⃣ لفه بـ Animated + Dismissible Clean
                return AppWidgets.dismissibleWrapper(
                  key: Key(todo.id.toString()),
                  context: context,
                  onDelete: () {
                    todoBloc!.todoDeleteSink.add(todo);
                    HelperMethods.showError(
                      context,
                      TextConstants.deleteSuccess,
                    );
                  },
                  child: AnimationHelpers.animatedAppearance(
                    index: index,
                    child: todoWidget,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
