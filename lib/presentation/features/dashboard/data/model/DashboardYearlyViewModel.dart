class DashboardYearlyViewModel {
  List<DashboardYearlyModels> dashboardYearlyModels;
  MtdCount mtdCount;
  MtdVolume mtdVolume;
  String respCode;
  String respMsg;

  DashboardYearlyViewModel(
      {this.dashboardYearlyModels,
        this.mtdCount,
        this.mtdVolume,
        this.respCode,
        this.respMsg});

  DashboardYearlyViewModel.fromJson(Map<String, dynamic> json) {
    if (json['dashboardYearlyModels'] != null) {
      dashboardYearlyModels = new List<DashboardYearlyModels>.empty(growable: true);
      json['dashboardYearlyModels'].forEach((v) {
        dashboardYearlyModels.add(new DashboardYearlyModels.fromJson(v));
      });
    }
    mtdCount = json['mtd_count'] != null
        ? new MtdCount.fromJson(json['mtd_count'])
        : null;
    mtdVolume = json['mtd_volume'] != null
        ? new MtdVolume.fromJson(json['mtd_volume'])
        : null;
    respCode = json['resp_code'];
    respMsg = json['resp_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dashboardYearlyModels != null) {
      data['dashboardYearlyModels'] =
          this.dashboardYearlyModels.map((v) => v.toJson()).toList();
    }
    if (this.mtdCount != null) {
      data['mtd_count'] = this.mtdCount.toJson();
    }
    if (this.mtdVolume != null) {
      data['mtd_volume'] = this.mtdVolume.toJson();
    }
    data['resp_code'] = this.respCode;
    data['resp_msg'] = this.respMsg;
    return data;
  }
}

class DashboardYearlyModels {
  int avgConvertedVolume;
  int avgGeneratedVolume;
  int avgLeadConverted;
  int avgLeadGenerated;
  double convertedVolume;
  double generatedVolume;
  int leadConverted;
  int leadGenerated;
  String m1;
  String monthYear;
  String monthYearNo;
  String showMonth;
  String showYear;

  DashboardYearlyModels(
      {this.avgConvertedVolume,
        this.avgGeneratedVolume,
        this.avgLeadConverted,
        this.avgLeadGenerated,
        this.convertedVolume,
        this.generatedVolume,
        this.leadConverted,
        this.leadGenerated,
        this.m1,
        this.monthYear,
        this.monthYearNo,
        this.showMonth,
        this.showYear});

  DashboardYearlyModels.fromJson(Map<String, dynamic> json) {
    avgConvertedVolume = json['avgConvertedVolume'];
    avgGeneratedVolume = json['avgGeneratedVolume'];
    avgLeadConverted = json['avgLeadConverted'];
    avgLeadGenerated = json['avgLeadGenerated'];
    convertedVolume = json['convertedVolume'];
    generatedVolume = json['generatedVolume'];
    leadConverted = json['leadConverted'];
    leadGenerated = json['leadGenerated'];
    m1 = json['m1'];
    monthYear = json['monthYear'];
    monthYearNo = json['monthYearNo'];
    showMonth = json['showMonth'];
    showYear = json['showYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avgConvertedVolume'] = this.avgConvertedVolume;
    data['avgGeneratedVolume'] = this.avgGeneratedVolume;
    data['avgLeadConverted'] = this.avgLeadConverted;
    data['avgLeadGenerated'] = this.avgLeadGenerated;
    data['convertedVolume'] = this.convertedVolume;
    data['generatedVolume'] = this.generatedVolume;
    data['leadConverted'] = this.leadConverted;
    data['leadGenerated'] = this.leadGenerated;
    data['m1'] = this.m1;
    data['monthYear'] = this.monthYear;
    data['monthYearNo'] = this.monthYearNo;
    data['showMonth'] = this.showMonth;
    data['showYear'] = this.showYear;
    return data;
  }
}

class MtdCount {
  int convAchvCountPerc;
  int convActCount;
  int convProrataCount;
  int convTargetCount;
  int slabAchvCountPerc;
  int slabActCount;
  int slabProrataCount;
  int slabTargetCount;

  MtdCount(
      {this.convAchvCountPerc,
        this.convActCount,
        this.convProrataCount,
        this.convTargetCount,
        this.slabAchvCountPerc,
        this.slabActCount,
        this.slabProrataCount,
        this.slabTargetCount});

  MtdCount.fromJson(Map<String, dynamic> json) {
    convAchvCountPerc = json['conv_achv_count_perc'];
    convActCount = json['conv_act_count'];
    convProrataCount = json['conv_prorata_count'];
    convTargetCount = json['conv_target_count'];
    slabAchvCountPerc = json['slab_achv_count_perc'];
    slabActCount = json['slab_act_count'];
    slabProrataCount = json['slab_prorata_count'];
    slabTargetCount = json['slab_target_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conv_achv_count_perc'] = this.convAchvCountPerc;
    data['conv_act_count'] = this.convActCount;
    data['conv_prorata_count'] = this.convProrataCount;
    data['conv_target_count'] = this.convTargetCount;
    data['slab_achv_count_perc'] = this.slabAchvCountPerc;
    data['slab_act_count'] = this.slabActCount;
    data['slab_prorata_count'] = this.slabProrataCount;
    data['slab_target_count'] = this.slabTargetCount;
    return data;
  }
}

class MtdVolume {
  int convAchvVolumePerc;
  int convActVolume;
  int convProrataVolume;
  int convTargetVolume;
  int slabAchvVolumePerc;
  int slabActVolume;
  int slabProrataVolume;
  int slabTargetVolume;

  MtdVolume(
      {this.convAchvVolumePerc,
        this.convActVolume,
        this.convProrataVolume,
        this.convTargetVolume,
        this.slabAchvVolumePerc,
        this.slabActVolume,
        this.slabProrataVolume,
        this.slabTargetVolume});

  MtdVolume.fromJson(Map<String, dynamic> json) {
    convAchvVolumePerc = json['conv_achv_volume_perc'];
    convActVolume = json['conv_act_volume'];
    convProrataVolume = json['conv_prorata_volume'];
    convTargetVolume = json['conv_target_volume'];
    slabAchvVolumePerc = json['slab_achv_volume_perc'];
    slabActVolume = json['slab_act_volume'];
    slabProrataVolume = json['slab_prorata_volume'];
    slabTargetVolume = json['slab_target_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conv_achv_volume_perc'] = this.convAchvVolumePerc;
    data['conv_act_volume'] = this.convActVolume;
    data['conv_prorata_volume'] = this.convProrataVolume;
    data['conv_target_volume'] = this.convTargetVolume;
    data['slab_achv_volume_perc'] = this.slabAchvVolumePerc;
    data['slab_act_volume'] = this.slabActVolume;
    data['slab_prorata_volume'] = this.slabProrataVolume;
    data['slab_target_volume'] = this.slabTargetVolume;
    return data;
  }
}