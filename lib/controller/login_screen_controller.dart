import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stock_market_search_app/screens/home_screen.dart';

class LoginScreenController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  /// using user id and password do login call
  Future<void> doLogin(String identifier, String password) async {
    isLoading(true);
    isError(false);
    errorMessage('');

    try {
      var url = Uri.parse(
          'https://illuminate-production.up.railway.app/api/auth/local');
      var response = await http.post(url, body: {
        "identifier": identifier,
        "password": password,
      });

      if (response.statusCode == 200) {
        // Parse the response
        var data = json.decode(response.body);
        String jwt = data['jwt'];
        var user = data['user'];

        // Save the JWT and user info in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt', jwt);
        await prefs.setString('user', json.encode(user));

        // Navigate to the home page or dashboard
        Get.offAll(() => HomeScreen(), transition: Transition.rightToLeft);
      } else {
        isError(true);
        errorMessage('Invalid credentials');
      }
    } catch (e) {
      isError(true);
      errorMessage('An error occurred. Please try again later.');
    } finally {
      isLoading(false);
    }
  }
}
