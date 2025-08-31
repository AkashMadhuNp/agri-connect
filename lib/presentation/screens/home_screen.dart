import 'package:agri/core/model/userdatamodel.dart';
import 'package:agri/core/service/firebase_auth_service.dart';
import 'package:agri/core/service/nursery_service.dart';
import 'package:agri/core/service/weather_service.dart';
import 'package:agri/presentation/widgets/home/activity_card.dart';
import 'package:agri/presentation/widgets/home/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NurseryHomeScreen extends StatefulWidget {
  const NurseryHomeScreen({super.key});

  @override
  State<NurseryHomeScreen> createState() => _NurseryHomeScreenState();
}

class _NurseryHomeScreenState extends State<NurseryHomeScreen> {


  final NurseryService _nurseryService = NurseryService();
  final WeatherService _weatherService = WeatherService();

  User? currentUser;
  UserData? userData;
  bool isLoadingUser = true;

  bool isLoadingWeather = true;
  Map<String, dynamic> weatherData = {};
  String weatherLocation = 'Fetching location...';

  Map<String, dynamic> nurseryStats = {};
  List<Map<String, dynamic>> todaysTasks = [];
  List<Map<String, dynamic>> recentActivities = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      _loadUserData(),
      _loadWeatherData(),
      _loadNurseryData(),
    ]);
  }

  Future<void> _loadUserData() async {
    setState(() => isLoadingUser = true);

    currentUser = FirebaseAuthService.currentUser;
    if (currentUser != null) {
      userData = await FirebaseAuthService.getUserData(currentUser!.uid);
    }

    setState(() => isLoadingUser = false);
  }

  Future<void> _loadWeatherData() async {
    setState(() => isLoadingWeather = true);

    try {
      var weatherResponse = await _weatherService.fetchWeatherFromUserLocation();
      weatherResponse ??= await _weatherService.fetchWeatherFromCurrentLocation();
      
      if (weatherResponse != null) {
        final convertedData = WeatherService.convertToWidgetData(weatherResponse);
        setState(() {
          weatherData = convertedData;
          weatherLocation = '${weatherResponse!.name}, ${weatherResponse.sys.country}';
        });
      } else {
        setState(() {
          weatherData = _getDefaultWeatherData();
          weatherLocation = 'Weather unavailable';
        });
        _showWeatherError('Unable to fetch weather data.');
      }
    } catch (e) {
      setState(() {
        weatherData = _getDefaultWeatherData();
        weatherLocation = 'Error loading weather';
      });
      _showWeatherError('Error loading weather: ${e.toString()}');
    }

    setState(() => isLoadingWeather = false);
  }

  Future<void> _loadNurseryData() async {
    try {


      final results = await Future.wait([
        _nurseryService.fetchNurseryStatsFromAPI(),
        _nurseryService.fetchTodaysTasksFromAPI(),
        _nurseryService.fetchRecentActivitiesFromAPI(),
      ]);

      setState(() {
        nurseryStats = results[0] as Map<String, dynamic>;
        todaysTasks = results[1] as List<Map<String, dynamic>>;
        recentActivities = results[2] as List<Map<String, dynamic>>;
      });
    } catch (e) {


      setState(() {
        nurseryStats = _nurseryService.getNurseryStats();
        todaysTasks = _nurseryService.getTodaysTasks();
        recentActivities = _nurseryService.getRecentActivities();
      });
    }
  }

  Map<String, dynamic> _getDefaultWeatherData() {
    return {
      'temperature': 'N/A',
      'condition': 'Unable to fetch weather',
      'humidity': 'N/A',
      'windSpeed': 'N/A',
      'pressure': 'N/A',
      'visibility': 'N/A',
      'cloudiness': 'N/A',
      'rainfall': '0',
      'icon': Icons.error_outline,
      'feelsLike': 'N/A',
      'tempMin': 'N/A',
      'tempMax': 'N/A',
    };
  }

  void _showWeatherError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Retry',
            textColor: Colors.white,
            onPressed: _loadWeatherData,
          ),
        ),
      );
    }
  }

  String _getFirstName() {
    String fullName = userData?.name ?? currentUser?.displayName ?? 'Owner';
    return fullName.split(' ').first;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dimensions = _nurseryService.getResponsiveDimensions(screenSize);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFF8),
      body: CustomScrollView(
        slivers: [
          NurseryAppBar(
            greeting: _nurseryService.getGreeting(),
            userName: _getFirstName(),
            isLoadingUser: isLoadingUser,
            notificationCount: nurseryStats['lowStockItems'] ?? 0,
            onNotificationTap: _handleNotificationTap,
            screenSize: screenSize,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(dimensions['horizontalPadding']!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WeatherContainer(
                    weatherData: weatherData,
                    location: weatherLocation,
                    isLoading: isLoadingWeather,
                    onRefresh: _loadWeatherData,
                  ),

                  SizedBox(height: dimensions['sectionSpacing']),

                  _buildQuickStatsRow(),

                  SizedBox(height: dimensions['sectionSpacing']),

                  RevenueCard(
                    revenue: (nurseryStats['monthlyRevenue'] ?? 0).toDouble(),
                    growthPercentage: '+12% from last month',
                    onTap: _handleRevenueTap,
                  ),

                  SizedBox(height: dimensions['sectionSpacing']),

                  SectionHeader(
                    title: "Today's Tasks",
                    buttonText: 'View All',
                    onButtonPressed: _handleViewAllTasks,
                    fontSize: dimensions['titleFontSize']!,
                  ),

                  SizedBox(height: dimensions['sectionSpacing']! * 0.5),

                  ...todaysTasks.take(3).map((task) => TaskCard(
                    task: task,
                    onTap: () => _handleTaskTap(task),
                  )).toList(),

                  SizedBox(height: dimensions['sectionSpacing']),

                  SectionHeader(
                    title: 'Recent Activities',
                    fontSize: dimensions['titleFontSize']!,
                  ),

                  SizedBox(height: dimensions['sectionSpacing']! * 0.5),

                  ...recentActivities.take(4).map((activity) => ActivityCard(
                    activity: activity,
                    onTap: () => _handleActivityTap(activity),
                  )).toList(),

                  SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        Expanded(
          child: QuickStatCard(
            title: 'Production\nBatches',
            value: '${nurseryStats['activeProduction'] ?? 0}',
            icon: Icons.agriculture,
            color: const Color(0xFF4CAF50),
            onTap: () => _handleStatTap('production'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickStatCard(
            title: 'Ready for\nSale',
            value: '${nurseryStats['readyForSale'] ?? 0}',
            icon: Icons.store,
            color: const Color(0xFF2196F3),
            onTap: () => _handleStatTap('inventory'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: QuickStatCard(
            title: 'Pending\nOrders',
            value: '${nurseryStats['pendingOrders'] ?? 0}',
            icon: Icons.assignment,
            color: const Color(0xFFFF9800),
            onTap: () => _handleStatTap('orders'),
          ),
        ),
      ],
    );
  }

  void _handleNotificationTap() {
    print('Navigate to notifications');
  }

  void _handleRevenueTap() {
    print('Navigate to revenue details');
  }

  void _handleViewAllTasks() {
    print('Navigate to all tasks');
  }

  void _handleTaskTap(Map<String, dynamic> task) {
    print('Task tapped: ${task['task']}');
  }

  void _handleActivityTap(Map<String, dynamic> activity) {
    print('Activity tapped: ${activity['title']}');
  }

  void _handleStatTap(String statType) {
    print('Stat tapped: $statType');
  }
}