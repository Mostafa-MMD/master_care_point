import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/appBar/reusableAppBar.dart';
import '../../../../../components/items/custom_item_report_show_data.dart';
import '../../../../../models/reports/best_selling_report_model.dart';

class ApiService {
  static const String apiUrl = 'http://185.132.55.54:8000/Bestsellingproducts/';

  static Future<List<BestSellingProduct>> getHighSellingProduct() async {
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> productsJson = data['high_selling_products'];
      return productsJson
          .map((productJson) => BestSellingProduct.fromJson(productJson))
          .toList();
    } else {
      throw Exception('Failed to load expired products');
    }
  }
}

class BestSellingReportScreen extends StatefulWidget {
  static String bestSellingReportScreenRoute = 'best selling report screen';

  const BestSellingReportScreen({super.key});

  @override
  _BestSellingReportScreenState createState() =>
      _BestSellingReportScreenState();
}

class _BestSellingReportScreenState extends State<BestSellingReportScreen> {
  late Future<List<BestSellingProduct>> _expiredProductsFuture;

  @override
  void initState() {
    super.initState();
    _expiredProductsFuture = ApiService.getHighSellingProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        leadingFunction: () {
          // Navigator.pushNamedAndRemoveUntil(context,
          //     MainReportsScreen.mainReportsScreenRoute, (route) => false);
          Navigator.pop(context);
        },
        title: 'Best Selling',
      ),
      body: FutureBuilder<List<BestSellingProduct>>(
        future: _expiredProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<BestSellingProduct> expiredProducts = snapshot.data!;
            return ListView.builder(
              itemCount: expiredProducts.length,
              itemBuilder: (context, index) {
                BestSellingProduct product = expiredProducts[index];
                return CustomItemReportShowData(
                  leading: product.image,
                  title: product.proName,
                  subtitle: '\$ ${product.price}'.toString(),
                  valueData: '${product.sales} Sales',
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading expired products'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
