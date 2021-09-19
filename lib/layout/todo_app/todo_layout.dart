import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appaa/modules/todo_app/archived_tasks/archived_tasks.dart';
import 'package:flutter_appaa/modules/todo_app/done_tasks/done_tasks.dart';
import 'package:flutter_appaa/modules/todo_app/new_tasks/new_tasks.dart';
import 'package:flutter_appaa/shared/component/components.dart';
import 'package:flutter_appaa/shared/component/constants.dart';
import 'package:flutter_appaa/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_appaa/layout/todo_app/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class ToDoLayout extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {
          if(state is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        date: dateController.text,
                        time: timeController.text,
                        title: titleController.text
                    );
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                    controller: titleController,
                                    type: TextInputType.text,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return ('title must not be empty');
                                      }
                                    },
                                    label: 'task title',
                                    prefix: Icons.title),
                                SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return ('time must not be empty');
                                      }
                                    },
                                    label: 'time title',
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) => {
                                                timeController.text = value
                                                    .format(context)
                                                    .toString(),
                                              });
                                    },
                                    prefix: Icons.watch_later_outlined),
                                SizedBox(
                                  height: 10.0,
                                ),
                                defaultFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return ('date must not be empty');
                                    }
                                  },
                                  label: 'date title',
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2021-10-20'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMM().format(value);
                                    });
                                  },
                                  prefix: Icons.calendar_today_outlined,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 15.0,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShown: false, icon: Icons.edit);
                  });

                  cubit.changeBottomSheetState(
                    isShown: true,
                    icon: Icons.add,
                  );
                }
              },
              child: Icon(
                cubit.fabIcon,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archive',
                ),
              ],
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }

  Future<String> getName() async {
    return 'Ahmed Ali';
  }
}
