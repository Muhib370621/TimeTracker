import 'package:blu_time/models/action_checklist.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/models/project_action.dart';
import 'package:blu_time/models/time_entry.dart';
import 'package:blu_time/models/user_profile.dart';

class MockFactory {

  Project project1 = Project(
      altname: "Residential Plumbing and Electrical Upgrade",
      id: "1",
      startdate: "2/15/2022",
      custentityBbForecastedInstallDate: "3/27/2022",
      custentityBbInstallAddress1Text: "123 Main St, Anytown",
      customer: "t1@bb.com",
      custentityBbEntityLatitudeText: "37.788022",
      custentityBbEntityLongitudeText: "-122.399797");

  Project project2 = Project(
      altname: "Commercial Building Renovation",
      id: "2",
      startdate: "4/20/2022",
      custentityBbForecastedInstallDate: "5/15/2022",
      custentityBbInstallAddress1Text: "555 Park Ave, Cityville",
      customer: "t2@bb.com",
      custentityBbEntityLatitudeText: "41.878114",
      custentityBbEntityLongitudeText: "-87.629798");

  Project project3 = Project(
      altname: "HVAC and Plumbing Maintenance and Repair",
      id: "3",
      startdate: "6/25/2022",
      custentityBbForecastedInstallDate: "7/10/2022",
      custentityBbInstallAddress1Text: "999 Elm St, Village",
      customer: "t2@bb.com",
      custentityBbEntityLatitudeText: "40.730610",
      custentityBbEntityLongitudeText: "-73.935242");

  List<UserProfile> mockUsers({String? userId}) {
    UserProfile user1 = UserProfile("t1@bb.com", "testing@1one","Dirk","Liebich","(555) 555-5201");
    UserProfile user2 = UserProfile("t2@bb.com", "testing@1one","David","Williams","(555) 555-5202");
    UserProfile user3 = UserProfile("t3@bb.com", "testing@1one","Robert","Miller","555-5203");
    List<UserProfile> users = [user1, user2,user3];
    if (userId == null) {
      return users;
    }
    return users.where((element) => element.email == userId).toList();
  }

  List<Project> mockProjects({String? userId}) {
    List<Project> projects = [project1, project2, project3];
    if (userId == null) {
      return projects;
    }
    return projects.where((element) => element.customer == userId).toList();
  }

  Project mockProjectById(String projectId) {
    List<Project> projects = [project1, project2, project3];
    return projects.where((element) => element.id == projectId).toList().first;
  }

  List<ProjectAction> mockProjectActions(String? projectId) {
    ProjectAction projectAction1 =
        ProjectAction(custrecordBbBludocsPath: "Replace old plumbing fixtures", created: "2/16/2022", isCompleted: false, assignedBy: "Dirk", id: "1", custrecordBbProject: "1");
    ProjectAction projectAction2 = ProjectAction(
        custrecordBbBludocsPath: "Demolition and removal of existing walls and floors",
        created: "4/21/2022",
        isCompleted: false,
        assignedBy: "Tom",
        id: "2",
        custrecordBbProject: "2");
    ProjectAction projectAction3 =
        ProjectAction(custrecordBbBludocsPath: "Inspect and maintain HVAC system", created: "4/25/2022", isCompleted: false, assignedBy: "John", id: "3", custrecordBbProject: "2");
    ProjectAction projectAction4 =
        ProjectAction(custrecordBbBludocsPath: "Roofing and Siding Replacement", created: "5/25/2022", isCompleted: false, assignedBy: "Emily", id: "4", custrecordBbProject: "3");
    List<ProjectAction> actions = [projectAction1, projectAction2, projectAction3, projectAction4];
    if (projectId == null) {
      return actions;
    }
    return actions.where((element) => element.custrecordBbProject == projectId).toList();
  }

