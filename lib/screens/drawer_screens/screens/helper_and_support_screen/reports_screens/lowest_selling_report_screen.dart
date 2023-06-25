import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation/models/reports/low_sales_product_model.dart';
import 'package:http/http.dart' as http;
import '../../../../../components/appBar/reusableAppBar.dart';
import '../../../../../components/items/custom_item_report_show_data.dart';

Future<Map<String, dynamic>> fetchData() async {
  final response = await http
      .get(Uri.parse('http://185.132.55.54:8000/lowestsellingproduts/'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

List<LowSalesProduct> parseLowSalesProducts(dynamic responseBody) {
  final parsed = responseBody['data']['Sales_are_less_than_10']
      .cast<Map<String, dynamic>>();
  return parsed
      .map<LowSalesProduct>((json) => LowSalesProduct.fromJson(json))
      .toList();
}

class LowestSellingReportScreen extends StatefulWidget {
  static String lowestSellingReportScreenRoute = 'lowest selling report screen';

  const LowestSellingReportScreen({super.key});

  @override
  _LowestSellingReportScreenState createState() =>
      _LowestSellingReportScreenState();
}

class _LowestSellingReportScreenState extends State<LowestSellingReportScreen> {
  late Future<Map<String, dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
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
        title: 'Lowest Selling',
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _futureData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //final lowSalesProducts = parseProducts(snapshot.data!);
            final lowSalesProducts = parseLowSalesProducts(snapshot.data!);
            return ListView.builder(
                shrinkWrap: true,
                itemCount: lowSalesProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomItemReportShowData(
                    leading: lowSalesProducts[index].image,
                    subtitle: '\$ ${lowSalesProducts[index].price}'.toString(),
                    title: lowSalesProducts[index].name,
                    valueData:
                        '${lowSalesProducts[index].totalSales} Total Sales'
                            .toString(),
                  );
                });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading low selling products'),
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
