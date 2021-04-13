class DashboardMtdConvertedVolumeList {
  String respCode;
  String respMsg;
  List<VolumeEntity> volumeEntity;

  DashboardMtdConvertedVolumeList(
      {this.respCode, this.respMsg, this.volumeEntity});

  DashboardMtdConvertedVolumeList.fromJson(Map<String, dynamic> json) {
    respCode = json['resp_code'];
    respMsg = json['resp_msg'];
    if (json['volume_entity'] != null) {
      volumeEntity = new List<VolumeEntity>();
      json['volume_entity'].forEach((v) {
        volumeEntity.add(new VolumeEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resp_code'] = this.respCode;
    data['resp_msg'] = this.respMsg;
    if (this.volumeEntity != null) {
      data['volume_entity'] = this.volumeEntity.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VolumeEntity {
  int brandId;
  String brandName;
  int constructionStageId;
  String constructionStageText;
  String productName;
  int siteId;
  String supplyDate;
  String supplyQty;

  VolumeEntity(
      {this.brandId,
        this.brandName,
        this.constructionStageId,
        this.constructionStageText,
        this.productName,
        this.siteId,
        this.supplyDate,
        this.supplyQty});

  VolumeEntity.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    constructionStageId = json['construction_stage_id'];
    constructionStageText = json['construction_stage_text'];
    productName = json['product_name'];
    siteId = json['site_id'];
    supplyDate = json['supply_date'];
    supplyQty = json['supply_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['construction_stage_id'] = this.constructionStageId;
    data['construction_stage_text'] = this.constructionStageText;
    data['product_name'] = this.productName;
    data['site_id'] = this.siteId;
    data['supply_date'] = this.supplyDate;
    data['supply_qty'] = this.supplyQty;
    return data;
  }
}