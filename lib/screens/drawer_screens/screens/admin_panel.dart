import 'package:flutter/material.dart';
import 'package:graduation/components/appBar/reusableAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);
  static String adminPanelRoute = 'admin panel screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(
        leadingFunction: () {
          Navigator.pop(context);
        },
        title: 'Admin panel',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Container(
                  height: 200.0,
                  child: Image.asset('assets/images/Adminpanal.png'),
                ),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    Container(
                      width: 175.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 5),
                            color: Colors.grey,
                            blurRadius: 3.0,
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          colors: [
                            Colors.blue,
                            Colors.blue.shade900,
                          ],
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          launch('http://185.132.55.54:8000/admin/');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: const [
                              Text(
                                'Admin panel',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_outward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
