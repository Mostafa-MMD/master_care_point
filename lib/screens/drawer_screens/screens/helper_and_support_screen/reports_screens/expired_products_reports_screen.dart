import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation/models/reports/expired_product_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/appBar/reusableAppBar.dart';
import '../../../../../components/items/custom_item_report_show_data.dart';

class ApiService {
  static const String apiUrl = 'http://185.132.55.54:8000/productexpiry/';

  static Future<List<ExpiredProduct>> getExpiredProducts() async {
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> productsJson = data['expired_products'];
      return productsJson
          .map((productJson) => ExpiredProduct.fromJson(productJson))
          .toList();
    } else {
      throw Exception('Failed to load expired products');
    }
  }
}

class ExpiredProductsReportsScreen extends StatefulWidget {
  static String expiredProductsReportScreenRoute =
      'expired products report screen route';

  const ExpiredProductsReportsScreen({super.key});

  @override
  _ExpiredProductsReportsScreenState createState() =>
      _ExpiredProductsReportsScreenState();
}

class _ExpiredProductsReportsScreenState
    extends State<ExpiredProductsReportsScreen> {
  late Future<List<ExpiredProduct>> _expiredProductsFuture;

  @override
  void initState() {
    super.initState();
    _expiredProductsFuture = ApiService.getExpiredProducts();
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
        title: 'Available Stock',
      ),
      body: FutureBuilder<List<ExpiredProduct>>(
        future: _expiredProductsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ExpiredProduct> expiredProducts = snapshot.data!;
            return ListView.builder(
              itemCount: expiredProducts.length,
              itemBuilder: (context, index) {
                ExpiredProduct product = expiredProducts[index];
                return CustomItemReportShowData(
                  leading: product.image,
                  subtitle:
                      'Expired In${product.expDate}   Product Code ${product.productCode}',
                  title: product.proName,
                  valueData: '${product.stock} In Stock',
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

/*

listTile(
                  leading: Image.network(product.image),
                  title: Text(product.proName),
                  subtitle: Text('Expired in${product.expDate}  OroCode ${product.productCode}'),
                  trailing: Text('${product.stock} in stock'),
                );
*/

/*
CustomExpiredReport(

                  leading: product.image,
                  title:product.proName,
                  subtitle:
                      'Expired in${product.expDate}  OroCode ${product.productCode}',
                   valueData: '${product.stock} in stock',
                );
*/
