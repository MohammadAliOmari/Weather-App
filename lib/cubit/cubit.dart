import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubit/states.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:http/http.dart' as http;

import '../constant/constant.dart';

class WeatherCubit extends Cubit<WeatherStates> {
  WeatherCubit()
      : super(
          InitalState(),
        );

  static WeatherCubit get(context) => BlocProvider.of(context);

  String city = 'amman';
  WeatherModel? weatherFuture;
  Widget getWeatherIcon(int code) {
    String imagePath = 'assets/7.png';
    if (code >= 200 && code < 300) {
      imagePath = 'assets/1.png';
    } else if (code >= 300 && code < 400) {
      imagePath = 'assets/2.png';
    } else if (code >= 500 && code < 600) {
      imagePath = 'assets/3.png';
    } else if (code >= 600 && code < 700) {
      imagePath = 'assets/4.png';
    } else if (code >= 700 && code < 800) {
      imagePath = 'assets/5.png';
    } else if (code == 800) {
      imagePath = 'assets/6.png';
    } else if (code > 800 && code <= 804) {
      imagePath = 'assets/7.png';
    }

    return Image.asset(
      imagePath,
      scale: 1.5,
    );
  }

  void getWeather() async {
    emit(LodingState());
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey";

    final response = await http.get(
      Uri.parse(url),
    );
    // if (weatherFuture == null) {

    //   print('/////////////////////////////');
    // }

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      weatherFuture = WeatherModel.fromJson(jsonBody);
      emit(SucssesState());
    } else {
      emit(ErrorState());
    }
  }
}
