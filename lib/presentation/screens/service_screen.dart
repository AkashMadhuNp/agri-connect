import 'package:agri/core/data/nursery_services.dart';
import 'package:agri/core/model/service_model.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/dlg_utils.dart';
import 'package:agri/presentation/widgets/service/analytic_card.dart';
import 'package:agri/presentation/widgets/service/consultation_service.dart';
import 'package:agri/presentation/widgets/service/daily_stat.dart';
import 'package:agri/presentation/widgets/service/service_card.dart';
import 'package:agri/presentation/widgets/service/service_history_card.dart';
import 'package:flutter/material.dart';
import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/snackbar_utils.dart';

class NurseryServicesScreen extends StatefulWidget {
  const NurseryServicesScreen({super.key});

  @override
  State<NurseryServicesScreen> createState() => _NurseryServicesScreenState();
}

class _NurseryServicesScreenState extends State<NurseryServicesScreen> 
    with TickerProviderStateMixin {
  late TabController _tabController;
  final NurseryDataSource _dataSource = NurseryDataSource();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodayTab(),
          _buildServicesTab(),
          _buildAnalyticsTab(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Service Management',
            style: TextStyle(
              color: AppColors.textWhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            'Agricultural Consultation Services',
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 12,
            ),
          ),
        ],
      ),
      backgroundColor: AppColors.accentGreen,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_today, color: AppColors.textWhite),
          onPressed: _showBookingCalendar,
        ),
        IconButton(
          icon: const Icon(Icons.add, color: AppColors.textWhite),
          onPressed: _showAddConsultation,
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.textWhite,
        labelColor: AppColors.textWhite,
        unselectedLabelColor: AppColors.textWhite,
        tabs: const [
          Tab(text: 'Today'),
          Tab(text: 'Services'),
          Tab(text: 'Analytics'),
        ],
      ),
    );
  }

  Widget _buildTodayTab() {
    final todayConsultations = _dataSource.getTodayConsultations();
    final recentServices = _dataSource.getRecentServices();
    final todayRevenue = _dataSource.calculateTodayRevenue(todayConsultations);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTodaysSummaryCard(todayConsultations.length, todayRevenue),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildSectionHeader('Today\'s Consultations'),
          const SizedBox(height: AppDimensions.paddingSmall),
          ...todayConsultations.map((consultation) => 
            ConsultationCard(
              consultation: consultation,
              onCall: () => _handleCallClient(consultation.phone),
              onNavigate: () => _handleNavigate(consultation.location),
            )
          ),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildSectionHeader('Recent Service History'),
          const SizedBox(height: AppDimensions.paddingSmall),
          ...recentServices.take(3).map((service) => 
            ServiceHistoryCard(service: service)
          ),
        ],
      ),
    );
  }

  Widget _buildServicesTab() {
    final services = _dataSource.getAvailableServices();
    final serviceStats = _dataSource.getServiceStats();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildServicePortfolioCard(serviceStats),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildSectionHeader('Available Services'),
          const SizedBox(height: AppDimensions.paddingSmall),
          ...services.map((service) => 
            ServiceCard(
              service: service,
              onEdit: () => _handleEditService(service),
              onBook: () => _handleBookService(service),
            )
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticsTab() {
    final serviceStats = _dataSource.getServiceStats();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMonthlyPerformanceCard(serviceStats),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildFinancialSummaryCard(serviceStats),
          const SizedBox(height: AppDimensions.paddingLarge),
          _buildQuickActionsSection(),
        ],
      ),
    );
  }

  Widget _buildTodaysSummaryCard(int totalBookings, int estimatedRevenue) {
    return Card(
      elevation: AppDimensions.cardElevation,
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Today\'s Schedule',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DailyStatWidget(
                  label: 'Total Bookings',
                  value: totalBookings.toString(),
                  icon: Icons.schedule,
                  color: AppColors.info,
                ),
                DailyStatWidget(
                  label: 'Estimated Revenue',
                  value: 'Rs. $estimatedRevenue',
                  icon: Icons.currency_rupee,
                  color: AppColors.success,
                ),
                DailyStatWidget(
                  label: 'Travel Time',
                  value: '6 hours',
                  icon: Icons.directions_car,
                  color: AppColors.warning,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePortfolioCard(Map<String, dynamic> stats) {
    return Card(
      elevation: AppDimensions.cardElevation,
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Service Portfolio',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DailyStatWidget(
                  label: 'Active Services',
                  value: stats['activeServices'].toString(),
                  icon: Icons.build,
                  color: AppColors.primaryGreen,
                ),
                DailyStatWidget(
                  label: 'Avg. Price',
                  value: 'Rs. ${stats['avgPrice']}',
                  icon: Icons.attach_money,
                  color: AppColors.success,
                ),
                DailyStatWidget(
                  label: 'Specialists',
                  value: stats['specialists'].toString(),
                  icon: Icons.people,
                  color: AppColors.info,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyPerformanceCard(Map<String, dynamic> stats) {
    return Card(
      elevation: AppDimensions.cardElevation,
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Monthly Performance',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: AnalyticCard(
                    label: 'Total Revenue',
                    value: 'Rs. ${(stats['monthlyRevenue'] / 1000).toStringAsFixed(0)}K',
                    icon: Icons.trending_up,
                    color: AppColors.success,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Expanded(
                  child: AnalyticCard(
                    label: 'Services Done',
                    value: stats['completedServices'].toString(),
                    icon: Icons.check_circle,
                    color: AppColors.info,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Row(
              children: [
                Expanded(
                  child: AnalyticCard(
                    label: 'Avg Rating',
                    value: '${stats['avgRating']}⭐',
                    icon: Icons.star,
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Expanded(
                  child: AnalyticCard(
                    label: 'Total Clients',
                    value: stats['totalClients'].toString(),
                    icon: Icons.people,
                    color: AppColors.darkGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialSummaryCard(Map<String, dynamic> stats) {
    return Card(
      elevation: AppDimensions.cardElevation,
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Financial Summary',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildFinancialRow(
              'Monthly Revenue', 
              'Rs. ${stats['monthlyRevenue']}', 
              AppColors.success
            ),
            const SizedBox(height: AppDimensions.paddingTiny),
            _buildFinancialRow(
              'Pending Payments', 
              'Rs. ${stats['pendingPayments']}', 
              AppColors.warning
            ),
            const SizedBox(height: AppDimensions.paddingTiny),
            _buildFinancialRow(
              'Repeat Clients', 
              '${stats['repeatClients']}/${stats['totalClients']} (${(stats['repeatClients'] / stats['totalClients'] * 100).round()}%)', 
              AppColors.info
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Quick Actions'),
        const SizedBox(height: AppDimensions.paddingSmall),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _showAddConsultation,
                icon: const Icon(Icons.add),
                label: const Text('New Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  foregroundColor: AppColors.textWhite,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingSmall
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _showPendingPayments,
                icon: const Icon(Icons.payment),
                label: const Text('Payments'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.paddingSmall
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18, 
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildFinancialRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label, 
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value, 
          style: TextStyle(
            fontSize: 14, 
            fontWeight: FontWeight.bold, 
            color: color,
          ),
        ),
      ],
    );
  }

  void _handleCallClient(String phone) {
    // Implementation for calling client
    SnackBarUtils.showInfo(context, 'Calling $phone...');
  }

  void _handleNavigate(String location) {
    // Implementation for navigation
    SnackBarUtils.showInfo(context, 'Opening navigation to $location...');
  }

  void _handleEditService(ServiceModel service) {
    // Implementation for editing service
    SnackBarUtils.showInfo(context, 'Editing ${service.name}...');
  }

  void _handleBookService(ServiceModel service) {
    // Implementation for booking service
    SnackBarUtils.showSuccess(context, 'Booking ${service.name}...');
  }

  void _showBookingCalendar() {
    DialogUtils.showInfoDialog(
      context,
      title: 'Booking Calendar',
      content: 'Feature comming soon!!!\n\n\nThis would show a calendar view of all upcoming consultations and available time slots.',
    );
  }

  void _showAddConsultation() {
    DialogUtils.showInfoDialog(
      context,
      title: 'New Consultation Booking',
      content: 'Feature comming soon!!!\nThis would open a form to book a new consultation with client details, service type, date/time, etc.',
    );
  }

  void _showPendingPayments() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pending Payments', 
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            ..._dataSource.getPendingPayments().map((payment) => 
              ListTile(
                title: Text('${payment['clientName']} - ${payment['service']}'),
                subtitle: Text('Rs. ${payment['amount']} • ${payment['status']}'),
                trailing: ElevatedButton(
                  onPressed: () => _handlePaymentAction(payment),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: AppColors.textWhite,
                  ),
                  child: Text(payment['action']),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }

  void _handlePaymentAction(Map<String, dynamic> payment) {
    SnackBarUtils.showSuccess(context, 'Payment action handled for ${payment['clientName']}');
    Navigator.pop(context);
  }
}
