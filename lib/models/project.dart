import 'package:blu_time/utilities/apis/decodable.dart';

class ProjectResponse implements Decodable<ProjectResponse> {
  List<Project2>? projectList;

  ProjectResponse({this.projectList});

  ProjectResponse.fromJson(Map<String, dynamic> json) {
    if (json['projectList'] != null) {
      projectList = <Project2>[];
      json['projectList'].forEach((v) {
        projectList!.add(Project2.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (projectList != null) {
      data['projectList'] = projectList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  ProjectResponse decode(json) {
    return ProjectResponse.fromJson(json);
  }
}

class Project2 {
  String? projectId;
  String? name;
  String? address;
  String? startDateTime;
  String? endDateTime;
  List<Notes>? notes;
  List<Images>? images;
  int? totalTime;
  List<Tasks>? tasks;
  List<Breaks>? breaks;

  Project2(
      {this.projectId,
        this.name,
        this.address,
        this.startDateTime,
        this.endDateTime,
        this.notes,
        this.images,
        this.totalTime,
        this.tasks,
        this.breaks});

  Project2.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    name = json['name'];
    address = json['address'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    if (json['notes'] != null) {
      notes = <Notes>[];
      json['notes'].forEach((v) {
        notes!.add(Notes.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    totalTime = json['totalTime'];
    if (json['tasks'] != null) {
      tasks = <Tasks>[];
      json['tasks'].forEach((v) {
        tasks!.add(Tasks.fromJson(v));
      });
    }
    if (json['breaks'] != null) {
      breaks = <Breaks>[];
      json['breaks'].forEach((v) {
        breaks!.add(Breaks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['name'] = name;
    data['address'] = address;
    data['startDateTime'] = startDateTime;
    data['endDateTime'] = endDateTime;
    if (notes != null) {
      data['notes'] = notes!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['totalTime'] = totalTime;
    if (tasks != null) {
      data['tasks'] = tasks!.map((v) => v.toJson()).toList();
    }
    if (breaks != null) {
      data['breaks'] = breaks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notes {
  String? noteId;
  String? note;
  String? projectId;

  Notes({this.noteId, this.note,this.projectId});

  Notes.fromJson(Map<String, dynamic> json) {
    noteId = json['noteId'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['noteId'] = noteId;
    data['note'] = note;
    return data;
  }
}

class Images {
  String? imageId;
  String? imgLink1;
  String? imgLink2;

  Images({this.imageId, this.imgLink1, this.imgLink2});

  Images.fromJson(Map<String, dynamic> json) {
    imageId = json['imageId'];
    imgLink1 = json['img_link1'];
    imgLink2 = json['img_link2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageId'] = imageId;
    data['img_link1'] = imgLink1;
    data['img_link2'] = imgLink2;
    return data;
  }
}

class Tasks {
  int? taskId;
  String? taskDescription;
  String? startDateTime;
  String? endDateTime;
  int? totalTime;
  String? note;
  List<Images>? images;

  Tasks(
      {this.taskId,
        this.taskDescription,
        this.startDateTime,
        this.endDateTime,
        this.totalTime,
        this.note,
        this.images});

  Tasks.fromJson(Map<String, dynamic> json) {
    taskId = json['taskId'];
    taskDescription = json['taskDescription'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    totalTime = json['totalTime'];
    note = json['note'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['taskId'] = taskId;
    data['taskDescription'] = taskDescription;
    data['startDateTime'] = startDateTime;
    data['endDateTime'] = endDateTime;
    data['totalTime'] = totalTime;
    data['note'] = note;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Breaks {
  int? id;
  String? btype;
  String? fromTime;
  String? toTime;

  Breaks({this.id, this.btype, this.fromTime, this.toTime});

  Breaks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    btype = json['btype'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['btype'] = btype;
    data['fromTime'] = fromTime;
    data['toTime'] = toTime;
    return data;
  }
}




class QueryResult extends Decodable<QueryResult>{
  List<Links>? links;
  int? count;
  bool? hasMore;
  List<Project>? items;
  int? offset;
  int? totalResults;

  QueryResult(
      {this.links,
        this.count,
        this.hasMore,
        this.items,
        this.offset,
        this.totalResults});

  QueryResult.fromJson(Map<String, dynamic> json) {
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    count = json['count'];
    hasMore = json['hasMore'];
    if (json['items'] != null) {
      items = <Project>[];
      json['items'].forEach((v) {
        items!.add(new Project.fromJson(v));
      });
    }
    offset = json['offset'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    data['hasMore'] = hasMore;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['offset'] = offset;
    data['totalResults'] = totalResults;
    return data;
  }

  @override
  QueryResult decode(json) {
    // TODO: implement decode
    throw UnimplementedError();
  }
}

class Links {
  String? rel;
  String? href;

  Links({this.rel, this.href});

  Links.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rel'] = rel;
    data['href'] = href;
    return data;
  }
}

class Project extends Decodable<Project>{
  List<Null>? links;
  String? actualtime;
  String? allowallresourcesfortasks;
  String? allowexpenses;
  String? allowtime;
  String? altname;
  String? csegBbProject;
  String? currency;
  String? currencyprecision;
  String? custentityBbBomEdited;
  String? custentityBbCommDifferenceApproved;
  String? custentityBbCustomerCategory;
  String? custentityBbDownPaymentAllMilestone;
  String? custentityBbEntityLatitudeText;
  String? custentityBbEntityLongitudeText;
  String? custentityBbEquipCostAmount;
  String? custentityBbEquipCostPerWattAmount;
  String? custentityBbFinFixedAdderAmt;
  String? custentityBbFinInstallBaseAmt;
  String? custentityBbFinM0InvoiceAmount;
  String? custentityBbFinM1InvoiceAmount;
  String? custentityBbFinM2InvoiceAmount;
  String? custentityBbFinM3InvoiceAmount;
  String? custentityBbFinOrigBaseAmt;
  String? custentityBbFinOrigPerWattAmt;
  String? custentityBbFinPerFootAdderAmt;
  String? custentityBbFinPerModuleAdderAmt;
  String? custentityBbFinPerWattAdderAmt;
  String? custentityBbFinancingType;
  String? custentityBbForecastDesignDate;
  String? custentityBbForecastInspectionDate;
  String? custentityBbForecastPermitDate;
  String? custentityBbForecastPtoDate;
  String? custentityBbForecastSiteSurveyDate;
  String? custentityBbForecastedInstallDate;
  String? custentityBbGoogleMapsApiKey;
  String? custentityBbHas400aService;
  String? custentityBbHasLiftGate;
  String? custentityBbHomeOwnerNameText;
  String? custentityBbHomeOwnerPrimaryEmail;
  String? custentityBbInspectionAmount;
  String? custentityBbInstallAddress1Text;
  String? custentityBbInstallAddress2Text;
  String? custentityBbInstallCityText;
  String? custentityBbInstallState;
  String? custentityBbInstallZipCodeText;
  String? custentityBbInstallerAdderTotalAmt;
  String? custentityBbInstallerFxdAddrTtlAmt;
  String? custentityBbInstallrPFtAddrTtlAmt;
  String? custentityBbInstllrPrMdAddrTtlAmt;
  String? custentityBbInstllrPrWtAddrTtlAmt;
  String? custentityBbIsBirdNetting;
  String? custentityBbIsOccupied;
  String? custentityBbIsProjectTemplate;
  String? custentityBbIsResidentialDelivery;
  String? custentityBbIsVendorOwnedInverter;
  String? custentityBbLeadStartDate;
  String? custentityBbObProjectUuid;
  String? custentityBbOrgntrAddrTtlAmt;
  String? custentityBbOrgntrAddrTtlPWattAmt;
  String? custentityBbOrgntrFxdAddrTtlAmt;
  String? custentityBbOrgntrPayTotPWAmt;
  String? custentityBbOrgntrPerFtAddrTtlAmt;
  String? custentityBbOrgntrPerModAdderAmt;
  String? custentityBbOrgntrPerWattAdderAmt;
  String? custentityBbOrigOverrideBoolean;
  String? custentityBbOrigPaymentsOnHoldBool;
  String? custentityBbPrefersDesignAmtAsAddr;
  String? custentityBbPrefersSiteAuditAsAddr;
  String? custentityBbProjectAcctgMethod;
  String? custentityBbProjectStageText;
  String? custentityBbProjectStartDate;
  String? custentityBbRequireCallAhead;
  String? custentityBbRequiresHoaApplication;
  String? custentityBbSalesCostPWattAmount;
  String? custentityBbSsAlreadyInvoicedAmount;
  String? custentityBbSsInstAlreadyBilledAmt;
  String? custentityBbTotalDealerFeeAmount;
  String? custentityBbTotalProjectArAmount;
  String? custentityBbWarrantyReserveAmount;
  String? custentityBbssConfiguration;
  String? custentityEnableEngProgLookup;
  String? custentityF4nSyncAll;
  String? customer;
  String? datecreated;
  String? entityid;
  String? entitynumber;
  String? entitytitle;
  String? estimatedgrossprofit;
  String? estimatedlaborcost;
  String? estimatedlaborrevenue;
  String? estimatedtime;
  String? estimatedtimeoverride;
  String? fxrate;
  String? id;
  String? includecrmtasksintotals;
  String? isexempttime;
  String? isinactive;
  String? isproductivetime;
  String? isutilizedtime;
  String? jobtype;
  String? lastmodifieddate;
  String? limittimetoassignees;
  String? materializetime;
  String? parent;
  String? percenttimecomplete;
  String? startdate;
  String? timeapproval;
  String? timeremaining;
  String? usepercentcompleteoverride;
  String? companyname;
  String? custentityBbBomStatusList;
  String? custentityBbFinM0InvoicePercent;
  String? custentityBbFinM1InvoicePercent;
  String? custentityBbFinM2InvoicePercent;
  String? custentityBbFinM3InvoicePercent;
  String? custentityBbFinM4InvoiceAmount;
  String? custentityBbFinM5InvoiceAmount;
  String? custentityBbFinM6InvoiceAmount;
  String? custentityBbFinM7InvoiceAmount;
  String? custentityBbFinPrelimPurchPriceAmt;
  String? custentityBbFinPurPricePWattAmt;
  String? custentityBbFinRebateInvAmount;
  String? custentityBbFinTotalFeesAmount;
  String? custentityBbFinTotalInvoiceAmount;
  String? custentityBbFinancierAdvPmtSchedule;
  String? custentityBbFinancierCustomer;
  String? custentityBbFinancierPaymentSchedule;
  String? custentityBbGrossAdderTotal;
  String? custentityBbGrossProfitAmount;
  String? custentityBbGrossProfitPercent;
  String? custentityBbHomeownerCustomer;
  String? custentityBbInstallCompPackLastDt;
  String? custentityBbInstallCompPackStartDt;
  String? custentityBbInstallCompPackStatTxt;
  String? custentityBbInstallPayoutTotal;
  String? custentityBbInventoryAmount;
  String? custentityBbM0DealerFeeAmount;
  String? custentityBbM1DealerFeeAmount;
  String? custentityBbM2DealerFeeAmount;
  String? custentityBbM3DealerFeeAmount;
  String? custentityBbM3FinanceAction;
  String? custentityBbM4DealerFeeAmount;
  String? custentityBbM5DealerFeeAmount;
  String? custentityBbM6DealerFeeAmount;
  String? custentityBbM7DealerFeeAmount;
  String? custentityBbNetPricePerWatt;
  String? custentityBbOrigPayoutTotal;
  String? custentityBbOrigVendBillTotal;
  String? custentityBbOrigVendCreditTotal;
  String? custentityBbProjectSo;
  String? custentityBbProjectSubStageText;
  String? custentityBbRebateVarianceAmount;
  String? custentityBbRevenuePerWattAmount;
  String? custentityBbSalesTaxAmount;
  String? custentityBbSolarPortionContractAmt;
  String? custentityBbStartedFromProjTemplate;
  String? custentityBbSubinstlVendBillTotal;
  String? custentityBbSubinstlVendCreditTotal;
  String? custentityBbSystemSizeDecimal;
  String? custentityBbTotConValuePerWattAmt;
  String? custentityBbTotalContractValueAmt;
  String? custentityBbUatDataBoolean;

  Project(
      {this.links,
        this.actualtime,
        this.allowallresourcesfortasks,
        this.allowexpenses,
        this.allowtime,
        this.altname,
        this.csegBbProject,
        this.currency,
        this.currencyprecision,
        this.custentityBbBomEdited,
        this.custentityBbCommDifferenceApproved,
        this.custentityBbCustomerCategory,
        this.custentityBbDownPaymentAllMilestone,
        this.custentityBbEntityLatitudeText,
        this.custentityBbEntityLongitudeText,
        this.custentityBbEquipCostAmount,
        this.custentityBbEquipCostPerWattAmount,
        this.custentityBbFinFixedAdderAmt,
        this.custentityBbFinInstallBaseAmt,
        this.custentityBbFinM0InvoiceAmount,
        this.custentityBbFinM1InvoiceAmount,
        this.custentityBbFinM2InvoiceAmount,
        this.custentityBbFinM3InvoiceAmount,
        this.custentityBbFinOrigBaseAmt,
        this.custentityBbFinOrigPerWattAmt,
        this.custentityBbFinPerFootAdderAmt,
        this.custentityBbFinPerModuleAdderAmt,
        this.custentityBbFinPerWattAdderAmt,
        this.custentityBbFinancingType,
        this.custentityBbForecastDesignDate,
        this.custentityBbForecastInspectionDate,
        this.custentityBbForecastPermitDate,
        this.custentityBbForecastPtoDate,
        this.custentityBbForecastSiteSurveyDate,
        this.custentityBbForecastedInstallDate,
        this.custentityBbGoogleMapsApiKey,
        this.custentityBbHas400aService,
        this.custentityBbHasLiftGate,
        this.custentityBbHomeOwnerNameText,
        this.custentityBbHomeOwnerPrimaryEmail,
        this.custentityBbInspectionAmount,
        this.custentityBbInstallAddress1Text,
        this.custentityBbInstallAddress2Text,
        this.custentityBbInstallCityText,
        this.custentityBbInstallState,
        this.custentityBbInstallZipCodeText,
        this.custentityBbInstallerAdderTotalAmt,
        this.custentityBbInstallerFxdAddrTtlAmt,
        this.custentityBbInstallrPFtAddrTtlAmt,
        this.custentityBbInstllrPrMdAddrTtlAmt,
        this.custentityBbInstllrPrWtAddrTtlAmt,
        this.custentityBbIsBirdNetting,
        this.custentityBbIsOccupied,
        this.custentityBbIsProjectTemplate,
        this.custentityBbIsResidentialDelivery,
        this.custentityBbIsVendorOwnedInverter,
        this.custentityBbLeadStartDate,
        this.custentityBbObProjectUuid,
        this.custentityBbOrgntrAddrTtlAmt,
        this.custentityBbOrgntrAddrTtlPWattAmt,
        this.custentityBbOrgntrFxdAddrTtlAmt,
        this.custentityBbOrgntrPayTotPWAmt,
        this.custentityBbOrgntrPerFtAddrTtlAmt,
        this.custentityBbOrgntrPerModAdderAmt,
        this.custentityBbOrgntrPerWattAdderAmt,
        this.custentityBbOrigOverrideBoolean,
        this.custentityBbOrigPaymentsOnHoldBool,
        this.custentityBbPrefersDesignAmtAsAddr,
        this.custentityBbPrefersSiteAuditAsAddr,
        this.custentityBbProjectAcctgMethod,
        this.custentityBbProjectStageText,
        this.custentityBbProjectStartDate,
        this.custentityBbRequireCallAhead,
        this.custentityBbRequiresHoaApplication,
        this.custentityBbSalesCostPWattAmount,
        this.custentityBbSsAlreadyInvoicedAmount,
        this.custentityBbSsInstAlreadyBilledAmt,
        this.custentityBbTotalDealerFeeAmount,
        this.custentityBbTotalProjectArAmount,
        this.custentityBbWarrantyReserveAmount,
        this.custentityBbssConfiguration,
        this.custentityEnableEngProgLookup,
        this.custentityF4nSyncAll,
        this.customer,
        this.datecreated,
        this.entityid,
        this.entitynumber,
        this.entitytitle,
        this.estimatedgrossprofit,
        this.estimatedlaborcost,
        this.estimatedlaborrevenue,
        this.estimatedtime,
        this.estimatedtimeoverride,
        this.fxrate,
        this.id,
        this.includecrmtasksintotals,
        this.isexempttime,
        this.isinactive,
        this.isproductivetime,
        this.isutilizedtime,
        this.jobtype,
        this.lastmodifieddate,
        this.limittimetoassignees,
        this.materializetime,
        this.parent,
        this.percenttimecomplete,
        this.startdate,
        this.timeapproval,
        this.timeremaining,
        this.usepercentcompleteoverride,
        this.companyname,
        this.custentityBbBomStatusList,
        this.custentityBbFinM0InvoicePercent,
        this.custentityBbFinM1InvoicePercent,
        this.custentityBbFinM2InvoicePercent,
        this.custentityBbFinM3InvoicePercent,
        this.custentityBbFinM4InvoiceAmount,
        this.custentityBbFinM5InvoiceAmount,
        this.custentityBbFinM6InvoiceAmount,
        this.custentityBbFinM7InvoiceAmount,
        this.custentityBbFinPrelimPurchPriceAmt,
        this.custentityBbFinPurPricePWattAmt,
        this.custentityBbFinRebateInvAmount,
        this.custentityBbFinTotalFeesAmount,
        this.custentityBbFinTotalInvoiceAmount,
        this.custentityBbFinancierAdvPmtSchedule,
        this.custentityBbFinancierCustomer,
        this.custentityBbFinancierPaymentSchedule,
        this.custentityBbGrossAdderTotal,
        this.custentityBbGrossProfitAmount,
        this.custentityBbGrossProfitPercent,
        this.custentityBbHomeownerCustomer,
        this.custentityBbInstallCompPackLastDt,
        this.custentityBbInstallCompPackStartDt,
        this.custentityBbInstallCompPackStatTxt,
        this.custentityBbInstallPayoutTotal,
        this.custentityBbInventoryAmount,
        this.custentityBbM0DealerFeeAmount,
        this.custentityBbM1DealerFeeAmount,
        this.custentityBbM2DealerFeeAmount,
        this.custentityBbM3DealerFeeAmount,
        this.custentityBbM3FinanceAction,
        this.custentityBbM4DealerFeeAmount,
        this.custentityBbM5DealerFeeAmount,
        this.custentityBbM6DealerFeeAmount,
        this.custentityBbM7DealerFeeAmount,
        this.custentityBbNetPricePerWatt,
        this.custentityBbOrigPayoutTotal,
        this.custentityBbOrigVendBillTotal,
        this.custentityBbOrigVendCreditTotal,
        this.custentityBbProjectSo,
        this.custentityBbProjectSubStageText,
        this.custentityBbRebateVarianceAmount,
        this.custentityBbRevenuePerWattAmount,
        this.custentityBbSalesTaxAmount,
        this.custentityBbSolarPortionContractAmt,
        this.custentityBbStartedFromProjTemplate,
        this.custentityBbSubinstlVendBillTotal,
        this.custentityBbSubinstlVendCreditTotal,
        this.custentityBbSystemSizeDecimal,
        this.custentityBbTotConValuePerWattAmt,
        this.custentityBbTotalContractValueAmt,
        this.custentityBbUatDataBoolean});

  Project.fromJson(Map<String, dynamic> json) {
    // if (json['links'] != null) {
    //   links = <Null>[];
    //   json['links'].forEach((v) {
    //     links!.add(new Null.fromJson(v));
    //   });
    // }
    actualtime = json['actualtime'];
    allowallresourcesfortasks = json['allowallresourcesfortasks'];
    allowexpenses = json['allowexpenses'];
    allowtime = json['allowtime'];
    altname = json['altname'];
    csegBbProject = json['cseg_bb_project'];
    currency = json['currency'];
    currencyprecision = json['currencyprecision'];
    custentityBbBomEdited = json['custentity_bb_bom_edited'];
    custentityBbCommDifferenceApproved =
    json['custentity_bb_comm_difference_approved'];
    custentityBbCustomerCategory = json['custentity_bb_customer_category'];
    custentityBbDownPaymentAllMilestone =
    json['custentity_bb_down_payment_all_milestone'];
    custentityBbEntityLatitudeText = json['custentity_bb_entity_latitude_text'];
    custentityBbEntityLongitudeText =
    json['custentity_bb_entity_longitude_text'];
    custentityBbEquipCostAmount = json['custentity_bb_equip_cost_amount'];
    custentityBbEquipCostPerWattAmount =
    json['custentity_bb_equip_cost_per_watt_amount'];
    custentityBbFinFixedAdderAmt = json['custentity_bb_fin_fixed_adder_amt'];
    custentityBbFinInstallBaseAmt = json['custentity_bb_fin_install_base_amt'];
    custentityBbFinM0InvoiceAmount =
    json['custentity_bb_fin_m0_invoice_amount'];
    custentityBbFinM1InvoiceAmount =
    json['custentity_bb_fin_m1_invoice_amount'];
    custentityBbFinM2InvoiceAmount =
    json['custentity_bb_fin_m2_invoice_amount'];
    custentityBbFinM3InvoiceAmount =
    json['custentity_bb_fin_m3_invoice_amount'];
    custentityBbFinOrigBaseAmt = json['custentity_bb_fin_orig_base_amt'];
    custentityBbFinOrigPerWattAmt = json['custentity_bb_fin_orig_per_watt_amt'];
    custentityBbFinPerFootAdderAmt =
    json['custentity_bb_fin_per_foot_adder_amt'];
    custentityBbFinPerModuleAdderAmt =
    json['custentity_bb_fin_per_module_adder_amt'];
    custentityBbFinPerWattAdderAmt =
    json['custentity_bb_fin_per_watt_adder_amt'];
    custentityBbFinancingType = json['custentity_bb_financing_type'];
    custentityBbForecastDesignDate = json['custentity_bb_forecast_design_date'];
    custentityBbForecastInspectionDate =
    json['custentity_bb_forecast_inspection_date'];
    custentityBbForecastPermitDate = json['custentity_bb_forecast_permit_date'];
    custentityBbForecastPtoDate = json['custentity_bb_forecast_pto_date'];
    custentityBbForecastSiteSurveyDate =
    json['custentity_bb_forecast_site_survey_date'];
    custentityBbForecastedInstallDate =
    json['custentity_bb_forecasted_install_date'];
    custentityBbGoogleMapsApiKey = json['custentity_bb_google_maps_api_key'];
    custentityBbHas400aService = json['custentity_bb_has_400a_service'];
    custentityBbHasLiftGate = json['custentity_bb_has_lift_gate'];
    custentityBbHomeOwnerNameText = json['custentity_bb_home_owner_name_text'];
    custentityBbHomeOwnerPrimaryEmail =
    json['custentity_bb_home_owner_primary_email'];
    custentityBbInspectionAmount = json['custentity_bb_inspection_amount'];
    custentityBbInstallAddress1Text =
    json['custentity_bb_install_address_1_text'];
    custentityBbInstallAddress2Text =
    json['custentity_bb_install_address_2_text'];
    custentityBbInstallCityText = json['custentity_bb_install_city_text'];
    custentityBbInstallState = json['custentity_bb_install_state'];
    custentityBbInstallZipCodeText =
    json['custentity_bb_install_zip_code_text'];
    custentityBbInstallerAdderTotalAmt =
    json['custentity_bb_installer_adder_total_amt'];
    custentityBbInstallerFxdAddrTtlAmt =
    json['custentity_bb_installer_fxd_addr_ttl_amt'];
    custentityBbInstallrPFtAddrTtlAmt =
    json['custentity_bb_installr_p_ft_addr_ttl_amt'];
    custentityBbInstllrPrMdAddrTtlAmt =
    json['custentity_bb_instllr_pr_md_addr_ttl_amt'];
    custentityBbInstllrPrWtAddrTtlAmt =
    json['custentity_bb_instllr_pr_wt_addr_ttl_amt'];
    custentityBbIsBirdNetting = json['custentity_bb_is_bird_netting'];
    custentityBbIsOccupied = json['custentity_bb_is_occupied'];
    custentityBbIsProjectTemplate = json['custentity_bb_is_project_template'];
    custentityBbIsResidentialDelivery =
    json['custentity_bb_is_residential_delivery'];
    custentityBbIsVendorOwnedInverter =
    json['custentity_bb_is_vendor_owned_inverter'];
    custentityBbLeadStartDate = json['custentity_bb_lead_start_date'];
    custentityBbObProjectUuid = json['custentity_bb_ob_project_uuid'];
    custentityBbOrgntrAddrTtlAmt = json['custentity_bb_orgntr_addr_ttl_amt'];
    custentityBbOrgntrAddrTtlPWattAmt =
    json['custentity_bb_orgntr_addr_ttl_p_watt_amt'];
    custentityBbOrgntrFxdAddrTtlAmt =
    json['custentity_bb_orgntr_fxd_addr_ttl_amt'];
    custentityBbOrgntrPayTotPWAmt =
    json['custentity_bb_orgntr_pay_tot_p_w_amt'];
    custentityBbOrgntrPerFtAddrTtlAmt =
    json['custentity_bb_orgntr_per_ft_addr_ttl_amt'];
    custentityBbOrgntrPerModAdderAmt =
    json['custentity_bb_orgntr_per_mod_adder_amt'];
    custentityBbOrgntrPerWattAdderAmt =
    json['custentity_bb_orgntr_per_watt_adder_amt'];
    custentityBbOrigOverrideBoolean =
    json['custentity_bb_orig_override_boolean'];
    custentityBbOrigPaymentsOnHoldBool =
    json['custentity_bb_orig_payments_on_hold_bool'];
    custentityBbPrefersDesignAmtAsAddr =
    json['custentity_bb_prefers_design_amt_as_addr'];
    custentityBbPrefersSiteAuditAsAddr =
    json['custentity_bb_prefers_site_audit_as_addr'];
    custentityBbProjectAcctgMethod = json['custentity_bb_project_acctg_method'];
    custentityBbProjectStageText = json['custentity_bb_project_stage_text'];
    custentityBbProjectStartDate = json['custentity_bb_project_start_date'];
    custentityBbRequireCallAhead = json['custentity_bb_require_call_ahead'];
    custentityBbRequiresHoaApplication =
    json['custentity_bb_requires_hoa_application'];
    custentityBbSalesCostPWattAmount =
    json['custentity_bb_sales_cost_p_watt_amount'];
    custentityBbSsAlreadyInvoicedAmount =
    json['custentity_bb_ss_already_invoiced_amount'];
    custentityBbSsInstAlreadyBilledAmt =
    json['custentity_bb_ss_inst_already_billed_amt'];
    custentityBbTotalDealerFeeAmount =
    json['custentity_bb_total_dealer_fee_amount'];
    custentityBbTotalProjectArAmount =
    json['custentity_bb_total_project_ar_amount'];
    custentityBbWarrantyReserveAmount =
    json['custentity_bb_warranty_reserve_amount'];
    custentityBbssConfiguration = json['custentity_bbss_configuration'];
    custentityEnableEngProgLookup = json['custentity_enable_eng_prog_lookup'];
    custentityF4nSyncAll = json['custentity_f4n_sync_all'];
    customer = json['customer'];
    datecreated = json['datecreated'];
    entityid = json['entityid'];
    entitynumber = json['entitynumber'];
    entitytitle = json['entitytitle'];
    estimatedgrossprofit = json['estimatedgrossprofit'];
    estimatedlaborcost = json['estimatedlaborcost'];
    estimatedlaborrevenue = json['estimatedlaborrevenue'];
    estimatedtime = json['estimatedtime'];
    estimatedtimeoverride = json['estimatedtimeoverride'];
    fxrate = json['fxrate'];
    id = json['id'];
    includecrmtasksintotals = json['includecrmtasksintotals'];
    isexempttime = json['isexempttime'];
    isinactive = json['isinactive'];
    isproductivetime = json['isproductivetime'];
    isutilizedtime = json['isutilizedtime'];
    jobtype = json['jobtype'];
    lastmodifieddate = json['lastmodifieddate'];
    limittimetoassignees = json['limittimetoassignees'];
    materializetime = json['materializetime'];
    parent = json['parent'];
    percenttimecomplete = json['percenttimecomplete'];
    startdate = json['startdate'];
    timeapproval = json['timeapproval'];
    timeremaining = json['timeremaining'];
    usepercentcompleteoverride = json['usepercentcompleteoverride'];
    companyname = json['companyname'];
    custentityBbBomStatusList = json['custentity_bb_bom_status_list'];
    custentityBbFinM0InvoicePercent =
    json['custentity_bb_fin_m0_invoice_percent'];
    custentityBbFinM1InvoicePercent =
    json['custentity_bb_fin_m1_invoice_percent'];
    custentityBbFinM2InvoicePercent =
    json['custentity_bb_fin_m2_invoice_percent'];
    custentityBbFinM3InvoicePercent =
    json['custentity_bb_fin_m3_invoice_percent'];
    custentityBbFinM4InvoiceAmount =
    json['custentity_bb_fin_m4_invoice_amount'];
    custentityBbFinM5InvoiceAmount =
    json['custentity_bb_fin_m5_invoice_amount'];
    custentityBbFinM6InvoiceAmount =
    json['custentity_bb_fin_m6_invoice_amount'];
    custentityBbFinM7InvoiceAmount =
    json['custentity_bb_fin_m7_invoice_amount'];
    custentityBbFinPrelimPurchPriceAmt =
    json['custentity_bb_fin_prelim_purch_price_amt'];
    custentityBbFinPurPricePWattAmt =
    json['custentity_bb_fin_pur_price_p_watt_amt'];
    custentityBbFinRebateInvAmount =
    json['custentity_bb_fin_rebate_inv_amount'];
    custentityBbFinTotalFeesAmount =
    json['custentity_bb_fin_total_fees_amount'];
    custentityBbFinTotalInvoiceAmount =
    json['custentity_bb_fin_total_invoice_amount'];
    custentityBbFinancierAdvPmtSchedule =
    json['custentity_bb_financier_adv_pmt_schedule'];
    custentityBbFinancierCustomer = json['custentity_bb_financier_customer'];
    custentityBbFinancierPaymentSchedule =
    json['custentity_bb_financier_payment_schedule'];
    custentityBbGrossAdderTotal = json['custentity_bb_gross_adder_total'];
    custentityBbGrossProfitAmount = json['custentity_bb_gross_profit_amount'];
    custentityBbGrossProfitPercent = json['custentity_bb_gross_profit_percent'];
    custentityBbHomeownerCustomer = json['custentity_bb_homeowner_customer'];
    custentityBbInstallCompPackLastDt =
    json['custentity_bb_install_comp_pack_last_dt'];
    custentityBbInstallCompPackStartDt =
    json['custentity_bb_install_comp_pack_start_dt'];
    custentityBbInstallCompPackStatTxt =
    json['custentity_bb_install_comp_pack_stat_txt'];
    custentityBbInstallPayoutTotal = json['custentity_bb_install_payout_total'];
    custentityBbInventoryAmount = json['custentity_bb_inventory_amount'];
    custentityBbM0DealerFeeAmount = json['custentity_bb_m0_dealer_fee_amount'];
    custentityBbM1DealerFeeAmount = json['custentity_bb_m1_dealer_fee_amount'];
    custentityBbM2DealerFeeAmount = json['custentity_bb_m2_dealer_fee_amount'];
    custentityBbM3DealerFeeAmount = json['custentity_bb_m3_dealer_fee_amount'];
    custentityBbM3FinanceAction = json['custentity_bb_m3_finance_action'];
    custentityBbM4DealerFeeAmount = json['custentity_bb_m4_dealer_fee_amount'];
    custentityBbM5DealerFeeAmount = json['custentity_bb_m5_dealer_fee_amount'];
    custentityBbM6DealerFeeAmount = json['custentity_bb_m6_dealer_fee_amount'];
    custentityBbM7DealerFeeAmount = json['custentity_bb_m7_dealer_fee_amount'];
    custentityBbNetPricePerWatt = json['custentity_bb_net_price_per_watt'];
    custentityBbOrigPayoutTotal = json['custentity_bb_orig_payout_total'];
    custentityBbOrigVendBillTotal = json['custentity_bb_orig_vend_bill_total'];
    custentityBbOrigVendCreditTotal =
    json['custentity_bb_orig_vend_credit_total'];
    custentityBbProjectSo = json['custentity_bb_project_so'];
    custentityBbProjectSubStageText =
    json['custentity_bb_project_sub_stage_text'];
    custentityBbRebateVarianceAmount =
    json['custentity_bb_rebate_variance_amount'];
    custentityBbRevenuePerWattAmount =
    json['custentity_bb_revenue_per_watt_amount'];
    custentityBbSalesTaxAmount = json['custentity_bb_sales_tax_amount'];
    custentityBbSolarPortionContractAmt =
    json['custentity_bb_solar_portion_contract_amt'];
    custentityBbStartedFromProjTemplate =
    json['custentity_bb_started_from_proj_template'];
    custentityBbSubinstlVendBillTotal =
    json['custentity_bb_subinstl_vend_bill_total'];
    custentityBbSubinstlVendCreditTotal =
    json['custentity_bb_subinstl_vend_credit_total'];
    custentityBbSystemSizeDecimal = json['custentity_bb_system_size_decimal'];
    custentityBbTotConValuePerWattAmt =
    json['custentity_bb_tot_con_value_per_watt_amt'];
    custentityBbTotalContractValueAmt =
    json['custentity_bb_total_contract_value_amt'];
    custentityBbUatDataBoolean = json['custentity_bb_uat_data_boolean'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (links != null) {
    //   data['links'] = links!.map((v) => v.toJson()).toList();
    // }
    data['actualtime'] = actualtime;
    data['allowallresourcesfortasks'] = allowallresourcesfortasks;
    data['allowexpenses'] = allowexpenses;
    data['allowtime'] = allowtime;
    data['altname'] = altname;
    data['cseg_bb_project'] = csegBbProject;
    data['currency'] = currency;
    data['currencyprecision'] = currencyprecision;
    data['custentity_bb_bom_edited'] = custentityBbBomEdited;
    data['custentity_bb_comm_difference_approved'] =
        custentityBbCommDifferenceApproved;
    data['custentity_bb_customer_category'] = custentityBbCustomerCategory;
    data['custentity_bb_down_payment_all_milestone'] =
        custentityBbDownPaymentAllMilestone;
    data['custentity_bb_entity_latitude_text'] =
        custentityBbEntityLatitudeText;
    data['custentity_bb_entity_longitude_text'] =
        custentityBbEntityLongitudeText;
    data['custentity_bb_equip_cost_amount'] = custentityBbEquipCostAmount;
    data['custentity_bb_equip_cost_per_watt_amount'] =
        custentityBbEquipCostPerWattAmount;
    data['custentity_bb_fin_fixed_adder_amt'] =
        custentityBbFinFixedAdderAmt;
    data['custentity_bb_fin_install_base_amt'] =
        custentityBbFinInstallBaseAmt;
    data['custentity_bb_fin_m0_invoice_amount'] =
        custentityBbFinM0InvoiceAmount;
    data['custentity_bb_fin_m1_invoice_amount'] =
        custentityBbFinM1InvoiceAmount;
    data['custentity_bb_fin_m2_invoice_amount'] =
        custentityBbFinM2InvoiceAmount;
    data['custentity_bb_fin_m3_invoice_amount'] =
        custentityBbFinM3InvoiceAmount;
    data['custentity_bb_fin_orig_base_amt'] = custentityBbFinOrigBaseAmt;
    data['custentity_bb_fin_orig_per_watt_amt'] =
        custentityBbFinOrigPerWattAmt;
    data['custentity_bb_fin_per_foot_adder_amt'] =
        custentityBbFinPerFootAdderAmt;
    data['custentity_bb_fin_per_module_adder_amt'] =
        custentityBbFinPerModuleAdderAmt;
    data['custentity_bb_fin_per_watt_adder_amt'] =
        custentityBbFinPerWattAdderAmt;
    data['custentity_bb_financing_type'] = custentityBbFinancingType;
    data['custentity_bb_forecast_design_date'] =
        custentityBbForecastDesignDate;
    data['custentity_bb_forecast_inspection_date'] =
        custentityBbForecastInspectionDate;
    data['custentity_bb_forecast_permit_date'] =
        custentityBbForecastPermitDate;
    data['custentity_bb_forecast_pto_date'] = custentityBbForecastPtoDate;
    data['custentity_bb_forecast_site_survey_date'] =
        custentityBbForecastSiteSurveyDate;
    data['custentity_bb_forecasted_install_date'] =
        custentityBbForecastedInstallDate;
    data['custentity_bb_google_maps_api_key'] =
        custentityBbGoogleMapsApiKey;
    data['custentity_bb_has_400a_service'] = custentityBbHas400aService;
    data['custentity_bb_has_lift_gate'] = custentityBbHasLiftGate;
    data['custentity_bb_home_owner_name_text'] =
        custentityBbHomeOwnerNameText;
    data['custentity_bb_home_owner_primary_email'] =
        custentityBbHomeOwnerPrimaryEmail;
    data['custentity_bb_inspection_amount'] = custentityBbInspectionAmount;
    data['custentity_bb_install_address_1_text'] =
        custentityBbInstallAddress1Text;
    data['custentity_bb_install_address_2_text'] =
        custentityBbInstallAddress2Text;
    data['custentity_bb_install_city_text'] = custentityBbInstallCityText;
    data['custentity_bb_install_state'] = custentityBbInstallState;
    data['custentity_bb_install_zip_code_text'] =
        custentityBbInstallZipCodeText;
    data['custentity_bb_installer_adder_total_amt'] =
        custentityBbInstallerAdderTotalAmt;
    data['custentity_bb_installer_fxd_addr_ttl_amt'] =
        custentityBbInstallerFxdAddrTtlAmt;
    data['custentity_bb_installr_p_ft_addr_ttl_amt'] =
        custentityBbInstallrPFtAddrTtlAmt;
    data['custentity_bb_instllr_pr_md_addr_ttl_amt'] =
        custentityBbInstllrPrMdAddrTtlAmt;
    data['custentity_bb_instllr_pr_wt_addr_ttl_amt'] =
        custentityBbInstllrPrWtAddrTtlAmt;
    data['custentity_bb_is_bird_netting'] = custentityBbIsBirdNetting;
    data['custentity_bb_is_occupied'] = custentityBbIsOccupied;
    data['custentity_bb_is_project_template'] =
        custentityBbIsProjectTemplate;
    data['custentity_bb_is_residential_delivery'] =
        custentityBbIsResidentialDelivery;
    data['custentity_bb_is_vendor_owned_inverter'] =
        custentityBbIsVendorOwnedInverter;
    data['custentity_bb_lead_start_date'] = custentityBbLeadStartDate;
    data['custentity_bb_ob_project_uuid'] = custentityBbObProjectUuid;
    data['custentity_bb_orgntr_addr_ttl_amt'] =
        custentityBbOrgntrAddrTtlAmt;
    data['custentity_bb_orgntr_addr_ttl_p_watt_amt'] =
        custentityBbOrgntrAddrTtlPWattAmt;
    data['custentity_bb_orgntr_fxd_addr_ttl_amt'] =
        custentityBbOrgntrFxdAddrTtlAmt;
    data['custentity_bb_orgntr_pay_tot_p_w_amt'] =
        custentityBbOrgntrPayTotPWAmt;
    data['custentity_bb_orgntr_per_ft_addr_ttl_amt'] =
        custentityBbOrgntrPerFtAddrTtlAmt;
    data['custentity_bb_orgntr_per_mod_adder_amt'] =
        custentityBbOrgntrPerModAdderAmt;
    data['custentity_bb_orgntr_per_watt_adder_amt'] =
        custentityBbOrgntrPerWattAdderAmt;
    data['custentity_bb_orig_override_boolean'] =
        custentityBbOrigOverrideBoolean;
    data['custentity_bb_orig_payments_on_hold_bool'] =
        custentityBbOrigPaymentsOnHoldBool;
    data['custentity_bb_prefers_design_amt_as_addr'] =
        custentityBbPrefersDesignAmtAsAddr;
    data['custentity_bb_prefers_site_audit_as_addr'] =
        custentityBbPrefersSiteAuditAsAddr;
    data['custentity_bb_project_acctg_method'] =
        custentityBbProjectAcctgMethod;
    data['custentity_bb_project_stage_text'] =
        custentityBbProjectStageText;
    data['custentity_bb_project_start_date'] =
        custentityBbProjectStartDate;
    data['custentity_bb_require_call_ahead'] =
        custentityBbRequireCallAhead;
    data['custentity_bb_requires_hoa_application'] =
        custentityBbRequiresHoaApplication;
    data['custentity_bb_sales_cost_p_watt_amount'] =
        custentityBbSalesCostPWattAmount;
    data['custentity_bb_ss_already_invoiced_amount'] =
        custentityBbSsAlreadyInvoicedAmount;
    data['custentity_bb_ss_inst_already_billed_amt'] =
        custentityBbSsInstAlreadyBilledAmt;
    data['custentity_bb_total_dealer_fee_amount'] =
        custentityBbTotalDealerFeeAmount;
    data['custentity_bb_total_project_ar_amount'] =
        custentityBbTotalProjectArAmount;
    data['custentity_bb_warranty_reserve_amount'] =
        custentityBbWarrantyReserveAmount;
    data['custentity_bbss_configuration'] = custentityBbssConfiguration;
    data['custentity_enable_eng_prog_lookup'] =
        custentityEnableEngProgLookup;
    data['custentity_f4n_sync_all'] = custentityF4nSyncAll;
    data['customer'] = customer;
    data['datecreated'] = datecreated;
    data['entityid'] = entityid;
    data['entitynumber'] = entitynumber;
    data['entitytitle'] = entitytitle;
    data['estimatedgrossprofit'] = estimatedgrossprofit;
    data['estimatedlaborcost'] = estimatedlaborcost;
    data['estimatedlaborrevenue'] = estimatedlaborrevenue;
    data['estimatedtime'] = estimatedtime;
    data['estimatedtimeoverride'] = estimatedtimeoverride;
    data['fxrate'] = fxrate;
    data['id'] = id;
    data['includecrmtasksintotals'] = includecrmtasksintotals;
    data['isexempttime'] = isexempttime;
    data['isinactive'] = isinactive;
    data['isproductivetime'] = isproductivetime;
    data['isutilizedtime'] = isutilizedtime;
    data['jobtype'] = jobtype;
    data['lastmodifieddate'] = lastmodifieddate;
    data['limittimetoassignees'] = limittimetoassignees;
    data['materializetime'] = materializetime;
    data['parent'] = parent;
    data['percenttimecomplete'] = percenttimecomplete;
    data['startdate'] = startdate;
    data['timeapproval'] = timeapproval;
    data['timeremaining'] = timeremaining;
    data['usepercentcompleteoverride'] = usepercentcompleteoverride;
    data['companyname'] = companyname;
    data['custentity_bb_bom_status_list'] = custentityBbBomStatusList;
    data['custentity_bb_fin_m0_invoice_percent'] =
        custentityBbFinM0InvoicePercent;
    data['custentity_bb_fin_m1_invoice_percent'] =
        custentityBbFinM1InvoicePercent;
    data['custentity_bb_fin_m2_invoice_percent'] =
        custentityBbFinM2InvoicePercent;
    data['custentity_bb_fin_m3_invoice_percent'] =
        custentityBbFinM3InvoicePercent;
    data['custentity_bb_fin_m4_invoice_amount'] =
        custentityBbFinM4InvoiceAmount;
    data['custentity_bb_fin_m5_invoice_amount'] =
        custentityBbFinM5InvoiceAmount;
    data['custentity_bb_fin_m6_invoice_amount'] =
        custentityBbFinM6InvoiceAmount;
    data['custentity_bb_fin_m7_invoice_amount'] =
        custentityBbFinM7InvoiceAmount;
    data['custentity_bb_fin_prelim_purch_price_amt'] =
        custentityBbFinPrelimPurchPriceAmt;
    data['custentity_bb_fin_pur_price_p_watt_amt'] =
        custentityBbFinPurPricePWattAmt;
    data['custentity_bb_fin_rebate_inv_amount'] =
        custentityBbFinRebateInvAmount;
    data['custentity_bb_fin_total_fees_amount'] =
        custentityBbFinTotalFeesAmount;
    data['custentity_bb_fin_total_invoice_amount'] =
        custentityBbFinTotalInvoiceAmount;
    data['custentity_bb_financier_adv_pmt_schedule'] =
        custentityBbFinancierAdvPmtSchedule;
    data['custentity_bb_financier_customer'] =
        custentityBbFinancierCustomer;
    data['custentity_bb_financier_payment_schedule'] =
        custentityBbFinancierPaymentSchedule;
    data['custentity_bb_gross_adder_total'] = custentityBbGrossAdderTotal;
    data['custentity_bb_gross_profit_amount'] =
        custentityBbGrossProfitAmount;
    data['custentity_bb_gross_profit_percent'] =
        custentityBbGrossProfitPercent;
    data['custentity_bb_homeowner_customer'] =
        custentityBbHomeownerCustomer;
    data['custentity_bb_install_comp_pack_last_dt'] =
        custentityBbInstallCompPackLastDt;
    data['custentity_bb_install_comp_pack_start_dt'] =
        custentityBbInstallCompPackStartDt;
    data['custentity_bb_install_comp_pack_stat_txt'] =
        custentityBbInstallCompPackStatTxt;
    data['custentity_bb_install_payout_total'] =
        custentityBbInstallPayoutTotal;
    data['custentity_bb_inventory_amount'] = custentityBbInventoryAmount;
    data['custentity_bb_m0_dealer_fee_amount'] =
        custentityBbM0DealerFeeAmount;
    data['custentity_bb_m1_dealer_fee_amount'] =
        custentityBbM1DealerFeeAmount;
    data['custentity_bb_m2_dealer_fee_amount'] =
        custentityBbM2DealerFeeAmount;
    data['custentity_bb_m3_dealer_fee_amount'] =
        custentityBbM3DealerFeeAmount;
    data['custentity_bb_m3_finance_action'] = custentityBbM3FinanceAction;
    data['custentity_bb_m4_dealer_fee_amount'] =
        custentityBbM4DealerFeeAmount;
    data['custentity_bb_m5_dealer_fee_amount'] =
        custentityBbM5DealerFeeAmount;
    data['custentity_bb_m6_dealer_fee_amount'] =
        custentityBbM6DealerFeeAmount;
    data['custentity_bb_m7_dealer_fee_amount'] =
        custentityBbM7DealerFeeAmount;
    data['custentity_bb_net_price_per_watt'] = custentityBbNetPricePerWatt;
    data['custentity_bb_orig_payout_total'] = custentityBbOrigPayoutTotal;
    data['custentity_bb_orig_vend_bill_total'] =
        custentityBbOrigVendBillTotal;
    data['custentity_bb_orig_vend_credit_total'] =
        custentityBbOrigVendCreditTotal;
    data['custentity_bb_project_so'] = custentityBbProjectSo;
    data['custentity_bb_project_sub_stage_text'] =
        custentityBbProjectSubStageText;
    data['custentity_bb_rebate_variance_amount'] =
        custentityBbRebateVarianceAmount;
    data['custentity_bb_revenue_per_watt_amount'] =
        custentityBbRevenuePerWattAmount;
    data['custentity_bb_sales_tax_amount'] = custentityBbSalesTaxAmount;
    data['custentity_bb_solar_portion_contract_amt'] =
        custentityBbSolarPortionContractAmt;
    data['custentity_bb_started_from_proj_template'] =
        custentityBbStartedFromProjTemplate;
    data['custentity_bb_subinstl_vend_bill_total'] =
        custentityBbSubinstlVendBillTotal;
    data['custentity_bb_subinstl_vend_credit_total'] =
        custentityBbSubinstlVendCreditTotal;
    data['custentity_bb_system_size_decimal'] =
        custentityBbSystemSizeDecimal;
    data['custentity_bb_tot_con_value_per_watt_amt'] =
        custentityBbTotConValuePerWattAmt;
    data['custentity_bb_total_contract_value_amt'] =
        custentityBbTotalContractValueAmt;
    data['custentity_bb_uat_data_boolean'] = custentityBbUatDataBoolean;
    return data;
  }

  @override
  Project decode(json) {
    return Project.fromJson(json);
  }
}

