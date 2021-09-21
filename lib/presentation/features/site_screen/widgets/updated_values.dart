
import 'dart:io';

import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/InfluencerDetailModel.dart';
import 'package:flutter_tech_sales/presentation/features/site_screen/data/models/ViewSiteDataResponse.dart';
import 'package:path/path.dart' as path;


class UpdatedValues{

  static int siteId;
  static String siteSegment;
  static String assignedTo;
  static String siteStatusId;
  static String siteStageId;
  static String contactName;
  static String contactNumber;
  static String siteGeotag;
  static double siteGeotagLat;
  static double siteGeotagLong;
  static String plotNumber;
  static String siteAddress;
  static String sitePincode;
  static String siteState;
  static String siteDistrict;
  static String siteTaluk;
  static String sitePotentialMt;
  static String reraNumber;
  static String siteCreationDate;
  static String dealerId;
  static String siteBuiltArea;
  static String noOfFloors;
  static String productDemo;
  static String productOralBriefing;
  static String soCode;
  static String inactiveReasonText;
  static String nextVisitDate;
  static String closureReasonText;
  static String createdBy;
  static String totalBalancePotential;
  static String siteCommentsEntity;
  static List<SiteStageHistory> siteStageHistory;

  static String siteProbabilityWinningId;
  static String siteCompetitionId;
  static String siteOppertunityId;
  static int siteConstructionId;
  // List<SiteVisitHistoryEntity> siteVisitHistoryEntity;
  static List<SiteNextStageEntity> siteNextStageEntity;
  static List<SitephotosEntity> sitePhotosEntity;
  static List<SiteInfluencerEntity> siteInfluencerEntity;

  static String dealerConfirmedChangedBy;
  static String dealerConfirmedChangedOn;
  static String isDealerConfirmedChangedBySo;
  static String subdealerId;
  static int kitchenCount;
  static int bathroomCount;
  static List<SiteSupplyHistorys> siteSupplyHistory ;

  static ConstructionStageEntity siteProgressConstructionId;
  static ConstructionStageEntity constructionTypeVisitNextStage;
  static SiteFloorsEntity siteProgressnoOfFloors;
  static String siteProgressStagePotential;
  static String siteProgressStageStatus;
  static String siteProgressDateOfConstruction;
  static List<InfluencerDetail> listInfluencerDetail;

  static List<File> imageList;
  static String empCode;
  static String empName;

  static bool addNextButtonDisable;
  static bool fromDropDown;


  static  bool getFromDropDown() {
    return fromDropDown;
  }

  static  void setFromDropDown(bool fromDropDown) {
    UpdatedValues.fromDropDown = fromDropDown;
  }

  static  bool getAddNextButtonDisable() {
    return addNextButtonDisable;
  }

  static  void setAddNextButtonDisable(bool addNextButtonDisable) {
    UpdatedValues.addNextButtonDisable = addNextButtonDisable;
  }

  static  String getEmpName() {
    return empName;
  }

  static  void setEmpName(String empName) {
    UpdatedValues.empName = empName;
  }

  static  String getEmpCode() {
    return empCode;
  }

  static  void setEmpCode(String empCode) {
    UpdatedValues.empCode = empCode;
  }

  static  int getSiteId() {
    return siteId;
  }

  static  void setSiteId(int siteId) {
    UpdatedValues.siteId = siteId;
  }

  static  List<File> getImageList() {
    return imageList;
  }

  static  void setImageList(List<File> imageList) {
    UpdatedValues.imageList = imageList;
  }

  static  String getSiteSegment() {
    return siteSegment;
  }

  static  void setSiteSegment(String siteSegment) {
    UpdatedValues.siteSegment = siteSegment;
  }

  static  String getAssignedTo() {
    return assignedTo;
  }

  static  void setAssignedTo(String assignedTo) {
    UpdatedValues.assignedTo = assignedTo;
  }

  static  String getSiteStatusId() {
    return siteStatusId;
  }

  static  void setSiteStatusId(String siteStatusId) {
    UpdatedValues.siteStatusId = siteStatusId;
  }

  static  String getSiteStageId() {
    return siteStageId;
  }

  static  void setSiteStageId(String siteStageId) {
    UpdatedValues.siteStageId = siteStageId;
  }

  static  String getContactName() {
    return contactName;
  }

