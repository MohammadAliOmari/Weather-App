import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/rows_temp.dart';
import 'package:weather_app/cubit/cubit.dart';
import 'package:weather_app/cubit/states.dart';
import 'package:weather_app/modules/weather_view.dart';

class WeatherScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  WeatherScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getWeather(),
      child: BlocConsumer<WeatherCubit, WeatherStates>(
        listener: (context, state) {
          if (state is ErrorState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: const Color(0xFF560258),
                  elevation: 0,
                  alignment: Alignment.center,
                  icon: const Icon(Icons.error_outline_outlined),
                  iconColor: Colors.white,
                  content: const SizedBox(
                      height: 20,
                      child: Center(
                          child: Text(
                        "Some Thing Wrong Try Again",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ))),
                  actions: [
                    TextButton(
                      onPressed: () {
                        controller.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text("OK",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                );
              },
            );
          }
        },
        builder: (context, state) {
          WeatherCubit cubit = WeatherCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF560258),
              elevation: 0,
              title: FadeInDown(
                child: const Text(
                  ' Weather App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF560258),
                      Colors.deepPurple,
                      Color(0xFF000000),
                    ],
                  ),
                ),
                child: state is LodingState
                    ? const Center(child: CircularProgressIndicator())
                    : WeatherView(cubit: cubit, controller: controller),
              ),
            ),
          );
        },
      ),
    );
  }
}
