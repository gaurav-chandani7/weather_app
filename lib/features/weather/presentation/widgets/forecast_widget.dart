// import 'package:flutter_application_weather/forecast_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/domain/entities/entities.dart';
// import 'package:intl/intl.dart';

class ForecastWidget extends StatelessWidget {
  late final double? _width;
  late final double? _height;
  late final double _iconSize;
  late final double _tempTextSize;
  late final Size _rowTextSize;
  late final EdgeInsets? _outerPadding;
  late final EdgeInsets _innerPadding;
  late final EdgeInsets _mainInnerPadding;

  ForecastWidget.small(this.forecast, {super.key}) {
    _width = 150;
    _height = 140;
    _iconSize = 40;
    _tempTextSize = 15;
    _rowTextSize = const Size(23, 16);
    _outerPadding = const EdgeInsets.all(8.0);
    _innerPadding = const EdgeInsets.all(8.0);
    _mainInnerPadding = const EdgeInsets.only(top: 14.0, bottom: 14.0);
  }

  ForecastWidget.big(this.forecast, {super.key}) {
    _width = null;
    _height = null;
    _iconSize = 150;
    _tempTextSize = 50;
    _rowTextSize = const Size(45, 30);
    _outerPadding = null;
    _innerPadding = const EdgeInsets.all(16.0);
    _mainInnerPadding = const EdgeInsets.only(top: 8.0, bottom: 8.0);
  }

  // final Forecast forecast;
  final CurrentWeatherEntity forecast;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: _outerPadding,
      child: Container(
        padding: _innerPadding,
        color: Colors.white,
        height: _height,
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _SubRow(
                rowTextSize: _rowTextSize,
                leftText: DateFormat("d MMMM").format(
                    DateTime.fromMillisecondsSinceEpoch(
                        forecast.dt + forecast.timezone)),
                rightText: DateFormat("HH:00").format(
                    DateTime.fromMillisecondsSinceEpoch(
                        forecast.dt + forecast.timezone)),
                leftFlex: 5,
                rightFlex: 3),
            _MainRow(
              mainInnerPadding: _mainInnerPadding,
              iconUrl: forecast.weather.first.icon != null
                  ? "https://openweathermap.org/img/wn/${forecast.weather.first.icon}@4x.png"
                  : "https://openweathermap.org/img/wn/01d.png",
              iconSize: _iconSize,
              textSize: _tempTextSize,
              rightText: "${forecast.main.temp.round()}°C",
            ),
            _SubRow(
                rowTextSize: _rowTextSize,
                leftText: "Humidity",
                rightText: "${forecast.main.humidity}%",
                leftFlex: 2,
                rightFlex: 1),
          ],
        ),
      ),
    );
  }
}

class _MainRow extends StatelessWidget {
  final EdgeInsets mainInnerPadding;
  // final IconData iconData;
  final String iconUrl;
  final double iconSize;
  final double textSize;
  final String rightText;

  const _MainRow(
      {required this.mainInnerPadding,
      required this.iconUrl,
      required this.iconSize,
      required this.textSize,
      required this.rightText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mainInnerPadding,
      child: Row(
        children: [
          Image(
            image: NetworkImage(iconUrl),
            height: iconSize,
            width: iconSize,
            color: null,
          ),
          const Spacer(),
          Expanded(
            child: FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
              child: Text(
                rightText,
                style: TextStyle(fontSize: textSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubRow extends StatelessWidget {
  final Size rowTextSize;
  final String leftText;
  final String rightText;

  final int leftFlex;
  final int rightFlex;

  const _SubRow(
      {required this.rowTextSize,
      required this.leftText,
      required this.rightText,
      required this.leftFlex,
      required this.rightFlex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: leftFlex,
          child: SizedBox(
            height: rowTextSize.height,
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.contain,
              child: Text(leftText),
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: rightFlex,
          child: SizedBox(
            height: rowTextSize.height,
            child: FittedBox(
              alignment: Alignment.centerRight,
              fit: BoxFit.contain,
              child: Text(rightText),
            ),
          ),
        ),
      ],
    );
  }
}
