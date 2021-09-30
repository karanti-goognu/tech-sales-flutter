class AddLeadInitialModel {
  List<SiteSubTypeEntity> siteSubTypeEntity;
  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<InfluencerTypeEntity> influencerTypeEntity;
  List<DealerList> dealerList;
  List<SubDealerList> subDealerList;
  List<SalesOfficerList> salesOfficerList;
  List<EventList> eventList;

  AddLeadInitialModel(
      {this.siteSubTypeEntity,
      this.influencerCategoryEntity,
      this.influencerTypeEntity,
        this.dealerList,
        this.subDealerList,
        this.salesOfficerList,
        this.eventList
      });

  AddLeadInitialModel.fromJson(Map<String, dynamic> json) {
    if (json['siteSubTypeEntity'] != null) {
      siteSubTypeEntity = new List<SiteSubTypeEntity>();
      json['siteSubTypeEntity'].forEach((v) {
        siteSubTypeEntity.add(new SiteSubTypeEntity.fromJson(v));
      });
    }
    if (json['influencerCategoryEntity'] != null) {
      influencerCategoryEntity = new List<InfluencerCategoryEntity>();
      json['influencerCategoryEntity'].forEach((v) {
        influencerCategoryEntity.add(new InfluencerCategoryEntity.fromJson(v));
      });
    }
    if (json['influencerTypeEntity'] != null) {
      influencerTypeEntity = new List<InfluencerTypeEntity>();
      json['influencerTypeEntity'].forEach((v) {
        influencerTypeEntity.add(new InfluencerTypeEntity.fromJson(v));
      });
    }
    if (json['dealerList'] != null) {
      dealerList = new List<DealerList>();
      json['dealerList'].forEach((v) {
        dealerList.add(new DealerList.fromJson(v));
      });
    }
    if (json['subDealerList'] != null) {
      subDealerList = new List<SubDealerList>();
      json['subDealerList'].forEach((v) {
        subDealerList.add(new SubDealerList.fromJson(v));
      });
    }
    if (json['salesOfficerList'] != null) {
      salesOfficerList = new List<SalesOfficerList>();
      json['salesOfficerList'].forEach((v) {
        salesOfficerList.add(new SalesOfficerList.fromJson(v));
      });
    }
    if (json['eventList'] != null) {
      eventList = new List<EventList>();
      json['eventList'].forEach((v) {
        eventList.add(new EventList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.siteSubTypeEntity != null) {
      data['siteSubTypeEntity'] =
          this.siteSubTypeEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerCategoryEntity != null) {
      data['influencerCategoryEntity'] =
          this.influencerCategoryEntity.map((v) => v.toJson()).toList();
    }
    if (this.influencerTypeEntity != null) {
      data['influencerTypeEntity'] =
          this.influencerTypeEntity.map((v) => v.toJson()).toList();
    }
    if (this.dealerList != null) {
      data['dealerList'] = this.dealerList.map((v) => v.toJson()).toList();
    }
    if (this.subDealerList != null) {
      data['subDealerList'] =
          this.subDealerList.map((v) => v.toJson()).toList();
    }
    if (this.salesOfficerList != null) {
      data['salesOfficerList'] =
          this.salesOfficerList.map((v) => v.toJson()).toList();
    }
    if (this.eventList != null) {
      data['eventList'] = this.eventList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SiteSubTypeEntity {
  int siteSubId;
  String siteSubTypeDesc;

  SiteSubTypeEntity({this.siteSubId, this.siteSubTypeDesc});

  SiteSubTypeEntity.fromJson(Map<String, dynamic> json) {
    siteSubId = json['siteSubId'];
    siteSubTypeDesc = json['siteSubTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteSubId'] = this.siteSubId;
    data['siteSubTypeDesc'] = this.siteSubTypeDesc;
    return data;
  }
}

class InfluencerCategoryEntity {
  int inflCatId;
  String inflCatDesc;

  InfluencerCategoryEntity({this.inflCatId, this.inflCatDesc});

  InfluencerCategoryEntity.fromJson(Map<String, dynamic> json) {
    inflCatId = json['inflCatId'];
    inflCatDesc = json['inflCatDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflCatId'] = this.inflCatId;
    data['inflCatDesc'] = this.inflCatDesc;
    return data;
  }
}

class InfluencerTypeEntity {
  int inflTypeId;
  String inflTypeDesc;

  InfluencerTypeEntity({this.inflTypeId, this.inflTypeDesc});

  InfluencerTypeEntity.fromJson(Map<String, dynamic> json) {
    inflTypeId = json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    return data;
  }
}

class DealerList {
  String dealerId;
  String dealerName;

  DealerList({this.dealerId, this.dealerName});

  DealerList.fromJson(Map<String, dynamic> json) {
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    return data;
  }
}
class SubDealerList {
  String dealerId;
  String dealerName;

  SubDealerList({this.dealerId, this.dealerName});

  SubDealerList.fromJson(Map<String, dynamic> json) {
    dealerId = json['dealerId'];
    dealerName = json['dealerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerId'] = this.dealerId;
    data['dealerName'] = this.dealerName;
    return data;
  }
}

class SalesOfficerList {
  String salesOfficerId;
  String salesOfficerName;

  SalesOfficerList({this.salesOfficerId, this.salesOfficerName});

  SalesOfficerList.fromJson(Map<String, dynamic> json) {
    salesOfficerId = json['salesOfficerId'];
    salesOfficerName = json['salesOfficerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesOfficerId'] = this.salesOfficerId;
    data['salesOfficerName'] = this.salesOfficerName;
    return data;
  }
}

class EventList {
  String eventId;

  EventList(
      {this.eventId});

  EventList.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    return data;
  }
}
