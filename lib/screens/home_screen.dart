import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_market_search_app/controller/home_screen_controller.dart';
import 'package:stock_market_search_app/model/stock_list_model.dart';

import 'stock_details_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeScreenController homeController = Get.put(HomeScreenController());
  final TextEditingController stockNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: Get.width,
        height: Get.height,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    width: Get.width * 0.8,
                    height: Get.height * 0.06,
                    color: Colors.grey,
                    alignment: Alignment.center,
                    child: const Text(
                      'Welcome to Home Screen!',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                    )),
                InkWell(
                  onTap: () {
                    // Call logout method from HomeScreenController
                    homeController.logout();
                  },
                  child: Container(
                    width: Get.width * 0.2,
                    height: Get.height * 0.06,
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
              width: Get.width * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: Get.width * 0.8,
                    child: TextField(
                      controller: stockNameController,
                      decoration: const InputDecoration(
                        labelText: 'Stock Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.stacked_bar_chart),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  InkWell(
                      onTap: () {
// Call the search function
                        homeController.searchStock(stockNameController.text);
                      },
                      child: Icon(
                        Icons.search,
                        size: 40,
                      ))
                ],
              ),
            ),

            Expanded(
              child: Obx(
                () {
                  if (homeController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (homeController.errorMessage.value.isNotEmpty) {
                    return Center(
                        child: Text(homeController.errorMessage.value));
                  }
                  return ListView.builder(
                    itemCount: homeController.stockList.length,
                    itemBuilder: (context, index) {
                      StockListModel stock = homeController.stockList[index];
                      return ListTile(
                        leading: stock.imageUrl.isNotEmpty
                            ? Image.network(stock.imageUrl, width: 50, height: 50)
                            : Container(width: 50, height: 50, color: Colors.grey),
                        subtitle: Text(stock.symbol),
                        title: Text(stock.name),
                        onTap: () {
                          // Show detailed information of the clicked stock
                          Get.to(StockDetailScreen(stockId: stock.id.toString(),),
                              transition: Transition.rightToLeft);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            // SizedBox(height: 10),
            // InkWell(
            //   onTap: () {},
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(12.0),
            //     child: Container(
            //       width: Get.width * 0.9,
            //       height: Get.height * 0.15,
            //       color: Colors.grey,
            //       alignment: Alignment.center,
            //       child: const Text(
            //         "Search Stock",
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 18,
            //             fontWeight: FontWeight.w600),
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      )),
    );
  }
}
