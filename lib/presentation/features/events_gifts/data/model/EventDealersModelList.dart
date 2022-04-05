class EventDealersModelList {
  String? createdBy;
  String? createdOn;
  String? dealerId;
  String? dealerName;
  int? eventDealerId;
  int? eventId;
  String? eventStage;
  String? isActive;
  String? modifiedBy;
  String? modifiedOn;

  EventDealersModelList(
      {this.createdBy,
        this.createdOn,
        this.dealerId,
        this.dealerName,
        this.eventDealerId,
        this.eventId,
        this.eventStage,
        this.isActive,
        this.modifiedBy,
        this.modifiedOn});

  EventDealersModelList.fromJson(Map<String, dynamic> json) {
    createdBy = json['createdBy'];
    createdOn = json['createdOn'];
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
    eventDealerId = json['eventDealerId'];
    eventId = json['eventId'];
    eventStage = json['eventStage'];
    isActive = json['isActive'];
    modifiedBy = json['modifiedBy'];
    modifiedOn = json['modifiedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    data['eventDealerId'] = this.eventDealerId;
    data['eventId'] = this.eventId;
    data['eventStage'] = this.eventStage;
    data['isActive'] = this.isActive;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    return data;
  }
}
