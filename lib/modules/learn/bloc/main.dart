import 'package:cubipool/modules/learn/bloc/bloc/weather_bloc.dart';
import 'package:cubipool/modules/learn/bloc/data/weather_repository.dart';
import 'package:cubipool/modules/learn/bloc/pages/weather_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubipool APP',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => WeatherBloc(FakeWeatherRepository()),
        child: WeatherSearchpage(),
      ),
      // routes: {'/': (context) => WeatherSearchpage()},
    );
  }
}
