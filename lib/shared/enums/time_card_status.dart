import 'package:blu_time/constants/app_localized_strings.dart';

enum TimeCardStatus {
  all,
  approved,
  notApproved,
  clockedIn,
  clockedOut;

  String get title {
    switch(this){
      case TimeCardStatus.all:
        return AppLocalizedStrings.all.tr();
      case TimeCardStatus.approved:
        return AppLocalizedStrings.approved.tr();
      case TimeCardStatus.notApproved:
        return AppLocalizedStrings.notApproved.tr();
      case TimeCardStatus.clockedIn:
        return AppLocalizedStrings.timeCardClockedIn.tr();
      case TimeCardStatus.clockedOut:
        return AppLocalizedStrings.clockedOut.tr();
    }

  }

}
