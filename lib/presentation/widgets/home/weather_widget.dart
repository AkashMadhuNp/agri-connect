import 'package:flutter/material.dart';

class WeatherContainer extends StatelessWidget {
  final Map<String, dynamic> weatherData;
  final String location;
  final bool isLoading;
  final VoidCallback? onRefresh;

  const WeatherContainer({
    super.key,
    required this.weatherData,
    required this.location,
    required this.isLoading,
    this.onRefresh,
  });

  List<Color> _getWeatherColors() {
    final condition = weatherData['condition']?.toString().toLowerCase() ?? '';
    final hour = DateTime.now().hour;
    final isNight = hour < 6 || hour > 20;

    if (condition.contains('rain') || condition.contains('storm')) {
      return [const Color(0xFF37474F), const Color(0xFF455A64), const Color(0xFF607D8B)];
    } else if (condition.contains('snow')) {
      return [const Color(0xFF546E7A), const Color(0xFF78909C), const Color(0xFF90A4AE)];
    } else if (condition.contains('cloud')) {
      return [const Color(0xFF5D4037), const Color(0xFF6D4C41), const Color(0xFF795548)];
    } else if (condition.contains('clear') || condition.contains('sunny')) {
      return isNight 
        ? [const Color(0xFF1A237E), const Color(0xFF283593), const Color(0xFF3F51B5)]
        : [const Color(0xFF1976D2), const Color(0xFF2196F3), const Color(0xFF42A5F5)];
    }
    return [const Color(0xFF1565C0), const Color(0xFF1976D2), const Color(0xFF2196F3)];
  }

  @override
  Widget build(BuildContext context) {
    final colors = _getWeatherColors();
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: isLoading ? _buildLoading() : _buildContent(isTablet),
      ),
    );
  }

  Widget _buildLoading() {
    return const SizedBox(
      height: 260,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              'Loading Weather...',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(bool isTablet) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildMainTemp(isTablet),
          const SizedBox(height: 20),
          _buildDetails(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_on, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (onRefresh != null)
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: onRefresh,
          ),
      ],
    );
  }

  Widget _buildMainTemp(bool isTablet) {
    final temperature = weatherData['temperature'] ?? 'N/A';
    final condition = weatherData['condition'] ?? 'Unknown';
    final feelsLike = weatherData['feelsLike'] ?? 'N/A';
    final icon = weatherData['icon'] ?? Icons.wb_cloudy;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: isTablet ? 48 : 40),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  temperature,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 42 : 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  condition,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Feels like $feelsLike',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildDetailItem(Icons.water_drop, 'Humidity', weatherData['humidity'] ?? 'N/A')),
              const SizedBox(width: 12),
              Expanded(child: _buildDetailItem(Icons.air, 'Wind', weatherData['windSpeed'] ?? 'N/A')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildDetailItem(Icons.compress, 'Pressure', weatherData['pressure'] ?? 'N/A')),
              const SizedBox(width: 12),
              Expanded(child: _buildDetailItem(Icons.visibility, 'Visibility', weatherData['visibility'] ?? 'N/A')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}