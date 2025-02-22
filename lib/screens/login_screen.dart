import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_market_search_app/controller/login_screen_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginScreenController loginController =
      Get.put(LoginScreenController());

  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.blue,
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Text(
                "Welcome to Stock Search App",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              TextField(
                controller: userIdController,
                decoration: const InputDecoration(
                  labelText: 'User Id',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 20),
              loginController.isLoading.value
                  ? const CircularProgressIndicator()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: InkWell(
                        onTap: () {
                          if (userIdController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            loginController.doLogin(
                              userIdController.text,
                              passwordController.text,
                            );
                          } else {
                            Get.snackbar("Wrong Credentials",
                                "Please enter your user id and password");
                          }
                        },
                        child: Container(
                          width: Get.width * 0.6,
                          height: Get.height * 0.06,
                          color: Colors.grey,
                          alignment: Alignment.center,
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              loginController.isError.value
                  ? Text(
                      loginController.errorMessage.value,
                      style: TextStyle(color: Colors.red),
                    )
                  : Container(),
            ],
          ),
        );
      }),
    );
  }
}
