// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/blocs/temp_settings/temp_settings_bloc.dart';
import 'package:weather_app/blocs/weather/weather_bloc.dart';
// import 'package:weather_app/cubits/temp_settings/temp_settings_cubit.dart';

import '../constants/constants.dart';
// import '../cubits/weather/weather_cubit.dart';
import 'search_page.dart';
import 'settings_page.dart';
import 'package:recase/recase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String? _city;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              _city = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SearchPage();
                }),
              );

              if (_city != null) {
                context.read<WeatherBloc>().add(
                      FetchWeatherEvent(city: _city!),
                    );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return const SettingsPage();
                }),
              );
            },
          ),
        ],
      ),
      body: showWeather(),
    );
  }

  Widget showIcon(String icon) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/loading.gif',
      image: 'http://$kIconHost/img/wn/$icon@4x.png',
      width: 96,
      height: 96,
    );
  }

  Widget formatText(String description) {
    final formattedString = description.titleCase;
    return Text(
      formattedString,
      style: const TextStyle(fontSize: 24.0),
      textAlign: TextAlign.center,
    );
  }

  String showTemperature(double temperature) {
    final tempUnit = context.watch<TempSettingsBloc>().state.tempUnit;

    if (tempUnit == TempUnit.fahrenheit) {
      return ((temperature * 9 / 5) + 32).toStringAsFixed(2) + '℉';
    }

    return temperature.toStringAsFixed(2) + '℃';
  }

  Widget showWeather() {
    return BlocConsumer<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state.status == WeatherStatus.initial) {
        return const Center(
          child: Text(
            'Select a city',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        );
      }

      if (state.status == WeatherStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state.status == WeatherStatus.error &&
          state.weatherModel.name == "") {
        return const Center(
          child: Text(
            'Select a city',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        );
      }

      return ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Text(
            state.weatherModel.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                TimeOfDay.fromDateTime(state.weatherModel.lastUpdated)
                    .format(context),
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(width: 10.0),
              Text(
                '(${state.weatherModel.country})',
                style: const TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          const SizedBox(height: 60.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showTemperature(state.weatherModel.temp),
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20.0),
              Column(
                children: [
                  Text(
                    showTemperature(state.weatherModel.tempMax),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    showTemperature(state.weatherModel.tempMin),
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Spacer(),
              showIcon(state.weatherModel.icon),
              Expanded(
                flex: 3,
                child: formatText(state.weatherModel.description),
              ),
              Spacer(),
            ],
          ),
        ],
      );
    }, listener: (context, state) {
      if (state.status == WeatherStatus.error) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.customError.errorMsg),
              );
            });
      }
    });
  }
}
