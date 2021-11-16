class UpdateSRModel {
  int id;
  String severity;
  int resoulutionStatus;
  String updatedBy;
  List<SrComplaintAction> srComplaintAction;
  List<SrcActionPhotosEntity> srcActionPhotosEntity;
  String coverBlockProvidedNo;
  String formwarkRemovalDate;

  UpdateSRModel(
      {this.id,
        this.severity,
        this.resoulutionStatus,
        this.updatedBy,
        this.srComplaintAction,
        this.srcActionPhotosEntity,
        this.coverBlockProvidedNo,
        this.formwarkRemovalDate});

  UpdateSRModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    severity = json['severity'];
    resoulutionStatus = json['resoulutionStatus'];
    updatedBy = json['updatedBy'];
    if (json['srComplaintAction'] != null) {
      srComplaintAction = new List<SrComplaintAction>();
      json['srComplaintAction'].forEach((v) {
        srComplaintAction.add(new SrComplaintAction.fromJson(v));
      });
    }
    if (json['srcActionPhotosEntity'] != null) {
      srcActionPhotosEntity = new List<SrcActionPhotosEntity>();
      json['srcActionPhotosEntity'].forEach((v) {
        srcActionPhotosEntity.add(new SrcActionPhotosEntity.fromJson(v));
      });
    }

    coverBlockProvidedNo = json['coverBlockProvidedNo'];
    formwarkRemovalDate = json['formwarkRemovalDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['severity'] = this.severity;
    data['resoulutionStatus'] = this.resoulutionStatus;
    data['updatedBy'] = this.updatedBy;
    if (this.srComplaintAction != null) {
      data['srComplaintAction'] =
          this.srComplaintAction.map((v) => v.toJson()).toList();
    }
    if (this.srcActionPhotosEntity != null) {
      data['srcActionPhotosEntity'] =
          this.srcActionPhotosEntity.map((v) => v.toJson()).toList();
    }

    data['coverBlockProvidedNo'] = this.coverBlockProvidedNo;
    data['formwarkRemovalDate'] = this.formwarkRemovalDate;
    return data;
  }
}

class SrComplaintAction {
  int srComplaintId;
  String requestNature;
  double locationLat;
  double locationLong;
  String productComplaint;
  String productType;
  String techvanReqd;
  String purchaseDate;
  String sourcePlant;
  String productBatch;
  int bagsCount;
  int resolutionStatusId;
  String comment;
  String nextVisitDate;

  String typeOfComplaint;
  String productVariety;
  int balanceQtyinBags;
  String billNumber;
  String weekNo;
  String bestBeforeDate;
  String sampleCollected;
  String sampleTOBeSentTo;
  String demoConducted;
  String detailsOfDemo;

  SrComplaintAction(
      {this.srComplaintId,
        this.requestNature,
        this.locationLat,
        this.locationLong,
        this.productComplaint,
        this.productType,
        this.techvanReqd,
        this.purchaseDate,
        this.sourcePlant,
        this.productBatch,
        this.bagsCount,
        this.resolutionStatusId,
        this.comment,
        this.nextVisitDate,

        this.typeOfComplaint,
        this.productVariety,
        this.balanceQtyinBags,
        this.billNumber,
        this.weekNo,
        this.bestBeforeDate,
        this.sampleCollected,
        this.sampleTOBeSentTo,
        this.demoConducted,
        this.detailsOfDemo
      });

  SrComplaintAction.fromJson(Map<String, dynamic> json) {
    srComplaintId = json['srComplaintId'];
    requestNature = json['requestNature'];
    locationLat = json['locationLat'];
    locationLong = json['locationLong'];
    productComplaint = json['productComplaint'];
    productType = json['productType'];
    techvanReqd = json['techvanReqd'];
    purchaseDate = json['purchaseDate'];
    sourcePlant = json['sourcePlant'];
    productBatch = json['productBatch'];
    bagsCount = json['bagsCount'];
    resolutionStatusId = json['resolutionStatusId'];
    comment = json['comment'];
    nextVisitDate = json['nextVisitDate'];

    typeOfComplaint = json['typeOfComplaint'];
    productVariety = json['productVariety'];
    balanceQtyinBags = json['balanceQtyinBags'];
    billNumber = json['billNumber'];
    weekNo = json['weekNo'];
    bestBeforeDate = json['bestBeforeDate'];
    sampleCollected = json['sampleCollected'];
    sampleTOBeSentTo = json['sampleTOBeSentTo'];
    demoConducted = json['demoConducted'];
    detailsOfDemo = json['detailsOfDemo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['srComplaintId'] = this.srComplaintId;
    data['requestNature'] = this.requestNature;
    data['locationLat'] = this.locationLat;
    data['locationLong'] = this.locationLong;
    data['productComplaint'] = this.productComplaint;
    data['productType'] = this.productType;
    data['techvanReqd'] = this.techvanReqd;
    data['purchaseDate'] = this.purchaseDate;
    data['sourcePlant'] = this.sourcePlant;
    data['productBatch'] = this.productBatch;
    data['bagsCount'] = this.bagsCount;
    data['resolutionStatusId'] = this.resolutionStatusId;
    data['comment'] = this.comment;
    data['nextVisitDate'] = this.nextVisitDate;

    data['typeOfComplaint'] = this.typeOfComplaint;
    data['productVariety'] = this.productVariety;
    data['balanceQtyinBags'] = this.balanceQtyinBags;
    data['billNumber'] = this.billNumber;
    data['weekNo'] = this.weekNo;
    data['bestBeforeDate'] = this.bestBeforeDate;
    data['sampleCollected'] = this.sampleCollected;
    data['sampleTOBeSentTo'] = this.sampleTOBeSentTo;
    data['demoConducted'] = this.demoConducted;
    data['detailsOfDemo'] = this.detailsOfDemo;
    return data;
  }
}

class SrcActionPhotosEntity {
  int srComplaintId;
  String photoName;

  SrcActionPhotosEntity({this.srComplaintId, this.photoName});

  SrcActionPhotosEntity.fromJson(Map<String, dynamic> json) {
    srComplaintId = json['srComplaintId'];
    photoName = json['photoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['srComplaintId'] = this.srComplaintId;
    data['photoName'] = this.photoName;
    return data;
  }
}