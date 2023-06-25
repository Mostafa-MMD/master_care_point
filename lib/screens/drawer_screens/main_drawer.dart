import 'package:flutter/material.dart';
import 'package:graduation/constants/colors.dart';
import 'package:graduation/models/model_provider.dart';
import 'package:graduation/screens/drawer_screens/screens/about_screen.dart';
import 'package:graduation/screens/drawer_screens/screens/admin_panel.dart';
import 'package:graduation/screens/drawer_screens/screens/helper_and_support_screen/general_screen.dart';
import 'package:graduation/screens/drawer_screens/screens/rate_screen.dart';
import 'package:graduation/screens/drawer_screens/screens/helper_and_support_screen/reports_screens/main_reports_screen.dart';
import 'package:graduation/screens/drawer_screens/screens/user_information_screen.dart';
import 'package:graduation/screens/sign_screens/login_screen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/medicine2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              iconColor: defBlue,
              leading: const Icon(Icons.account_tree_outlined),
              title: const Text(
                'General',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: defDeepPurple,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, GeneralScreen.generalScreenRoute);
              },
            ),
            const Divider(
              height: 15.0,
              thickness: 0.7,
            ),
            ListTile(
              iconColor: defBlue,
              leading: const Icon(Icons.admin_panel_settings_outlined),
              title: const Text(
                'Admin panel',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: defDeepPurple,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, AdminPanel.adminPanelRoute);
              },
            ),
            const Divider(
              height: 15.0,
              thickness: 0.7,
            ),
            ListTile(
              iconColor: defBlue,
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text(
                'Reports',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: defDeepPurple,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                    context, MainReportsScreen.mainReportsScreenRoute);
              },
            ),
            const Divider(
              height: 15.0,
              thickness: 0.7,
            ),
            ListTile(
              iconColor: defBlue,
              leading: const Icon(Icons.star_rate_outlined),
              title: const Text(
                'Rate',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: defDeepPurple,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, RateScreen.rateScreenRoute);
              },
            ),
            const Divider(
              height: 15.0,
              thickness: 0.7,
            ),
            Consumer<ModelProvider>(
              builder: (context, classInstance, child) {
                return ListTile(
                  iconColor: defBlue,
                  leading: const Icon(Icons.person_outline),
                  title: const Text(
                    'User',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: defDeepPurple,
                    ),
                  ),
                  onTap: () async {
                    Navigator.pushNamed(context,
                        UserInformationScreen.userInformationScreenRoute);
                  },
                );
              },
            ),
            const Divider(
              height: 15.0,
              thickness: 0.7,
            ),
            ListTile(
              iconColor: defBlue,
              leading: const Icon(Icons.important_devices_outlined),
              title: const Text(
                'About',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: defDeepPurple,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, AboutScreen.aboutScreenRoute);
              },
            ),
            const Divider(
              height: 15.0,
              thickness: 0.7,
            ),
            ListTile(
              iconColor: defBlue,
              leading: const Icon(Icons.logout_outlined),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: defDeepPurple,
                ),
              ),
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.loginScreenRoute, (route) => false);
              },
            ),
            const Divider(
              height: 15.0,
              thickness: 0.7,
            ),
          ],
        ),
      ),
    );
  }
}
