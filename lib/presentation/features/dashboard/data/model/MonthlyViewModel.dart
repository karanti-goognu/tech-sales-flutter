

class DashboardMonthlyViewModel {
  int? convTargetCount;
  int? convTargetVolume;
  int? convertedCount;
  int? convertedVolume;
  int? dspRemaingTargetCount;
  int? dspSlabConvertedCount;
  int? dspSlabConvertedVolume;
  int? dspTargetCount;
  int? dspTotalOpperCount;
  int? dspTotalOpperVolume;
  int? generatedCount;
  int? generatedVolume;
  String? mwpPlanApproveStatus;
  int? remainingTargetCount;
  int? remainingTargetVolume;

  DashboardMonthlyViewModel(
      {this.convTargetCount,
        this.convTargetVolume,
        this.convertedCount,
        this.convertedVolume,
        this.dspRemaingTargetCount,
        this.dspSlabConvertedCount,
        this.dspSlabConvertedVolume,
        this.dspTargetCount,
        this.dspTotalOpperCount,
        this.dspTotalOpperVolume,
        this.generatedCount,
        this.generatedVolume,
        this.mwpPlanApproveStatus,
        this.remainingTargetCount,
        this.remainingTargetVolume});

  DashboardMonthlyViewModel.fromJson(Map<String, dynamic> json) {
    convTargetCount = json['conv_target_count'];
    convTargetVolume = json['conv_target_volume'];
    convertedCount = json['converted_count'];
    convertedVolume = json['converted_volume'];
    dspRemaingTargetCount = json['dsp_remaing_target_count'];
    dspSlabConvertedCount = json['dsp_slab_converted_count'];
    dspSlabConvertedVolume = json['dsp_slab_converted_volume'];
    dspTargetCount = json['dsp_target_count'];
    dspTotalOpperCount = json['dsp_total_opper_count'];
    dspTotalOpperVolume = json['dsp_total_opper_volume'];
    generatedCount = json['generated_count'];
    generatedVolume = json['generated_volume'];
    mwpPlanApproveStatus = json['mwp_plan_approve_status'];
    remainingTargetCount = json['remaining_target_count'];
    remainingTargetVolume = json['remaining_target_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['conv_target_count'] = this.convTargetCount;
    data['conv_target_volume'] = this.convTargetVolume;
    data['converted_count'] = this.convertedCount;
    data['converted_volume'] = this.convertedVolume;
    data['dsp_remaing_target_count'] = this.dspRemaingTargetCount;
    data['dsp_slab_converted_count'] = this.dspSlabConvertedCount;
    data['dsp_slab_converted_volume'] = this.dspSlabConvertedVolume;
    data['dsp_target_count'] = this.dspTargetCount;
    data['dsp_total_opper_count'] = this.dspTotalOpperCount;
    data['dsp_total_opper_volume'] = this.dspTotalOpperVolume;
    data['generated_count'] = this.generatedCount;
    data['generated_volume'] = this.generatedVolume;
    data['mwp_plan_approve_status'] = this.mwpPlanApproveStatus;
    data['remaining_target_count'] = this.remainingTargetCount;
    data['remaining_target_volume'] = this.remainingTargetVolume;
    return data;
  }
}