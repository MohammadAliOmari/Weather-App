import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/rows_temp.dart';
import 'package:weather_app/cubit/cubit.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({
    super.key,
    required this.cubit,
    required this.controller,
  });

  final WeatherCubit cubit;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Text(
          cubit.weatherFuture?.name ?? '',
          style: const TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        FadeInLeft(
          child: cubit.getWeatherIcon(cubit.weatherFuture?.weather[0].id ?? 0),
        ),
        FadeInRight(
          child: Text(
            '${cubit.weatherFuture!.main.temp.round()}°C',
            style: const TextStyle(
                color: Colors.white, fontSize: 55, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        FadeIn(
          child: Text(
            cubit.weatherFuture?.weather[0].main.toUpperCase() ?? '',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          DateFormat('EEEE dd •').add_jm().format(
                DateTime.fromMillisecondsSinceEpoch(
                    cubit.weatherFuture!.dt * 1000),
              ),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        FadeIn(
          child: RowsTemp(
            image: 'assets/11.png',
            name: 'Sunrise',
            tempandclock: DateFormat().add_jm().format(
                  DateTime.fromMillisecondsSinceEpoch(
                      cubit.weatherFuture!.sys.sunrise * 1000),
                ),
            image1: 'assets/12.png',
            name1: 'Sunset',
            tempandclock1: DateFormat().add_jm().format(
                  DateTime.fromMillisecondsSinceEpoch(
                      cubit.weatherFuture!.sys.sunset * 1000),
                ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Divider(color: Colors.grey),
        ),
        FadeIn(
          child: RowsTemp(
            image: 'assets/13.png',
            name: 'Temp Max',
            tempandclock: '${cubit.weatherFuture!.main.tempMax.round()}°C',
            image1: 'assets/14.png',
            name1: 'Temp Min',
            tempandclock1: '${cubit.weatherFuture!.main.tempMin.round()}°C',
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 400,
          child: TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: controller,
            keyboardType: TextInputType.text,
            // onTap: () {},
            validator: (value) {
              if (value!.isEmpty) {
                return "search must not be empty";
              }
              return null;
            },
            onFieldSubmitted: (value) {
              if (value.isEmpty) {
                cubit.getWeather();
              } else {
                cubit.city = value;
                cubit.getWeather();
                controller.clear();
              }
            },
            decoration: const InputDecoration(
              // prefixIconColor: Colors.amber,
              labelText: 'Search',
              hintText: 'Enter City Name',
              hintStyle: TextStyle(color: Colors.grey),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              labelStyle: TextStyle(color: Colors.white),
              // border: OutlineInputBorder(
              //     borderSide:
              //         BorderSide(color: Colors.white))
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
