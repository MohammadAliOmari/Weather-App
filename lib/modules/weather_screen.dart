import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/components/rows_temp.dart';
import 'package:weather_app/cubit/cubit.dart';
import 'package:weather_app/cubit/states.dart';

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
              title: const Text(
                ' Weather App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
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
                    : SingleChildScrollView(
                        child: Column(children: [
                          Text(
                            cubit.weatherFuture?.name ?? '',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          cubit.getWeatherIcon(
                              cubit.weatherFuture?.weather[0].id ?? 0),
                          Text(
                            '${cubit.weatherFuture!.main.temp.round()}°C',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            cubit.weatherFuture?.weather[0].main
                                    .toUpperCase() ??
                                '',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
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
                          RowsTemp(
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Divider(color: Colors.grey),
                          ),
                          RowsTemp(
                            image: 'assets/13.png',
                            name: 'Temp Max',
                            tempandclock:
                                '${cubit.weatherFuture!.main.tempMax.round()}°C',
                            image1: 'assets/14.png',
                            name1: 'Temp Min',
                            tempandclock1:
                                '${cubit.weatherFuture!.main.tempMin.round()}°C',
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
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
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
