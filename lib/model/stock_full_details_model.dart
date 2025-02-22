class StockFullDetailsModel {
  final int id;
  final String name;
  final String symbol;
  final String createdAt;
  final String updatedAt;
  final String alpacaId;
  final String exchange;
  final String description;
  final String assetType;
  final String isin;
  final String industry;
  final String sector;
  final int employees;
  final String? website;
  final String? address;
  final double price;
  final double changePercent;
  final List<dynamic> holdings;
  final List<dynamic> sectorAllocation;
  final int sustainableInvestmentHoldingPercentage;
  final bool inPortfolio;

  StockFullDetailsModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
    required this.alpacaId,
    required this.exchange,
    required this.description,
    required this.assetType,
    required this.isin,
    required this.industry,
    required this.sector,
    required this.employees,
    this.website,
    this.address,
    required this.price,
    required this.changePercent,
    required this.holdings,
    required this.sectorAllocation,
    required this.sustainableInvestmentHoldingPercentage,
    required this.inPortfolio,
  });

  factory StockFullDetailsModel.fromJson(Map<String, dynamic> json) {
    return StockFullDetailsModel(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      alpacaId: json['alpaca_id'],
      exchange: json['exchange'],
      description: json['description'],
      assetType: json['asset_type'],
      isin: json['isin'],
      industry: json['industry'],
      sector: json['sector'],
      employees: json['employees'],
      website: json['website'],
      address: json['address'],
      price: json['price'],
      changePercent: json['change_percent'],
      holdings: json['holdings'] ?? [],
      sectorAllocation: json['sector_allocation'] ?? [],
      sustainableInvestmentHoldingPercentage:
          json['sustainable_investment_holding_percentage'],
      inPortfolio: json['in_portfolio'],
    );
  }
}
