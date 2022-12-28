import 'package:blu_time/constants/app_strings.dart';

enum TimeCardStatus {
  all,
  approved,
  notApproved,
  clockedIn,
  clockedOut;

  String get title {
    switch(this){
      case TimeCardStatus.all:
        return AppStrings.all;
      case TimeCardStatus.approved:
        return AppStrings.approved;
      case TimeCardStatus.notApproved:
        return AppStrings.notApproved;
      case TimeCardStatus.clockedIn:
        return AppStrings.timeCardClockedIn;
      case TimeCardStatus.clockedOut:
        return AppStrings.clockedOut;
    }

  }

}
