enum TimeCardStatus {
  all,
  approved,
  notApproved,
  clockedIn,
  clockedOut;

  String get title {
    switch(this){
      case TimeCardStatus.all:
        return "All";
      case TimeCardStatus.approved:
        return "Approved";
      case TimeCardStatus.notApproved:
        return "Not Approved";
      case TimeCardStatus.clockedIn:
        return "Clocked In";
      case TimeCardStatus.clockedOut:
        return "Clocked Out";
    }

  }

}
