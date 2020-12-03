library testweb.globals;


import 'dart:io';

import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/DraftLeadModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/SaveLeadRequestModel.dart';
import 'package:flutter_tech_sales/presentation/features/leads_screen/data/model/ViewLeadDataResponse.dart';

String selectedLeadID = '';
String currentId = '';
int draftID ;
bool fromLead = false;
List<LeadRejectReasonEntity> leadRejectReasonEntity = new List();
List<NextStageConstructionEntity> nextStageConstructionEntity= new List();
List<DealerList> dealerList = new List();
SaveLeadRequestDraftModel saveLeadRequestModel = new SaveLeadRequestDraftModel();
SaveLeadRequestModel saveLeadRequestModelNew = new SaveLeadRequestModel();
List<File> imageList = new List();