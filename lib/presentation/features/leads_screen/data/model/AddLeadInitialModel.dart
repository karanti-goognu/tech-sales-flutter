class AddLeadInitialModel {
  List<SiteSubTypeEntity> siteSubTypeEntity;
  List<InfluencerCategoryEntity> influencerCategoryEntity;
  List<InfluencerTypeEntity> influencerTypeEntity;
  List<DealerList> dealerList;
  List<SubDealerList> subDealerList;
  List<SalesOfficerList> salesOfficerList;
  List<EventList> eventList;
  List<LeadSourceList> leadSourceList;

  AddLeadInitialModel(
      {this.siteSubTypeEntity,
      this.influencerCategoryEntity,
      this.influencerTypeEntity,
        this.dealerList,
        this.subDealerList,
        this.salesOfficerList,
        this.eventList, this.leadSourceList
      });

  AddLeadInitialModel.fromJson(Map<String, dynamic> json) {
    if (json['siteSubTypeEntity'] != null) {
      siteSubTypeEntity = new List<SiteSubTypeEntity>.empty(growable: true);
      json['siteSubTypeEntity'].forEach((v) {
        siteSubTypeEntity.add(new SiteSubTypeEntity.fromJson(v));
      });
    }
    if (json['influencerCategoryEntity'] != null) {
      influencerCategoryEntity = new List<InfluencerCategoryEntity>.empty(growable: true);
      json['influencerCategoryEntity'].forEach((v) {
        influencerCategoryEntity.add(new InfluencerCategoryEntity.fromJson(v));
      });
    }
    if (json['influencerTypeEntity'] != null) {
      influencerTypeEntity = new List<InfluencerTypeEntity>.empty(growable: true);
      json['influencerTypeEntity'].forEach((v) {
        influencerTypeEntity.add(new InfluencerTypeEntity.fromJson(v));
      });
    }
    if (json['dealerList'] != null) {
      dealerList = new List<DealerList>.empty(growable: true);
      json['dealerList'].forEach((v) {
        dealerList.add(new DealerList.fromJson(v));
      });
    }
    if (json['subDealerList'] != null) {
      subDealerList = new List<SubDealerList>.empty(growable: true);
      json['subDealerList'].forEach((v) {
        subDealerList.add(new SubDealerList.fromJson(v));
      });
    }
    if (json['salesOfficerList'] != null) {
      salesOfficerList = new List<SalesOfficerList>.empty(growable: true);
      json['salesOfficerList'].forEach((v) {
        salesOfficerList.add(new SalesOfficerList.fromJson(v));
      });
    }
    if (json['eventList'] != null) {
      eventList = new List<EventList>.empty(growable: true);
      json['eventList'].forEach((v) {
        eventList.add(new EventList.fromJson(v));
      });
    }
    if (json['leadSourceList'] != null) {
      leadSourceList = new List<LeadSourceList>.empty(growable: true);
      json['leadSourceList'].forEach((v) {
        leadSourceList.add(new LeadSourceList.fromJson(v));
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
    if (this.leadSourceList != null) {
      data['leadSourceList'] =
          this.leadSourceList.map((v) => v.toJson()).toList();
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
  String infRegFlag;

  InfluencerTypeEntity({this.inflTypeId, this.inflTypeDesc, this.infRegFlag});

  InfluencerTypeEntity.fromJson(Map<String, dynamic> json) {
    inflTypeId = json['inflTypeId'];
    inflTypeDesc = json['inflTypeDesc'];
    infRegFlag = json['infRegFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inflTypeId'] = this.inflTypeId;
    data['inflTypeDesc'] = this.inflTypeDesc;
    data['infRegFlag'] = this.infRegFlag;
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

class LeadSourceList {
  int id;
  String name;

  LeadSourceList({this.id, this.name});

  LeadSourceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}