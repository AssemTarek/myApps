import 'package:flutter/material.dart';
import 'package:flutter_appaa/layout/news_app/cubit/states.dart';
import 'package:flutter_appaa/modules/news_app/business/business_screen.dart';
import 'package:flutter_appaa/modules/news_app/science/sience_screen.dart';
import 'package:flutter_appaa/modules/news_app/sports/sports_screen.dart';
import 'package:flutter_appaa/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'science',
    ),
    // BottomNavigationBarItem(
    //   icon: Icon(
    //     Icons.settings,
    //   ),
    //   label: 'settings',
    // ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    //  SettingsScreen(),
  ];
  List<String> titles = [
    'Business News',
    'Sports News',
    'Science News',
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSportsData();
    if (index == 2) getScienceData();

    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    if (business.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        business = value.data['articles'];
        emit(NewsBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsBusinessErrorState(error.toString()));
      });
    } else
      emit(NewsBusinessSuccessState());
  }

  void getSportsData() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
      });
    } else
      emit(NewsSportsSuccessState());
  }

  void getScienceData() {
    emit(NewsGetScienceLoadingState());

    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'Science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        science = value.data['articles'];
        emit(NewsScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsScienceErrorState(error.toString()));
      });
    } else
      emit(NewsScienceSuccessState());
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
        url: 'v2/everything',
        query: {
      'q': '$value',
      'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
