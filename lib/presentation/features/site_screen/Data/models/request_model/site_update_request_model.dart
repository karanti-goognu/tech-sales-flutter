import 'package:flutter_tech_sales/utils/constants/url_constants.dart';

class SiteUpdateRequestModel{
  final  List<Map> _siteDataArr;
  List<Map> get siteDataArr => _siteDataArr;
  SiteUpdateRequestModel( this._siteDataArr);

  Map getJsonData() {
    var map = {};
    map[UrlConstants.SITE_UPDATE_MODELS] = siteDataArr;
    print("finalJsonOfSite    $map");
    return map;
  }
}

class SiteDataModel{
  final String _assignedTo;
  final String _closureReasonText;
  final String _contactName;
  final String _contactNumber;
  final String _createdBy;
  final String _createdOn;
  final String _dealerId;
  final String _inactiveReasonText;
  final String _nextVisitDate;
  final int _noOfFloors;
  final String _plotNumber;
  final String _productDemo;
  final String _productOralBriefing;
  final String _reraNumber;
  final String _siteAddress;
  final String _siteBuiltArea;
  final String _soCode;
  final String _updatedBy;
  final String _updatedOn;
  final int _siteCompetitionId;
  final int _siteConstructionId;
  final String _siteCreationDate;
  final String _siteDistrict;
  final String _siteGeotag;
  final String _siteGeotagLat;
  final String _siteGeotagLong;
  final int _siteId;
  final String _sitePincode;
  final int _sitePotentialMt;
  final int _siteProbabilityWinningId;
  final double _siteScore;
  final String _siteSegment;
  final int _siteStageId;
  final String _siteState;
  final int _siteStatusId;
  final String _siteTaluk;
  final int _siteOppertunityId;
  final  List<Map> _siteCommentsEntity;
  final  List<Map> _siteInfluencerEntity;
  final  List<Map> _siteNextStageEntity;
  final  List<Map> _sitePhotosEntity;
  final  List<Map> _siteVisitHistoryEntity;

  SiteDataModel(this._assignedTo, this._closureReasonText, this._contactName, this._contactNumber, this._createdBy, this._createdOn,
      this._dealerId, this._inactiveReasonText, this._nextVisitDate, this._noOfFloors, this._plotNumber, this._productDemo, this._productOralBriefing,
      this._reraNumber, this._siteAddress, this._siteBuiltArea, this._soCode, this._updatedBy, this._updatedOn, this._siteCompetitionId, this._siteConstructionId,
      this._siteCreationDate, this._siteDistrict, this._siteGeotag, this._siteGeotagLat, this._siteGeotagLong, this._siteId, this._sitePincode, this._sitePotentialMt,
      this._siteProbabilityWinningId, this._siteScore, this._siteSegment, this._siteStageId, this._siteState, this._siteStatusId, this._siteTaluk, this._siteOppertunityId,
      this._siteCommentsEntity, this._siteInfluencerEntity, this._siteNextStageEntity, this._sitePhotosEntity, this._siteVisitHistoryEntity);

  String get closureReasonText => _closureReasonText;

  String get contactName => _contactName;

  String get contactNumber => _contactNumber;

  String get createdBy => _createdBy;

  String get createdOn => _createdOn;

  String get dealerId => _dealerId;

  String get inactiveReasonText => _inactiveReasonText;

  String get nextVisitDate => _nextVisitDate;
  String get assignedTo => _assignedTo;

  int get noOfFloors => _noOfFloors;

  String get plotNumber => _plotNumber;

  String get productDemo => _productDemo;

  String get productOralBriefing => _productOralBriefing;

  String get reraNumber => _reraNumber;

  String get siteAddress => _siteAddress;

  String get siteBuiltArea => _siteBuiltArea;

  String get soCode => _soCode;

  String get updatedBy => _updatedBy;

  String get updatedOn => _updatedOn;

  int get siteCompetitionId => _siteCompetitionId;

  int get siteConstructionId => _siteConstructionId;

  String get siteCreationDate => _siteCreationDate;

  String get siteDistrict => _siteDistrict;

  String get siteGeotag => _siteGeotag;

  String get siteGeotagLat => _siteGeotagLat;

  String get siteGeotagLong => _siteGeotagLong;

  int get siteId => _siteId;

