import 'package:flutter/material.dart';

class ItemReports extends StatelessWidget {
  ItemReports({
    super.key,
    required this.image,
    required this.description,
  });

  String image;
  String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 180.0,
          width: 160.0,
          color: Colors.cyan[400],
          child: Column(
            children: [
              const SizedBox(
                height: 5.0,
              ),
              Expanded(
                child: Container(
                  child: Image.asset(
                    image,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 25.0, //25.0
                ),
                child: Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              // SizedBox(height: 2.0,),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Take a Report'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
