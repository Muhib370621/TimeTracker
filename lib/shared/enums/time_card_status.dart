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
        return AppStrings.all.tr();
      case TimeCardStatus.approved:
        return AppStrings.approved.tr();
      case TimeCardStatus.notApproved:
        return AppStrings.notApproved.tr();
      case TimeCardStatus.clockedIn:
        return AppStrings.timeCardClockedIn.tr();
      case TimeCardStatus.clockedOut:
        return AppStrings.clockedOut.tr();
    }

  }

}