  List<ActionChecklist> mockActionChecklist(String? actionId) {
    ActionChecklist actionChecklist1 = ActionChecklist(
        custrecordBbPachklistTitle: "Replace old plumbing fixtures", lastmodified: "12/21/2022", isCompleted: false, id: "1", custrecordBbPachklistProjectAction: "1");
    ActionChecklist actionChecklist2 = ActionChecklist(
        custrecordBbPachklistTitle: "Upgrade electrical wiring and install new outlets",
        lastmodified: "12/22/2022",
        isCompleted: false,
        id: "2",
        custrecordBbPachklistProjectAction: "1");
    ActionChecklist actionChecklist3 =
        ActionChecklist(custrecordBbPachklistTitle: "Install new light fixtures", lastmodified: "12/23/2022", isCompleted: false, id: "3", custrecordBbPachklistProjectAction: "1");
    ActionChecklist actionChecklist4 = ActionChecklist(
        custrecordBbPachklistTitle: "Install new electrical and plumbing systems",
        lastmodified: "12/24/2022",
        isCompleted: false,
        id: "4",
        custrecordBbPachklistProjectAction: "2");
    ActionChecklist actionChecklist5 =
        ActionChecklist(custrecordBbPachklistTitle: "Install new HVAC system", lastmodified: "12/25/2022", isCompleted: false, id: "5", custrecordBbPachklistProjectAction: "2");
    ActionChecklist actionChecklist6 = ActionChecklist(
        custrecordBbPachklistTitle: "Inspect and maintain plumbing system", lastmodified: "12/22/2022", isCompleted: false, id: "6", custrecordBbPachklistProjectAction: "3");
    ActionChecklist actionChecklist7 = ActionChecklist(
        custrecordBbPachklistTitle: "Replace any damaged or worn parts", lastmodified: "12/23/2022", isCompleted: false, id: "37", custrecordBbPachklistProjectAction: "3");
    ActionChecklist actionChecklist8 = ActionChecklist(
        custrecordBbPachklistTitle: "Remove old roofing and siding", lastmodified: "12/24/2022", isCompleted: false, id: "8", custrecordBbPachklistProjectAction: "4");
    ActionChecklist actionChecklist9 = ActionChecklist(
        custrecordBbPachklistTitle: "Install new roofing and siding", lastmodified: "12/25/2022", isCompleted: false, id: "9", custrecordBbPachklistProjectAction: "4");
    List<ActionChecklist> checkList = [
      actionChecklist1,
      actionChecklist2,
      actionChecklist3,
      actionChecklist4,
      actionChecklist5,
      actionChecklist6,
      actionChecklist7,
      actionChecklist8,
      actionChecklist9
    ];
    if (actionId == null) {
      return checkList;
    }
    return checkList.where((element) => element.custrecordBbPachklistProjectAction == actionId).toList();
  }

  List<TimeEntry> mockTimeEntry({String? userId}) {
    List<TimeEntry> timeEntries = [
      TimeEntry(
          trandate: "2/17/2022",
          displayfield: "Residential Plumbing and Electrical Upgrade",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Approved",
          hours: "2.50",
          employee: "t1@bb.com",
          csegBbProject:"1"),
      TimeEntry(
          trandate: "2/22/2022",
          displayfield: "Residential Plumbing and Electrical Upgrade",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Approved",
          hours: "3.5",
          employee: "t1@bb.com",
          csegBbProject:"1"),
      TimeEntry(
          trandate: "2/25/2022",
          displayfield: "Commercial Building Renovation",
          actionsCount: 2,
          completeCount: 1,
          remainingCount: 1,
          type: "Clocked In",
          hours: "8.0",
          employee: "t2@bb.com",
          csegBbProject:"2"),
      TimeEntry(
          trandate: "3/5/2022",
          displayfield: "Commercial Building Renovation",
          actionsCount: 2,
          completeCount: 1,
          remainingCount: 1,
          type: "Clocked In",
          hours: "8.0",
          employee: "t2@bb.com",
          csegBbProject:"2"),
      TimeEntry(
          trandate: "4/2/2022",
          displayfield: "HVAC and Plumbing Maintenance and Repair",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Clocked Out",
          hours: "1.2",
          employee: "t2@bb.com",
          csegBbProject:"3"),
      TimeEntry(
          trandate: "4/20/2022",
          displayfield: "HVAC and Plumbing Maintenance and Repair",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Clocked Out",
          hours: "6.2",
          employee: "t2@bb.com",
          csegBbProject:"3"),
      TimeEntry(
          trandate: "5/15/2022",
          displayfield: "HVAC and Plumbing Maintenance and Repair",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Clocked Out",
          hours: "7.9",
          employee: "t2@bb.com",
          csegBbProject:"3"),
      TimeEntry(
          trandate: "6/10/2022",
          displayfield: "HVAC and Plumbing Maintenance and Repair",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Not Approved",
          hours: "8.0",
          employee: "t2@bb.com",
          csegBbProject:"3"),
    ];
    if (userId == null) {
      return timeEntries;
    }
    return timeEntries.where((element) => element.employee == userId).toList();
  }

  List<Notes> mockProjectNotes(String projectId) {
   Notes notes1 = Notes(note: "Initial assessment of the property has been completed, and a plan for the upgrade has been developed.",noteId: "1",projectId: "1");
   Notes notes2 = Notes(note: "Demolition of existing fixtures and wiring has begun, and new plumbing and electrical components have been ordered.",noteId: "2",projectId: "1");
   Notes notes3 = Notes(note: "Demolition and removal of existing walls and floors is complete",noteId: "3",projectId: "2");
   Notes notes4 = Notes(note: "New electrical and plumbing systems have been installed and carpentry work is underway",noteId: "4",projectId: "2");
   Notes notes5 = Notes(note: "HVAC system has been inspected and maintained",noteId: "5",projectId: "3");
   Notes notes6 = Notes(note: "Plumbing system has been inspected and maintained and any damaged parts have been replaced",noteId: "6",projectId: "3");
    List<Notes> actions = [notes1, notes2, notes3, notes4, notes5, notes6];
    return actions.where((element) => element.projectId == projectId).toList();
  }

}
