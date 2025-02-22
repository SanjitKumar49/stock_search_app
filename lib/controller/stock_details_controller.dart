import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_search_app/model/stock_full_details_model.dart';
import 'package:http/http.dart' as http;

class StockDetailsController extends GetxController{
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var stockDetail = Rx<StockFullDetailsModel?>(null);

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }


  Future<void> fetchStockDetails(String stockId) async {
    isLoading.value = true;
    errorMessage.value = ''; // Reset error message

    // Retrieve the JWT token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jwt = prefs.getString('jwt');

    if (jwt == null) {
      errorMessage.value = 'No JWT token found. Please log in again.';
      return;
    }
    print("StockId:$stockId");

    try {
      final response = await http.get(
        Uri.parse(
            'https://illuminate-production.up.railway.app/api/stocks/$stockId'),
        headers: {
          'Authorization': 'Bearer $jwt', // Add the JWT token here
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        stockDetail.value = StockFullDetailsModel.fromJson(data);
      } else {
        errorMessage.value = 'Failed to load stock details';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

}