  static  void setContactName(String contactName) {
    UpdatedValues.contactName = contactName;
  }

  static  String getContactNumber() {
    return contactNumber;
  }

  static  void setContactNumber(String contactNumber) {
    UpdatedValues.contactNumber = contactNumber;
  }

  static  String getSiteGeotag() {
    return siteGeotag;
  }

  static  void setSiteGeotag(String siteGeotag) {
    UpdatedValues.siteGeotag = siteGeotag;
  }

  static  double getSiteGeotagLat() {
    return siteGeotagLat;
  }

  static  void setSiteGeotagLat(double siteGeotagLat) {
    UpdatedValues.siteGeotagLat = siteGeotagLat;
  }

  static  double getSiteGeotagLong() {
    return siteGeotagLong;
  }

  static  void setSiteGeotagLong(double siteGeotagLong) {
    UpdatedValues.siteGeotagLong = siteGeotagLong;
  }

  static  String getPlotNumber() {
    return plotNumber;
  }

  static  void setPlotNumber(String plotNumber) {
    UpdatedValues.plotNumber = plotNumber;
  }

  static  String getSiteAddress() {
    return siteAddress;
  }

  static  void setSiteAddress(String siteAddress) {
    UpdatedValues.siteAddress = siteAddress;
  }

  static  String getSitePincode() {
    return sitePincode;
  }

  static  void setSitePincode(String sitePincode) {
    UpdatedValues.sitePincode = sitePincode;
  }

  static  String getSiteState() {
    return siteState;
  }

  static  void setSiteState(String siteState) {
    UpdatedValues.siteState = siteState;
  }

  static  String getSiteDistrict() {
    return siteDistrict;
  }

  static  void setSiteDistrict(String siteDistrict) {
    UpdatedValues.siteDistrict = siteDistrict;
  }

  static  String getSiteTaluk() {
    return siteTaluk;
  }

  static  void setSiteTaluk(String siteTaluk) {
    UpdatedValues.siteTaluk = siteTaluk;
  }

  static  String getSitePotentialMt() {
    return sitePotentialMt;
  }

  static  void setSitePotentialMt(String sitePotentialMt) {
    UpdatedValues.sitePotentialMt = sitePotentialMt;
  }

  static  String getReraNumber() {
    return reraNumber;
  }

  static  void setReraNumber(String reraNumber) {
    UpdatedValues.reraNumber = reraNumber;
  }

  static  String getSiteCreationDate() {
    return siteCreationDate;
  }

  static  void setSiteCreationDate(String siteCreationDate) {
    UpdatedValues.siteCreationDate = siteCreationDate;
  }

  static  String getDealerId() {
    return dealerId;
  }

  static  void setDealerId(String dealerId) {
    UpdatedValues.dealerId = dealerId;
  }

  static  String getSiteBuiltArea() {
    return siteBuiltArea;
  }

  static  void setSiteBuiltArea(String siteBuiltArea) {
    UpdatedValues.siteBuiltArea = siteBuiltArea;
  }

  static  String getNoOfFloors() {
    return noOfFloors;
  }

  static  void setNoOfFloors(String noOfFloors) {
    UpdatedValues.noOfFloors = noOfFloors;
  }

  static  String getProductDemo() {
    return productDemo;
  }

  static  void setProductDemo(String productDemo) {
    UpdatedValues.productDemo = productDemo;
  }

  static  String getProductOralBriefing() {
    return productOralBriefing;
  }

  static  void setProductOralBriefing(String productOralBriefing) {
    UpdatedValues.productOralBriefing = productOralBriefing;
  }

  static  String getSoCode() {
    return soCode;
  }

  static  void setSoCode(String soCode) {
    UpdatedValues.soCode = soCode;
  }

  static  String getInactiveReasonText() {
    return inactiveReasonText;
  }

  static  void setInactiveReasonText(String inactiveReasonText) {
    UpdatedValues.inactiveReasonText = inactiveReasonText;
  }

  static  String getNextVisitDate() {
    return nextVisitDate;
  }

  static  void setNextVisitDate(String nextVisitDate) {
    UpdatedValues.nextVisitDate = nextVisitDate;
  }

  static  String getClosureReasonText() {
    return closureReasonText;
  }

