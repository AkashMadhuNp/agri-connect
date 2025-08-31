import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/utils/app_dimensions.dart';
import 'package:agri/core/utils/app_strings.dart';
import 'package:agri/presentation/widgets/monitor/add_batch_dialog.dart';
import 'package:agri/presentation/widgets/monitor/inventory_alert.dart';
import 'package:agri/presentation/widgets/monitor/over_view_tab.dart';
import 'package:agri/presentation/widgets/monitor/production_tab.dart';
import 'package:agri/presentation/widgets/monitor/staff_tab.dart';
import 'package:flutter/material.dart';
import 'package:agri/core/model/production_batch_model.dart';
import 'package:agri/core/model/staff_model.dart';
import 'package:agri/core/service/firebase_auth_service.dart';
import 'package:agri/core/service/production_batch_service.dart';
import 'package:agri/core/service/staff_service.dart';


class ProductionMonitoringScreen extends StatefulWidget {
  const ProductionMonitoringScreen({super.key});

  @override
  State<ProductionMonitoringScreen> createState() => _ProductionMonitoringScreenState();
}

class _ProductionMonitoringScreenState extends State<ProductionMonitoringScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  
  String nurseryName = 'My Nursery';
  bool isLoading = true;
  bool isLoadingStaff = false;
  bool isLoadingProduction = false;
  
  List<StaffMember> staffMembers = [];
  List<ProductionBatch> productionBatches = [];
  
  String? staffErrorMessage;
  String? productionErrorMessage;

  final List<Map<String, dynamic>> inventoryAlerts = [
    {'item': 'Tomato Seeds (Hybrid)', 'currentStock': 2.5, 'unit': 'kg', 'minStock': 5, 'urgency': 'High'},
    {'item': 'NPK Fertilizer', 'currentStock': 12, 'unit': 'bags', 'minStock': 20, 'urgency': 'Medium'},
    {'item': 'Seedling Trays', 'currentStock': 45, 'unit': 'pcs', 'minStock': 50, 'urgency': 'Low'},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await Future.wait([
      _loadUserData(),
      _loadStaffData(),
      _loadProductionData(),
    ]);
  }

  Future<void> _loadUserData() async {
    try {
      final currentUser = FirebaseAuthService.currentUser;
      if (currentUser != null) {
        final userData = await FirebaseAuthService.getUserData(currentUser.uid);
        if (userData != null && mounted) {
          setState(() {
            nurseryName = '${userData.name}\'s Nursery';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          nurseryName = 'My Nursery';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _loadStaffData() async {
    if (!mounted) return;

    setState(() {
      isLoadingStaff = true;
      staffErrorMessage = null;
    });

    try {
      final staff = await StaffService.fetchStaff();
      if (mounted) {
        setState(() {
          staffMembers = staff;
          isLoadingStaff = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          staffErrorMessage = e.toString();
          isLoadingStaff = false;
        });
      }
    }
  }

  Future<void> _loadProductionData() async {
    if (!mounted) return;

    setState(() {
      isLoadingProduction = true;
      productionErrorMessage = null;
    });

    try {
      final batches = await ProductionBatchService.fetchProductionBatches();
      if (mounted) {
        setState(() {
          productionBatches = batches;
          isLoadingProduction = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          productionErrorMessage = e.toString();
          isLoadingProduction = false;
        });
      }
    }
  }

  Future<void> _refreshData() async => await _loadData();
  Future<void> _refreshStaffData() async => await _loadStaffData();
  Future<void> _refreshProductionData() async => await _loadProductionData();

  void _showInventoryAlerts() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimensions.borderRadius)),
      ),
      builder: (context) => InventoryAlertsBottomSheet(
        alerts: inventoryAlerts,
        onReorderPressed: _reorderItem,
      ),
    );
  }

  void _showAddProductionBatch() {
    showDialog(
      context: context,
      builder: (context) => const AddBatchDialog(),
    );
  }

  void _reorderItem(Map<String, dynamic> alert) {
    Navigator.pop(context); // Close bottom sheet
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reorder request sent for ${alert['item']}'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductionTab(
            batches: productionBatches,
            isLoading: isLoadingProduction,
            errorMessage: productionErrorMessage,
            onRefresh: _refreshProductionData,
            onAddBatch: _showAddProductionBatch,
          ),
          StaffTab(
            staffMembers: staffMembers,
            isLoading: isLoadingStaff,
            errorMessage: staffErrorMessage,
            onRefresh: _refreshStaffData,
          ),
          OverviewTab(
            batches: productionBatches,
            staffMembers: staffMembers,
            inventoryAlerts: inventoryAlerts,
            onRefresh: _refreshData,
            onAddBatch: _showAddProductionBatch,
            onShowInventoryAlerts: _showInventoryAlerts,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.darkGreen,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.productionMonitor,
            style: TextStyle(
              color: AppColors.textWhite,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            nurseryName,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: [
        _buildInventoryButton(),
        IconButton(
          icon: const Icon(Icons.add, color: AppColors.textWhite),
          onPressed: _showAddProductionBatch,
        ),
        IconButton(
          icon: const Icon(Icons.refresh, color: AppColors.textWhite),
          onPressed: _refreshData,
        ),
      ],
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: AppColors.textWhite,
        labelColor: AppColors.textWhite,
        unselectedLabelColor: Colors.white70,
        tabs: const [
          Tab(text: AppStrings.production),
          Tab(text: AppStrings.staff),
          Tab(text: AppStrings.overview),
        ],
      ),
    );
  }

  Widget _buildInventoryButton() {
    final highUrgencyAlerts = inventoryAlerts.where((alert) => alert['urgency'] == 'High').length;
    
    return Stack(
      children: [
        IconButton(
          icon: const Icon(Icons.inventory, color: AppColors.textWhite),
          onPressed: _showInventoryAlerts,
        ),
        if (highUrgencyAlerts > 0)
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}