import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_search_app/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:stock_market_search_app/model/stock_list_model.dart';

class HomeScreenController extends GetxController {
  var stockList = <StockListModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  // Logout function to clear session and navigate to LoginScreen
  Future<void> logout() async {
    // Clear JWT and user data from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt');
    await prefs.remove('user');

    // Navigate to the LoginScreen and clear navigation stack
    Get.offAll(() => LoginScreen());
  }

  // Function to fetch stocks based on search query
  Future<void> searchStock(String query) async {
    isLoading.value = true;
    errorMessage.value = ''; // Reset error message
    print("StackName:$query");

    // Retrieve the JWT token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    if (jwt == null) {
      errorMessage.value = 'Please log in again.';
      return;
    }

    // Encode the query to handle special characters
    // String encodedQuery = Uri.encodeQueryComponent(query);

    try {
      // Make the GET request with Authorization header
      final response = await http.get(
        Uri.parse(
            'https://illuminate-production.up.railway.app/api/stocks/search?query=$query'),
        headers: {
          'Authorization': 'Bearer $jwt', // Add the JWT token here
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        stockList.value = data.map((e) => StockListModel.fromJson(e)).toList();
      } else {
        // List<dynamic> data = json.decode();
        print("DataIS:${json.decode(response.body)}");
        errorMessage.value = 'Failed to load stocks';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

}
