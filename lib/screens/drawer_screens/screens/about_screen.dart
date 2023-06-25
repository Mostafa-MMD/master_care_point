import 'package:flutter/material.dart';
import 'package:graduation/components/appBar/reusableAppBar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static String aboutScreenRoute = 'about screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        leadingFunction: () {
          Navigator.pop(context);
        },
        title: 'About',
      ),
      body: Column(
        children: const [
          SizedBox(height: 20),
          Image(
            image: AssetImage('assets/images/ph00.png'),
            width: 500,
            height: 500,
          ),
          SelectableText(
            'Contact Email: pharmacy@Example.com',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Copyrights © 2023',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
