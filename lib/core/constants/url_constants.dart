import 'package:flutter_dotenv/flutter_dotenv.dart';

const String baseApiUrl = "https://pro.openweathermap.org/data/2.5";
const String unitsParamApi = "metric";
const String cntParamHourlyForecastApi = "24";
const String cntParamDailyForecastApi = "7";
String appId = dotenv.get('OPEN_WEATHER_MAP_API_KEY', fallback: '');
const String iconBaseUrl = "https://openweathermap.org/img/wn";
