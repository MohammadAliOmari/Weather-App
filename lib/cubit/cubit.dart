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
    switch (code) {
      case >= 200 && < 300:
        return Image.asset(
          'assets/1.png',
          scale: 1.5,
        );
      case >= 300 && < 400:
        return Image.asset(
          'assets/2.png',
          scale: 1.5,
        );
      case >= 500 && < 600:
        return Image.asset(
          'assets/3.png',
          scale: 1.5,
        );
      case >= 600 && < 700:
        return Image.asset(
          'assets/4.png',
          scale: 1.5,
        );
      case >= 700 && < 800:
        return Image.asset(
          'assets/5.png',
          scale: 1.5,
        );
      case == 800:
        return Image.asset(
          'assets/6.png',
          scale: 1.5,
        );
      case > 800 && <= 804:
        return Image.asset(
          'assets/7.png',
          scale: 1.5,
        );
      default:
        return Image.asset(
          'assets/7.png',
          scale: 1.5,
        );
    }
  }

  void getWeather() async {
    emit(LodingState());
    final String url =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$apiKey";

    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      weatherFuture = WeatherModel.fromJson(jsonBody);
      emit(SucssesState());
    } else {
      emit(ErrorState());
    }
  }
}