  static  void setClosureReasonText(String closureReasonText) {
    UpdatedValues.closureReasonText = closureReasonText;
  }

  static  String getCreatedBy() {
    return createdBy;
  }

  static  void setCreatedBy(String createdBy) {
    UpdatedValues.createdBy = createdBy;
  }

  static  String getTotalBalancePotential() {
    return totalBalancePotential;
  }

  static  void setTotalBalancePotential(String totalBalancePotential) {
    UpdatedValues.totalBalancePotential = totalBalancePotential;
  }

  static  List<SiteCommentsEntity> getSiteCommentsEntity() {
    if (siteCommentsEntity == null ||
        siteCommentsEntity == "null" ||
        siteCommentsEntity == "") {
        siteCommentsEntity = "Site updated";
    }
    // print('${widget.siteId}=============');

    List<SiteCommentsEntity> newSiteCommentsEntity = new List();
    newSiteCommentsEntity.add(new SiteCommentsEntity(
        siteId: siteId,
        siteCommentText: siteCommentsEntity,
        creatorName:getEmpName(),
        createdBy: getEmpCode()));
    return newSiteCommentsEntity;
  }

  static  void setSiteCommentsEntity(String siteCommentsEntity) {
    UpdatedValues.siteCommentsEntity = siteCommentsEntity;
  }

  static  List<SiteStageHistory> getSiteStageHistory() {
    return siteStageHistory;
  }

  static  void setSiteStageHistory(List<SiteStageHistory> siteStageHistory) {
    UpdatedValues.siteStageHistory = siteStageHistory;
  }

  static List<SiteStageHistory>  getSiteStageHistory1() {
    List<SiteStageHistory> siteStageHistory = new List();
    if (siteProgressConstructionId != null) {
      siteStageHistory.add(new SiteStageHistory(
          constructionStageId: siteProgressConstructionId.id ?? 1,
          siteId: getSiteId(),
          floorId: siteProgressnoOfFloors.id,
          stagePotential: siteProgressStagePotential,
          constructionDate: siteProgressDateOfConstruction,
          stageStatus: siteProgressStageStatus,
          createdBy: empCode,
          siteSupplyHistorys: siteSupplyHistory));
    }
    UpdatedValues.siteStageHistory = siteStageHistory;
    return siteStageHistory ;
  }


  static  List<SiteSupplyHistorys> getSiteSupplyHistory() {
    return siteSupplyHistory;
  }

  static  void updateSiteSupplyHistory(List<SiteSupplyHistorys> siteSupplyHistorys) {
    UpdatedValues.siteSupplyHistory = siteSupplyHistorys;
  }





  static  String getSiteProbabilityWinningId() {
    return siteProbabilityWinningId;
  }

  static  void setSiteProbabilityWinningId(String siteProbabilityWinningId) {
    UpdatedValues.siteProbabilityWinningId = siteProbabilityWinningId;
  }

  static  String getSiteCompetitionId() {
    return siteCompetitionId;
  }

  static  void setSiteCompetitionId(String siteCompetitionId) {
    UpdatedValues.siteCompetitionId = siteCompetitionId;
  }

  static  String getSiteOppertunityId() {
    return siteOppertunityId;
  }

  static  void setSiteOppertunityId(String siteOppertunityId) {
    UpdatedValues.siteOppertunityId = siteOppertunityId;
  }

  static  int getSiteConstructionId() {
    return siteConstructionId;
  }

  static  void setSiteConstructionId(int siteConstructionId) {
    UpdatedValues.siteConstructionId = siteConstructionId;
  }

  static  List<SiteNextStageEntity> getSiteNextStageEntity() {
    List<SiteNextStageEntity> siteNextStageEntity = new List();
    return siteNextStageEntity;
  }

  static  void setSiteNextStageEntity(List<SiteNextStageEntity> siteNextStageEntity) {
    UpdatedValues.siteNextStageEntity = siteNextStageEntity;
  }

  static  List<SitephotosEntity> getSitePhotosEntity() {
    List<SitephotosEntity> newSitePhotoEntity = new List();
    // sitephotosEntity.clear();
    if(imageList.length>0) {
      for (int i = 0; i < imageList.length; i++) {
        newSitePhotoEntity.add(SitephotosEntity(
            photoName: path.basename(imageList[i].path),
            siteId: getSiteId(),
            createdBy: empCode));
      }
    }
    return newSitePhotoEntity;
  }

