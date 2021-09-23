import 'dart:ui' as ui;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appaa/layout/news_app/cubit/cubit.dart';
import 'package:flutter_appaa/layout/news_app/news_layout.dart';
import 'package:flutter_appaa/layout/shop_app/cubit/cubit.dart';
import 'package:flutter_appaa/layout/todo_app/cubit/cubit.dart';
import 'package:flutter_appaa/layout/todo_app/cubit/states.dart';

//import 'package:flutter_appaa/layout/todo_App/todo_layout.dart';
import 'package:flutter_appaa/layout/todo_app/todo_layout.dart';
import 'package:flutter_appaa/layout/bmi_app/BMI_screen.dart';
import 'package:flutter_appaa/modules/bmi_app/bmi_result/BMI_screen_result.dart';
import 'package:flutter_appaa/modules/counter_app/counter/Counter_Screen.dart';
import 'package:flutter_appaa/modules/basics_app/login/Login_screen.dart';
import 'package:flutter_appaa/modules/basics_app/users/Users_Screen.dart';
import 'package:flutter_appaa/modules/basics_app/home/home_screen.dart';
import 'package:flutter_appaa/modules/basics_app/messenger/massenger_screen.dart';
import 'package:flutter_appaa/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_appaa/shared/component/constants.dart';
import 'package:flutter_appaa/shared/network/local/cashe_helper.dart';
import 'package:flutter_appaa/shared/network/remote/dio_helper.dart';
import 'package:flutter_appaa/shared/network/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import 'layout/shop_app/shop_layout.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';
//import 'package:flutter_appaa/massenger_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool isDark = CacheHelper.getData(key: 'isDark');
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  if (onBoarding != false) {
    if (token != null)
      widget = ShopLayoutScreen();
      else widget=ShopLoginScreen();
  }else
    widget=OnBoardingScreen();
  runApp(MyApp(
    isDark: isDark,
    startWidget:widget ,
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;

  MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusinessData()
            ..getSportsData()
            ..getScienceData(),
        ),
        BlocProvider(
            create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
        BlocProvider(
            create: (context) => AppCubit()
              ..changeAppThemeMode(
                fromShared: isDark,
              )),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}
