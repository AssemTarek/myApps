import 'package:flutter/material.dart';
import 'package:flutter_appaa/layout/news_app/cubit/cubit.dart';
import 'package:flutter_appaa/layout/news_app/cubit/states.dart';
import 'package:flutter_appaa/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_appaa/modules/news_app/search/search_screen.dart';
import 'package:flutter_appaa/shared/component/components.dart';
import 'package:flutter_appaa/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                  cubit.titles[cubit.currentIndex]
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen(),);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    AppCubit.get(context).changeAppThemeMode();
                  },
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              items: cubit.bottomItems,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        });
  }
}
