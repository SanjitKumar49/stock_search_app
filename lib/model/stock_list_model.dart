class StockListModel {
  final int id;
  final String name;
  final String symbol;
  final String imageUrl;


  StockListModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.imageUrl,
  });

  // Factory constructor to create Stock from JSON response
  factory StockListModel.fromJson(Map<String, dynamic> json) {
    return StockListModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      imageUrl: json['image'] != null ? json['image']['url'] : '', // Handling image
    );
  }
}
