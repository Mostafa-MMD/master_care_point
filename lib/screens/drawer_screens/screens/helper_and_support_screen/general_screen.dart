import 'package:flutter/material.dart';
import 'package:graduation/components/appBar/reusableAppBar.dart';
import 'package:graduation/screens/drawer_screens/screens/share_app_screen.dart';
import 'help_and_support_screen.dart';

class GeneralScreen extends StatelessWidget {
  const GeneralScreen({Key? key}) : super(key: key);
  static String generalScreenRoute = 'general screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        leadingFunction: () {
          Navigator.pop(context);
        },
        title: 'General',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 7.0,
          ),
          child: Column(
            children: const [
              ShareAppScreen(),
              HelpAndSupportScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
