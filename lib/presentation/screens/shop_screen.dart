import 'package:agri/core/colors/colors.dart';
import 'package:agri/core/data/inventory_data_service.dart';
import 'package:agri/core/utils/app_text_style.dart';
import 'package:agri/presentation/widgets/shop/custom_appbar.dart';
import 'package:agri/presentation/widgets/shop/dialog/add_product_dialog.dart';
import 'package:agri/presentation/widgets/shop/dialog/price_update_dialog.dart';
import 'package:agri/presentation/widgets/shop/dialog/reorder_dialog.dart';
import 'package:agri/presentation/widgets/shop/inventory_tab.dart';
import 'package:agri/presentation/widgets/shop/order_tab.dart';
import 'package:agri/presentation/widgets/shop/product_tab.dart';
import 'package:flutter/material.dart';

class InventoryManagementScreen extends StatefulWidget {
  const InventoryManagementScreen({super.key});

  @override
  State<InventoryManagementScreen> createState() => _InventoryManagementScreenState();
}

class _InventoryManagementScreenState extends State<InventoryManagementScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final InventoryRepository _repository = InventoryRepository();

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
      appBar: CustomAppBar(
        title: 'Shop & Inventory',
        subtitle: 'Nursery Business Management',
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business, color: AppColors.white),
            onPressed: _showAddProduct,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: AppColors.white),
            onPressed: _showPendingOrders,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.white,
          labelColor: AppColors.white,
          unselectedLabelColor: AppColors.white.withOpacity(0.7),
          tabs: const [
            Tab(text: 'Inventory'),
            Tab(text: 'Orders'),
            Tab(text: 'Products'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          InventoryTab(
            inventory: _repository.getInventoryItems(),
            lowStockItems: _repository.getLowStockItems(),
            totalInventoryValue: _repository.getTotalInventoryValue(),
            onReorderAll: _showReorderDialog,
          ),
          OrdersTab(
            orders: _repository.getOrders(),
            pendingOrders: _repository.getPendingOrders(),
            totalRevenue: _repository.getTotalRevenue(),
          ),
          ProductsTab(
            products: _repository.getProducts(),
            totalAvailable: _repository.getTotalAvailableProducts(),
            totalSold: _repository.getTotalSoldProducts(),
            averageRating: _repository.getAverageRating(),
            onAddProduct: _showAddProduct,
            onUpdatePrices: _showPriceUpdate,
          ),
        ],
      ),
    );
  }

  void _showReorderDialog() {
    showDialog(
      context: context,
      builder: (context) => const ReorderDialog(),
    );
  }

  void _showAddProduct() {
    showDialog(
      context: context,
      builder: (context) => const AddProductDialog(),
    );
  }

  void _showPriceUpdate() {
    showDialog(
      context: context,
      builder: (context) => const PriceUpdateDialog(),
    );
  }

  void _showPendingOrders() {
    final pendingOrders = _repository.getPendingOrders();
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pending Orders', style: AppTextStyles.heading3),
            const SizedBox(height: 12),
            ...pendingOrders.map((order) => ListTile(
              title: Text('${order.customerName} - Rs. ${order.totalAmount}'),
              subtitle: Text('${order.status} • ${order.paymentStatus}'),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.darkGreen),
                child: const Text('Process'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}