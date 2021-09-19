import 'package:flutter/material.dart';
import 'package:flutter_appaa/shared/component/components.dart';
import 'package:flutter_appaa/shared/component/constants.dart';
import 'package:flutter_appaa/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_appaa/layout/todo_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
//  const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).newTasks;
       return tasksBuilder(tasks: tasks);
      },
    );
  }
}
