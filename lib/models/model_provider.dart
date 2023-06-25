import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graduation/models/data_product_model.dart';
import 'package:graduation/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ModelProvider with ChangeNotifier {
  List<DataProductModel> selectedProduct = [];
  List<DataProductModel> selectedProductOrders = [];
  double totalPrice = 0.0; // Total price for all products
  Map<DataProductModel, double> productTotals = {};
  double totalPriceOneProduct = 0.0; // Total price of one product
  double totalPriceAllProducts = 0.0; // Total price of all products

  //List productsList = [];
  dynamic productPrice = 0;

  void add(DataProductModel product) {
    selectedProduct.add(product);
    calculateTotalPrice();
    notifyListeners();
  }

  void remove(DataProductModel product) {
    selectedProduct.remove(product);
    calculateTotalPrice();
    notifyListeners();
  }

  int get itemModelLength {
    return selectedProduct.length;
  }

  void addOrder(DataProductModel productOrder) {
    selectedProductOrders.add(productOrder);
    notifyListeners();
  }

  void moveToOrderScreen() {
    for (var product in selectedProduct) {
      addOrder(product);
    }
    notifyListeners();
  }

  void removeItemOfList() {
    selectedProduct.clear();
    calculateTotalPrice();
    notifyListeners();
  }

  int _randomNumber = 0;

  int get productOrderId => _randomNumber;

  int generateRandomNumber() {
    final random = Random();
    _randomNumber = random.nextInt(12587800);
    return _randomNumber;
    notifyListeners();
  }

  void increaseQuantity(DataProductModel product) {
    product.productQuantity++;
    calculateTotalPrice();
    notifyListeners();
  }

  void decreaseQuantity(DataProductModel product) {
    if (product.productQuantity > 1) {
      product.productQuantity--;
      calculateTotalPrice();
      notifyListeners();
    }
  }

  void calculateTotalPrice() {
    double totalOneProduct = 0.0; // Reset the total value of one product
    totalPriceAllProducts = 0.0; // Clear the previous product totals

    for (var product in selectedProduct) {
      totalOneProduct = product.productPrice * product.productQuantity;
      totalPriceAllProducts += totalOneProduct;
    }
    totalPriceOneProduct = totalOneProduct;
  }

  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  final String loginApi = 'http://185.132.55.54:8000/login/';
  final String registerApi = 'http://185.132.55.54:8000/register/';
  final String logoutApi = 'http://185.132.55.54:8000/logout/';

  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final TextEditingController firstNameRegisterController =
      TextEditingController();
  final TextEditingController lastNameRegisterController =
      TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController phoneNumberRegisterController =
      TextEditingController();
  final TextEditingController addressRegisterController =
      TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();

// Login Method:

  Future<void> loginUser(BuildContext context) async {
    final url = Uri.parse('http://185.132.55.54:8000/login/');

    try {
      final response = await http.post(
        url,
        body: {
          'email': Provider.of<ModelProvider>(context, listen: false)
              .emailLoginController
              .text,
          'password': Provider.of<ModelProvider>(context, listen: false)
              .passwordLoginController
              .text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );

        loginFormKey.currentState?.reset();

        Navigator.pushNamedAndRemoveUntil(
          context,
          MainScreen.homeScreenRoute,
          (route) => false,
        );
      } else if (response.statusCode == 404) {
        // Email or password incorrect
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      } else {
        // Other error occurred
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed')),
        );
      }
    } catch (e) {
      // Error occurred
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

// Register Method:

  Future<void> registerUser(BuildContext context) async {
    final url = Uri.parse('http://185.132.55.54:8000/register/');

    try {
      final response = await http.post(
        url,
        body: {
          'first_name': firstNameRegisterController.text,
          'last_name': lastNameRegisterController.text,
          'email': emailRegisterController.text,
          'phone_number': phoneNumberRegisterController.text,
          'address': addressRegisterController.text,
          'password': passwordRegisterController.text,
        },
      );

      if (response.statusCode == 201) {
        print('Registration successful');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful'),
          ),
        );
        registerFormKey.currentState?.reset();
      } else {
        print('Registration failed');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration failed'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  // method show data in information screen:
  Map<String, dynamic>? _userData;

  Map<String, dynamic>? getUserData() => _userData;

  Future<void> sendPostRequest(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'email': emailLoginController.text,
        'password': passwordLoginController.text,
      };
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.post(Uri.parse(loginApi),
          headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        // Success
        var responseBody = jsonDecode(response.body);
        Provider.of<ModelProvider>(context, listen: false)
            .userDataMethod(responseBody);
      } else {
        // Error
        print('Error: ${response.reasonPhrase}');
      }
    }
  }

  void userDataMethod(Map<String, dynamic>? userData) {
    _userData = userData;
    notifyListeners();
  }

  // log out method:
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Future<void> logoutUser(BuildContext context) async {
    Map<String, dynamic> data = {
      'email': emailLoginController.text,
      'password': passwordLoginController.text,
    };
    var response = await http.post(Uri.parse(logoutApi),
        headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      // Success
      var responseBody = jsonDecode(response.body);
      emailLoginController.clear();
      passwordLoginController.clear();
      print(responseBody);
      print(response.statusCode);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout successful'),
        ),
      );
    } else {
      // Error
      print('Error: ${response.reasonPhrase}');
      print('error in logout');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout failed'),
        ),
      );
    }
  }

  // override to all controller:
  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    firstNameRegisterController.dispose();
    lastNameRegisterController.dispose();
    phoneNumberRegisterController.dispose();
    addressRegisterController.dispose();
    super.dispose();
  }

  Future<void> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://185.132.55.54:8000/products/'));
    final jsonData = json.decode(response.body);
    var allProducts = jsonData
        .map<DataProductModel>((product) => DataProductModel(
              productId: product["id"],
              productName: product["pro_name"],
              productPrice: product["price"],
              productDescription: product["description"],
              productImage: product["image"],
              productState: product["stock"],
            ))
        .toList();
  }

  final Uri apiEndpoint =
      Uri.parse('http://185.132.55.54:8000/shoppingcardorder/');
  List<DataProductModel> selectedProductId = [];
  List<DataProductModel> selectedProductQuantity = [];

  void addId(DataProductModel productId) {
    selectedProductId.add(productId);
    notifyListeners();
  }

  void moveToProductId() {
    for (var product in selectedProductId) {
      addId(product);
    }
    notifyListeners();
  }

  void addQuantity(DataProductModel productQuantity) {
    selectedProductQuantity.add(productQuantity);
    notifyListeners();
  }

  void moveToProductQuantity() {
    for (var product in selectedProductQuantity) {
      addQuantity(product);
    }
    notifyListeners();
  }

  Future<void> sendPostRequestOrderList({required int userId}) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var data = {
      "user_id": userId,
      "product_ids": selectedProductId,
      "quantities": selectedProductQuantity,
    };
    var body = json.encode(data);
    try {
      var response = await http.post(apiEndpoint, headers: headers, body: body);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        print(responseBody);
        print('Response status: ${response.statusCode}');
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
