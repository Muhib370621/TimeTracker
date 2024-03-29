import 'package:easy_localization/easy_localization.dart';
enum AppStrings {
  timeCardClockedIn,
  timeCardProjectName,
  startTime,
  finishTime,
  location,
  detail,
  site,
  notes,
  details,
  action,
  checklist,
  assignedBy,
  addNote,
  noteSample,
  writeNote,
  addImages,
  searchProject,
  total,
  complete,
  remaining,
  perDayTime,
  all,
  approved,
  notApproved,
  clockedOut,
  workTime,
  breakTime,
  endTime,
  startDateTime,
  completed,
  breakString,
  firstName,
  lastName,
  emailAddress,
  mobileNumber,
  saveChanges,
  aboutUs,
  getHelp,
  logOut,
  enterEmailAddress,
  enterMobileNumber;

  String tr() {
    AppStrings.firstName.name;
    return toString().split('.').last.tr();
  }
}

