class TaxiTaxReportModel {
  int? totalSize;
  int? limit;
  String? offset;
  List<TaxSummary>? taxSummary;
  int? totalOrders;
  double? totalOrderAmount;
  double? totalTax;
  List<Orders>? orders;

  TaxiTaxReportModel({
    this.totalSize,
    this.limit,
    this.offset,
    this.taxSummary,
    this.totalOrders,
    this.totalOrderAmount,
    this.totalTax,
    this.orders,
  });

  TaxiTaxReportModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['taxSummary'] != null) {
      taxSummary = <TaxSummary>[];
      json['taxSummary'].forEach((v) {
        taxSummary!.add(TaxSummary.fromJson(v));
      });
    }
    totalOrders = json['totalOrders'];
    totalOrderAmount = json['totalOrderAmount']?.toDouble();
    totalTax = json['totalTax']?.toDouble();
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (taxSummary != null) {
      data['taxSummary'] = taxSummary!.map((v) => v.toJson()).toList();
    }
    data['totalOrders'] = totalOrders;
    data['totalOrderAmount'] = totalOrderAmount;
    data['totalTax'] = totalTax;
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TaxSummary {
  String? taxName;
  double? totalTax;
  String? taxLabel;

  TaxSummary({this.taxName, this.totalTax, this.taxLabel});

  TaxSummary.fromJson(Map<String, dynamic> json) {
    taxName = json['tax_name'];
    totalTax = json['total_tax']?.toDouble();
    taxLabel = json['tax_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tax_name'] = taxName;
    data['total_tax'] = totalTax;
    data['tax_label'] = taxLabel;
    return data;
  }
}

class Orders {
  int? id;
  double? tripAmount;
  double? taxAmount;
  String? tripType;
  String? createdAt;
  String? tripStatus;
  String? paymentStatus;
  List<OrderTaxes>? orderTaxes;

  Orders({
    this.id,
    this.tripAmount,
    this.taxAmount,
    this.tripType,
    this.createdAt,
    this.tripStatus,
    this.paymentStatus,
    this.orderTaxes,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id = json['id'];
    tripAmount = json['trip_amount']?.toDouble();
    taxAmount = json['tax_amount']?.toDouble();
    tripType = json['trip_type'];
    createdAt = json['created_at'];
    tripStatus = json['trip_status'];
    paymentStatus = json['payment_status'];
    if (json['order_taxes'] != null) {
      orderTaxes = <OrderTaxes>[];
      json['order_taxes'].forEach((v) {
        orderTaxes!.add(OrderTaxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['trip_amount'] = tripAmount;
    data['tax_amount'] = taxAmount;
    data['trip_type'] = tripType;
    data['created_at'] = createdAt;
    data['trip_status'] = tripStatus;
    data['payment_status'] = paymentStatus;
    if (orderTaxes != null) {
      data['order_taxes'] = orderTaxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderTaxes {
  int? id;
  int? orderId;
  String? taxName;
  double? taxAmount;
  String? taxType;

  OrderTaxes({
    this.id,
    this.orderId,
    this.taxName,
    this.taxAmount,
    this.taxType,
  });

  OrderTaxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    taxName = json['tax_name'];
    taxAmount = json['tax_amount']?.toDouble();
    taxType = json['tax_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['tax_name'] = taxName;
    data['tax_amount'] = taxAmount;
    data['tax_type'] = taxType;
    return data;
  }
}
