import 'dart:convert';
import 'package:agri/core/model/weather_model.dart';
import 'package:agri/core/service/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class WeatherService {
  static const String _apiKey = 'c6019a7a17971c9752a24eebb59ddd24';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<WeatherResponse?> fetchWeatherFromUserLocation() async {
    try {
      final currentUser = FirebaseAuthService.currentUser;
      if (currentUser == null) {
        throw Exception('No user logged in');
      }

      final userData = await FirebaseAuthService.getUserData(currentUser.uid);
      if (userData?.location == null) {
        throw Exception('No location found for user');
      }

      final coordinates = _parseCoordinates(userData!.location);
      if (coordinates == null) {
        throw Exception('Invalid location format');
      }

      return await _fetchWeatherData(coordinates['lat']!, coordinates['lon']!);
    } catch (e) {
      print('Error fetching weather from user location: $e');
      return null;
    }
  }

  Future<WeatherResponse?> fetchWeatherFromCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions permanently denied');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return await _fetchWeatherData(position.latitude, position.longitude);
    } catch (e) {
      print('Error fetching weather from current location: $e');
      return null;
    }
  }

  Future<WeatherResponse?> fetchWeatherByCoordinates(double lat, double lon) async {
    return await _fetchWeatherData(lat, lon);
  }

  Map<String, double>? _parseCoordinates(String location) {
    try {
      final parts = location.split(',');
      if (parts.length == 2) {
        final lat = double.parse(parts[0].trim());
        final lon = double.parse(parts[1].trim());
        return {'lat': lat, 'lon': lon};
      }
    } catch (e) {
      print('Error parsing coordinates: $e');
    }
    return null;
  }

  Future<WeatherResponse?> _fetchWeatherData(double lat, double lon) async {
    try {
      final url = '$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric';
      print('Fetching weather from: $url');

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print('Weather API Response: ${response.body}');
        return WeatherResponse.fromJson(json);
      } else {
        print('Weather API Error: ${response.statusCode} - ${response.body}');
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } catch (e) {
      print('Weather service error: $e');
      return null;
    }
  }

  static Map<String, dynamic> convertToWidgetData(WeatherResponse weather) {
    print('Converting weather data: ${weather.weather.first.description}');
    print('Temperature: ${weather.main.temp}');
    
    return {
      'temperature': '${weather.main.temp.round()}°C',
      'feelsLike': '${weather.main.feelsLike.round()}°C',
      'condition': _capitalizeWords(weather.weather.first.description), 
      'humidity': '${weather.main.humidity}%',
      'windSpeed': '${(weather.wind.speed * 3.6).round()} km/h', 
      'pressure': '${weather.main.pressure} hPa',
      'visibility': '${(weather.visibility / 1000).round()} km',
      'cloudiness': '${weather.clouds.all}%',
      'rainfall': weather.rain?.oneHour?.toString() ?? '0', 
      'sunrise': weather.sys.sunrise != null 
          ? DateTime.fromMillisecondsSinceEpoch(weather.sys.sunrise! * 1000)
          : null,
      'sunset': weather.sys.sunset != null 
          ? DateTime.fromMillisecondsSinceEpoch(weather.sys.sunset! * 1000)
          : null,
      'icon': _getWeatherIcon(weather.weather.first.main, weather.weather.first.id),
      'city': weather.name,
      'country': weather.sys.country,
      'tempMin': '${weather.main.tempMin.round()}°C',
      'tempMax': '${weather.main.tempMax.round()}°C',
    };
  }

  static String _capitalizeWords(String text) {
    return text.split(' ')
        .map((word) => word.isEmpty ? word : '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  static IconData _getWeatherIcon(String main, int id) {
    switch (main.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        if (id == 801 || id == 802) {
          return Icons.wb_cloudy;
        } else {
          return Icons.cloud;
        }
      case 'rain':
        return Icons.umbrella;
      case 'drizzle':
        return Icons.grain;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'snow':
        return Icons.ac_unit;
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return Icons.foggy;
      default:
        return Icons.wb_cloudy;
    }
  }
}