  String get sitePincode => _sitePincode;

  int get sitePotentialMt => _sitePotentialMt;

  int get siteProbabilityWinningId => _siteProbabilityWinningId;

  double get siteScore => _siteScore;

  String get siteSegment => _siteSegment;

  int get siteStageId => _siteStageId;

  String get siteState => _siteState;

  int get siteStatusId => _siteStatusId;

  String get siteTaluk => _siteTaluk;

  int get siteOppertunityId => _siteOppertunityId;

  List<Map> get siteCommentsEntity => _siteCommentsEntity;

  List<Map> get siteInfluencerEntity => _siteInfluencerEntity;

  List<Map> get siteNextStageEntity => _siteNextStageEntity;

  List<Map> get sitePhotosEntity => _sitePhotosEntity;

  List<Map> get siteVisitHistoryEntity => _siteVisitHistoryEntity;

  Map getJsonData() {
    var map = {};
    map[UrlConstants.ASSIGNED_TO] = assignedTo;
    map[UrlConstants.CLOSURE_REASON_TEXT] = closureReasonText;
    map[UrlConstants.CONTACT_NAME] = contactName;
    map[UrlConstants.CONTACT_NUMBER] = contactNumber;
    map[UrlConstants.CREATED_BY] = createdBy;
    map[UrlConstants.CREATED_ON] = createdOn;
    map[UrlConstants.DEALER_ID] = dealerId;
    map[UrlConstants.INACTIVE_REASON_TEXT] = inactiveReasonText;
    map[UrlConstants.NEXT_VISIT_DATE] = nextVisitDate;
    map[UrlConstants.NO_OF_FLOORS] = noOfFloors;
    map[UrlConstants.PLOT_NUMBER] = plotNumber;
    map[UrlConstants.PRODUCT_DEMO] = productDemo;
    map[UrlConstants.PRODUCT_ORAL_BRIEFING] = productOralBriefing;
    map[UrlConstants.RERA_NUMBER] = reraNumber;
    map[UrlConstants.SITE_ADDRESS] = siteAddress;
    map[UrlConstants.SITE_BUILD_AREA] = siteBuiltArea;
    map[UrlConstants.SO_CODE] = soCode;
    map[UrlConstants.UPDATED_BY] = updatedBy;
    map[UrlConstants.UPDATED_ON] = updatedOn;
    map[UrlConstants.SITE_COMPETITION_ID] = siteCompetitionId;
    map[UrlConstants.SITE_CONSTRUCTION_ID] = siteConstructionId;
    map[UrlConstants.SITE_CREATION_DATE] = siteCreationDate;
    map[UrlConstants.SITE_DISTRICT] = siteDistrict;
    map[UrlConstants.SITE_GEO_TAG] = siteGeotag;
    map[UrlConstants.SITE_GEO_TAG_LAT] = siteGeotagLat;
    map[UrlConstants.SITE_GEO_TAG_LONG] = siteGeotagLong;
    map[UrlConstants.SITE_ID] = siteId;
    map[UrlConstants.SITE_PIN_CODE] = sitePincode;
    map[UrlConstants.SITE_POTENTIAL_MT] = sitePotentialMt;
    map[UrlConstants.SITE_PROBABILITY_WINNING_ID] = siteProbabilityWinningId;
    map[UrlConstants.SITE_SCORE] = siteScore;
    map[UrlConstants.SITE_SEGMENT] = siteSegment;
    map[UrlConstants.SITE_STAGE_ID] = siteStageId;
    map[UrlConstants.SITE_STATE] = siteState;
    map[UrlConstants.SITE_STATUS_ID] = siteStatusId;
    map[UrlConstants.SITE_TALUK] = siteTaluk;
    map[UrlConstants.SITE_COMMENTS_ENTITY] = siteCommentsEntity;
    map[UrlConstants.SITE_INFLUENCER_ENTITY] = siteInfluencerEntity;
    map[UrlConstants.SITE_NEXT_STAGE_ENTITY] = siteNextStageEntity;
    map[UrlConstants.SITE_PHOTO_ENTITY] = sitePhotosEntity;
    map[UrlConstants.SITE_VISIT_HISTORY_ENTITY] = siteVisitHistoryEntity;
    print("mapDataForJson    $map");
    return map;
  }

}
