import 'package:flutter/material.dart';
import 'package:graduation/components/appBar/reusableAppBar.dart';
import 'package:graduation/components/items/item_card.dart';
import 'package:graduation/screens/drawer_screens/screens/helper_and_support_screen/reports_screens/safety_limit_report_screen.dart';
import 'available_stock_reports_screen.dart';
import 'best_selling_report_screen.dart';
import 'expired_products_reports_screen.dart';
import 'lowest_selling_report_screen.dart';
import 'never_selling_report_screen.dart';

class MainReportsScreen extends StatelessWidget {
  MainReportsScreen({super.key});

  static String mainReportsScreenRoute = 'reports screen';
  String textButton = 'Take a Report !';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        leadingFunction: () {
          Navigator.pop(context);
        },
        title: 'Reports',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 0.0,
          ),
          child: Column(
            children: [
              ItemCard(
                leading: 'assets/reports_icon/report.png',
                title: 'Best Selling Products',
                subtitle: 'This Report For Best Selling Products',
                textButton: textButton,
                onPressed: () {
                  Navigator.pushNamed(context,
                      BestSellingReportScreen.bestSellingReportScreenRoute);
                },
              ),
              ItemCard(
                leading: 'assets/reports_icon/loss.png',
                title: 'Lowest Selling Products',
                subtitle: 'This Report For Lowest Selling Products',
                textButton: textButton,
                onPressed: () {
                  Navigator.pushNamed(context,
                      LowestSellingReportScreen.lowestSellingReportScreenRoute);
                },
              ),
              ItemCard(
                leading: 'assets/reports_icon/inventory.png',
                title: 'Products Never Selling',
                subtitle: 'This Report For Products Never Selling',
                textButton: textButton,
                onPressed: () {
                  Navigator.pushNamed(context,
                      NeverSellingReportScreen.neverSellingReportScreenRoute);
                },
              ),
              ItemCard(
                leading: 'assets/reports_icon/expiry.png',
                title: 'Products Expiry In Stock',
                subtitle: 'This Report For Products Expiry In Stock',
                textButton: textButton,
                onPressed: () {
                  Navigator.pushNamed(
                      context,
                      ExpiredProductsReportsScreen
                          .expiredProductsReportScreenRoute);
                },
              ),
              ItemCard(
                leading: 'assets/reports_icon/product.png',
                title: 'Safety Limit For Products',
                subtitle: 'This Report For Safety Limit For Products',
                textButton: textButton,
                onPressed: () {
                  Navigator.pushNamed(context,
                      SafetyLimitReportScreen.safetyLimitReportScreenRoute);
                },
              ),
              ItemCard(
                leading: 'assets/reports_icon/ready-stock.png',
                title: 'Products Available Stock',
                subtitle: 'This Report For Products Available Stock',
                textButton: textButton,
                onPressed: () {
                  Navigator.pushNamed(
                      context,
                      AvailableStockReportScreen
                          .availableStockReportScreenRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