  static  void setSitePhotosEntity(List<SitephotosEntity> sitePhotosEntity) {
    UpdatedValues.sitePhotosEntity = sitePhotosEntity;
  }

  static  List<SiteInfluencerEntity> getSiteInfluencerEntity() {
    if(listInfluencerDetail!=null) {
      if (listInfluencerDetail.length != 0) {
        if (listInfluencerDetail[
        listInfluencerDetail.length - 1]
            .inflName ==
            null ||
            listInfluencerDetail[listInfluencerDetail.length - 1].inflName ==
                null ||
            listInfluencerDetail[listInfluencerDetail.length - 1]
                .inflName
                .text.isEmpty) {
          listInfluencerDetail.removeAt(listInfluencerDetail.length - 1);
        }
      }
      List<SiteInfluencerEntity> newInfluencerEntity = new List();
      for (int i = 0; i < listInfluencerDetail.length; i++) {
        newInfluencerEntity.add(SiteInfluencerEntity(
            id: listInfluencerDetail[i].originalId,
            inflId: int.parse(listInfluencerDetail[i].id.text),
            siteId: siteId,
            isDelete: "N",
            isPrimary: listInfluencerDetail[i].isPrimarybool ? "Y" : "N",
            createdBy: empCode));
      }
      return newInfluencerEntity;
    }else{
      return siteInfluencerEntity;
    }
  }

  static  void setSiteInfluencerEntity(List<SiteInfluencerEntity> siteInfluencerEntity) {
    UpdatedValues.siteInfluencerEntity = siteInfluencerEntity;
  }
  static  List<InfluencerDetail> getSiteInfluencerDetails() {
    return listInfluencerDetail;
  }

  static  void setSiteInfluencerDetails(List<InfluencerDetail> listInfluencerDetail) {
    UpdatedValues.listInfluencerDetail = listInfluencerDetail;
  }

  static  String getDealerConfirmedChangedBy() {
    return dealerConfirmedChangedBy;
  }

  static  void setDealerConfirmedChangedBy(String dealerConfirmedChangedBy) {
    UpdatedValues.dealerConfirmedChangedBy = dealerConfirmedChangedBy;
  }

  static  String getDealerConfirmedChangedOn() {
    return dealerConfirmedChangedOn;
  }

  static  void setDealerConfirmedChangedOn(String dealerConfirmedChangedOn) {
    UpdatedValues.dealerConfirmedChangedOn = dealerConfirmedChangedOn;
  }

  static  String getIsDealerConfirmedChangedBySo() {
    return isDealerConfirmedChangedBySo;
  }

  static  void setIsDealerConfirmedChangedBySo(String isDealerConfirmedChangedBySo) {
    UpdatedValues.isDealerConfirmedChangedBySo = isDealerConfirmedChangedBySo;
  }

  static  String getSubdealerId() {
    return subdealerId;
  }

  static  void setSubdealerId(String subdealerId) {
    UpdatedValues.subdealerId = subdealerId;
  }

  static  int getKitchenCount() {
    return kitchenCount;
  }

  static  void setKitchenCount(int kitchenCount) {
    UpdatedValues.kitchenCount = kitchenCount;
  }

  static  int getBathroomCount() {
    return bathroomCount;
  }

  static  void setBathroomCount(int bathroomCount) {
    UpdatedValues.bathroomCount = bathroomCount;
  }

  static  ConstructionStageEntity getSiteProgressConstructionId() {
    return siteProgressConstructionId;
  }

  static  void setSiteProgressConstructionId(ConstructionStageEntity siteProgressConstructionId) {
    UpdatedValues.siteProgressConstructionId = siteProgressConstructionId;
  }

  static  ConstructionStageEntity getConstructionTypeVisitNextStage() {
    return constructionTypeVisitNextStage;
  }

  static  void setConstructionTypeVisitNextStage(ConstructionStageEntity constructionTypeVisitNextStage) {
    UpdatedValues.constructionTypeVisitNextStage = constructionTypeVisitNextStage;
  }

  static  SiteFloorsEntity getSiteProgressNoOfFloors() {
    return siteProgressnoOfFloors;
  }

