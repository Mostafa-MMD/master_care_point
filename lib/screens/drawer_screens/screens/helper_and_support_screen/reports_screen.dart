import 'package:flutter/material.dart';
import 'package:graduation/components/appBar/reusableAppBar.dart';
import 'package:graduation/components/items/item_card.dart';

class ReportsScreen extends StatelessWidget {
  ReportsScreen({super.key});

  static String reportsScreenRoute = 'reports screen';
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
                onPressed: () {},
              ),
              ItemCard(
                leading: 'assets/reports_icon/loss.png',
                title: 'Lowest Selling Products',
                subtitle: 'This Report For Lowest Selling Products',
                textButton: textButton,
                onPressed: () {},
              ),
              ItemCard(
                leading: 'assets/reports_icon/expiry.png',
                title: 'Products Expiry In Stock',
                subtitle: 'This Report For Products Expiry In Stock',
                textButton: textButton,
                onPressed: () {},
              ),
              ItemCard(
                leading: 'assets/reports_icon/product.png',
                title: 'Safety Limit For Products',
                subtitle: 'This Report For Safety Limit For Products',
                textButton: textButton,
                onPressed: () {},
              ),
              ItemCard(
                leading: 'assets/reports_icon/ready-stock.png',
                title: 'Products Available Stock',
                subtitle: 'This Report For Products Available Stock',
                textButton: textButton,
                onPressed: () {},
              ),
              ItemCard(
                leading: 'assets/reports_icon/inventory.png',
                title: 'Inventory For Products',
                subtitle: 'This Report For Inventory For Products',
                textButton: textButton,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
