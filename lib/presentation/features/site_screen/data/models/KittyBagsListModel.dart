class KittyBagsListModel {
  Response response;
  String respCode;
  String respMsg;

  KittyBagsListModel({this.response, this.respCode, this.respMsg});

  KittyBagsListModel.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    respCode = json['respCode'];
    respMsg = json['respMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response.toJson();
    }
    data['respCode'] = this.respCode;
    data['respMsg'] = this.respMsg;
    return data;
  }
}

class Response {
  List<KittyPointsList> kittyPointsList;
  List<ReservePoolList> reservePoolList;
  int totalInvoiceSupplyBags;
  int totalKittyPoints;
  int totalKittyBags;
  int totalKittyPointsForKittyPointsList;
  int totalKittyPointsForReservePoolList;
  int totalInvoiceSupplyBagsForKittyPointsList;
  int totalInvoiceSupplyForReservePoolList;
  int totalKittyBagsForKittyPointsList;
  int totalKittyBagsForReservePoolList;

  Response(
      {this.kittyPointsList,
        this.reservePoolList,
        this.totalInvoiceSupplyBags,
        this.totalKittyPoints,
        this.totalKittyBags,
        this.totalKittyPointsForKittyPointsList,
        this.totalKittyPointsForReservePoolList,
        this.totalInvoiceSupplyBagsForKittyPointsList,
        this.totalInvoiceSupplyForReservePoolList,
        this.totalKittyBagsForKittyPointsList,
        this.totalKittyBagsForReservePoolList});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['kittyPointsList'] != null) {
      kittyPointsList = new List<KittyPointsList>();
      json['kittyPointsList'].forEach((v) {
        kittyPointsList.add(new KittyPointsList.fromJson(v));
      });
    }
    if (json['reservePoolList'] != null) {
      reservePoolList = new List<ReservePoolList>();
      json['reservePoolList'].forEach((v) {
        reservePoolList.add(new ReservePoolList.fromJson(v));
      });
    }
    totalInvoiceSupplyBags = json['totalInvoiceSupplyBags'];
    totalKittyPoints = json['totalKittyPoints'];
    totalKittyBags = json['totalKittyBags'];
    totalKittyPointsForKittyPointsList =
    json['totalKittyPointsForKittyPointsList'];
    totalKittyPointsForReservePoolList =
    json['totalKittyPointsForReservePoolList'];
    totalInvoiceSupplyBagsForKittyPointsList =
    json['totalInvoiceSupplyBagsForKittyPointsList'];
    totalInvoiceSupplyForReservePoolList =
    json['totalInvoiceSupplyForReservePoolList'];
    totalKittyBagsForKittyPointsList = json['totalKittyBagsForKittyPointsList'];
    totalKittyBagsForReservePoolList = json['totalKittyBagsForReservePoolList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kittyPointsList != null) {
      data['kittyPointsList'] =
          this.kittyPointsList.map((v) => v.toJson()).toList();
    }
    if (this.reservePoolList != null) {
      data['reservePoolList'] =
          this.reservePoolList.map((v) => v.toJson()).toList();
    }
    data['totalInvoiceSupplyBags'] = this.totalInvoiceSupplyBags;
    data['totalKittyPoints'] = this.totalKittyPoints;
    data['totalKittyBags'] = this.totalKittyBags;
    data['totalKittyPointsForKittyPointsList'] =
        this.totalKittyPointsForKittyPointsList;
    data['totalKittyPointsForReservePoolList'] =
        this.totalKittyPointsForReservePoolList;
    data['totalInvoiceSupplyBagsForKittyPointsList'] =
        this.totalInvoiceSupplyBagsForKittyPointsList;
    data['totalInvoiceSupplyForReservePoolList'] =
        this.totalInvoiceSupplyForReservePoolList;
    data['totalKittyBagsForKittyPointsList'] =
        this.totalKittyBagsForKittyPointsList;
    data['totalKittyBagsForReservePoolList'] =
        this.totalKittyBagsForReservePoolList;
    return data;
  }
}

class KittyPointsList {
  String productName;
  int invoiceSupplyBags;
  int kittyPoints;
  int kittyBags;

  KittyPointsList({this.productName,
    this.invoiceSupplyBags,
    this.kittyPoints,
    this.kittyBags});

  KittyPointsList.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    invoiceSupplyBags = json['invoiceSupplyBags'];
    kittyPoints = json['kittyPoints'];
    kittyBags = json['kittyBags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['invoiceSupplyBags'] = this.invoiceSupplyBags;
    data['kittyPoints'] = this.kittyPoints;
    data['kittyBags'] = this.kittyBags;
    return data;
  }
}

  class ReservePoolList {
    String productName;
    int invoiceSupplyBags;
    int kittyPoints;
    int kittyBags;

    ReservePoolList({this.productName,
      this.invoiceSupplyBags,
      this.kittyPoints,
      this.kittyBags});

    ReservePoolList.fromJson(Map<String, dynamic> json) {
      productName = json['productName'];
      invoiceSupplyBags = json['invoiceSupplyBags'];
      kittyPoints = json['kittyPoints'];
      kittyBags = json['kittyBags'];
    }

    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['productName'] = this.productName;
      data['invoiceSupplyBags'] = this.invoiceSupplyBags;
      data['kittyPoints'] = this.kittyPoints;
      data['kittyBags'] = this.kittyBags;
      return data;
    }
  }


