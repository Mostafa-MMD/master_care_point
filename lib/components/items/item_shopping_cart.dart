import 'package:flutter/material.dart';
import 'package:graduation/constants/colors.dart';
import 'package:graduation/models/data_product_model.dart';
import 'package:provider/provider.dart';
import 'package:graduation/models/model_provider.dart';

class ItemShoppingCart extends StatelessWidget {
  ItemShoppingCart({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.totalPrice,
    required this.onPressed,
    required this.productModel,
  }) : super(key: key);

  String image;
  String name;
  String price;
  String totalPrice;
  Function() onPressed;
  DataProductModel productModel;

  @override
  Widget build(BuildContext context) {
    int number = 1;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFEFCFF),
          boxShadow: const [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: MediaQuery.of(context).size.height / 5.5,
        child: Consumer<ModelProvider>(
          builder: (context, modelProvider, child) {
            return Row(
              children: [
                Container(
                  height: 112, //90
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 20,
                  ),
                  child: Image.network(
                    image,
                    width: 110,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      name,
                      maxLines: 1,
                      style: const TextStyle(
                        color: defDeepPurple,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          'price: ',
                          style: TextStyle(
                            fontSize: 18,
                            color: defBlue,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 15,
                            color: defDeepPurple,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 7.0),
                      child: IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          Icons.cancel_outlined,
                          color: defBlue,
                          size: 25,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 25.0,
                          child: FloatingActionButton(
                            heroTag: UniqueKey(),
                            mini: true,
                            backgroundColor: defBlue,
                            onPressed: () {
                              modelProvider.increaseQuantity(productModel);
                            },
                            child: const Icon(
                              Icons.add,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: defDeepPurple[50],
                          child: Text(
                            '${productModel.productQuantity}',
                            maxLines: 1,
                            style: const TextStyle(
                              color: defDeepPurple,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          width: 25.0,
                          child: FloatingActionButton(
                            heroTag: UniqueKey(),
                            mini: true,
                            backgroundColor: defBlue,
                            onPressed: () {
                              modelProvider.decreaseQuantity(productModel);
                            },
                            child: const Icon(
                              Icons.remove,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
