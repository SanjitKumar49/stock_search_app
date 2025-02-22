import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_market_search_app/controller/home_screen_controller.dart';
import 'package:stock_market_search_app/controller/stock_details_controller.dart';
// Assuming the controller is in home_controller.dart

class StockDetailScreen extends StatelessWidget {
  final String stockId;

  StockDetailScreen({required this.stockId});
  final StockDetailsController stockDetailsController =
      Get.put(StockDetailsController());
  @override
  Widget build(BuildContext context) {
    // Get the HomeController instance
    // final homeController = Get.find<HomeScreenController>();

    // Fetch stock details when the screen is first loaded
    stockDetailsController.fetchStockDetails(stockId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Details'),
      ),
      body: Obx(() {
        if (stockDetailsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (stockDetailsController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(stockDetailsController.errorMessage.value));
        }

        if (stockDetailsController.stockDetail.value == null) {
          return Center(child: Text('No data available'));
        }

        // Get the stock detail from the controller
        final stock = stockDetailsController.stockDetail.value!;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Text("Name: ${stock.name}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8),
              Text("Symbol: ${stock.symbol}"),
              SizedBox(height: 8),
              Text("Exchange: ${stock.exchange}"),
              SizedBox(height: 8),
              Text("Price: \$${stock.price.toStringAsFixed(2)}"),
              SizedBox(height: 8),
              Text(
                  "Change Percent: ${stock.changePercent.toStringAsFixed(2)}%"),
              SizedBox(height: 8),

              SizedBox(height: 8),
              Text("Industry: ${stock.industry}"),
              SizedBox(height: 8),
              Text("Sector: ${stock.sector}"),
              SizedBox(height: 8),
              Text("Employees: ${stock.employees}"),
              if (stock.website != null) ...[
                SizedBox(height: 8),
                Text("Website: ${stock.website}"),
              ],
              if (stock.address != null) ...[
                SizedBox(height: 8),
                Text("Address: ${stock.address}"),
              ],
              SizedBox(height: 8),
              Text("Description:"),
              SizedBox(height: 4),
              Text(stock.description),

            ],
          ),
        );
      }),
    );
  }
}