  static  void setSiteProgressNoOfFloors(SiteFloorsEntity siteProgressnoOfFloors) {
    UpdatedValues.siteProgressnoOfFloors = siteProgressnoOfFloors;
  }

  static  String getSiteProgressStagePotential() {
    return siteProgressStagePotential;
  }

  static  void setSiteProgressStagePotential(String siteProgressStagePotential) {
    UpdatedValues.siteProgressStagePotential = siteProgressStagePotential;
  }

  static  String getSiteProgressStageStatus() {
    return siteProgressStageStatus;
  }

  static  void setSiteProgressStageStatus(String siteProgressStageStatus) {
    UpdatedValues.siteProgressStageStatus = siteProgressStageStatus;
  }

  static  String getSiteProgressDateOfConstruction() {
    return siteProgressDateOfConstruction;
  }

  static  void setSiteProgressDateOfConstruction(String siteProgressDateOfConstruction) {
    UpdatedValues.siteProgressDateOfConstruction = siteProgressDateOfConstruction;
  }

  static void setSiteProgressData(ConstructionStageEntity siteProgressConstructionId,SiteFloorsEntity siteProgressnoOfFloors,String siteProgressStagePotential,String siteProgressStageStatus,String siteProgressDateOfConstruction){
    UpdatedValues.siteProgressConstructionId = siteProgressConstructionId;
    UpdatedValues.siteProgressnoOfFloors = siteProgressnoOfFloors;
    UpdatedValues.siteProgressStagePotential = siteProgressStagePotential;
    UpdatedValues.siteProgressStageStatus = siteProgressStageStatus;
    UpdatedValues.siteProgressDateOfConstruction = siteProgressDateOfConstruction;
  }



  static  void setSiteData(int siteId,int siteConstructionId,String siteBuiltArea,String noOfFloors,int bathroomCount,int kitchenCount,
      String productDemo,String productOralBriefing,String sitePotentialMt,String totalBalancePotential,String siteProbabilityWinningId,String siteCompetitionId,String siteOppertunityId,
      String contactName,String contactNumber,String plotNumber,String siteAddress,String sitePincode,String siteState,
      String siteDistrict,String siteTaluk,String reraNumber,String dealerId,String subdealerId,String soCode,String assignedTo,String siteStatusId,String siteStageId,String siteGeotag,double siteGeotagLat,double siteGeotagLong,String siteCreationDate,String siteSegment) {
    UpdatedValues.siteId = siteId;
    UpdatedValues.siteConstructionId = siteConstructionId;
    UpdatedValues.siteBuiltArea = siteBuiltArea;
    UpdatedValues.noOfFloors = noOfFloors;
    UpdatedValues.bathroomCount = bathroomCount;
    UpdatedValues.kitchenCount = kitchenCount;
    UpdatedValues.productDemo = productDemo;
    UpdatedValues.productOralBriefing = productOralBriefing;
    UpdatedValues.sitePotentialMt = sitePotentialMt;
    UpdatedValues.totalBalancePotential = totalBalancePotential;
    UpdatedValues.siteProbabilityWinningId = siteProbabilityWinningId;
    UpdatedValues.siteCompetitionId = siteCompetitionId;
    UpdatedValues.siteOppertunityId = siteOppertunityId;
    UpdatedValues.contactName = contactName;
    UpdatedValues.contactNumber = contactNumber;
    UpdatedValues.plotNumber = plotNumber;
    UpdatedValues.siteAddress = siteAddress;
    UpdatedValues.sitePincode = sitePincode;
    UpdatedValues.siteState = siteState;
    UpdatedValues.siteDistrict = siteDistrict;
    UpdatedValues.siteTaluk = siteTaluk;
    UpdatedValues.reraNumber = reraNumber;
    UpdatedValues.dealerId = dealerId;
    UpdatedValues.subdealerId = subdealerId;
    UpdatedValues.soCode = soCode;
    UpdatedValues.assignedTo = assignedTo;
    UpdatedValues.siteStatusId = siteStatusId;
    UpdatedValues.siteStageId = siteStageId;
    UpdatedValues.siteGeotag = siteGeotag;
    UpdatedValues.siteGeotagLat = siteGeotagLat;
    UpdatedValues.siteGeotagLong = siteGeotagLong;
    UpdatedValues.siteCreationDate = siteCreationDate;
    UpdatedValues.siteSegment = siteSegment;
  }
}