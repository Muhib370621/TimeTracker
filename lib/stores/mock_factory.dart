import 'package:blu_time/models/action_checklist.dart';
import 'package:blu_time/models/project.dart';
import 'package:blu_time/models/project_action.dart';
import 'package:blu_time/models/time_entry.dart';
import 'package:blu_time/models/user_profile.dart';

class MockFactory {
  Project project1 = Project(
      title: "Residential Plumbing and Electrical Upgrade",
      id: "1",
      startTime: "2/15/2022 1:00:00 PM",
      endTime: "3/27/2022 2:00:00 PM",
      address1: "123 Main St, Anytown",
      customer: "t3@bb.com",
      latitude: "37.788022",
      longitude: "-122.399797",
       bluchatId: "1045089");

  Project project2 = Project(
      title: "Commercial Building Renovation",
      id: "2",
      startTime: "4/20/2022 3:00:00 PM",
      endTime: "5/15/2022 4:00:00 PM",
      address1: "555 Park Ave, Cityville",
      customer: "t2@bb.com",
      latitude: "41.878114",
      longitude: "-87.629798",
      bluchatId: "1045089");

  Project project3 = Project(
      title: "HVAC and Plumbing Maintenance and Repair",
      id: "3",
      startTime: "6/25/2022 5:00:00 PM",
      endTime: "7/10/2022 6:00:00 PM",
      address1: "999 Elm St, Village",
      customer: "t2@bb.com",
      latitude: "40.730610",
      longitude: "-73.935242",
      bluchatId: "1045089");

  List<UserProfile> mockUsers({String? userId}) {
    UserProfile user1 = UserProfile(email: "t1@bb.com", password: "testing@1one", firstName: "Dirk", lastName: "Liebich", mobile: "(555) 555-5201", id: "t1@bb.com");
    UserProfile user2 = UserProfile(email: "t2@bb.com", password: "testing@1one", firstName: "David", lastName: "Williams", mobile: "(555) 555-5202", id: "t2@bb.com");
    UserProfile user3 = UserProfile(email: "t3@bb.com", password: "testing@1one", firstName: "Robert", lastName: "Miller", mobile: "555-5203", id: "t3@bb.com");
    List<UserProfile> users = [user1, user2, user3];
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
        ProjectAction(title: "Replace old plumbing fixtures", assignedTime: "2/16/2022 1:00:00 PM", completed: false, assignedBy: "Dirk", id: "1", custrecordBbProject: "1");
    ProjectAction projectAction2 = ProjectAction(
        title: "Demolition and removal of existing walls and floors", assignedTime: "4/21/2022 2:00:00 PM", completed: false, assignedBy: "Tom", id: "2", custrecordBbProject: "2");
    ProjectAction projectAction3 =
        ProjectAction(title: "Inspect and maintain HVAC system", assignedTime: "4/25/2022 3:00:00 PM", completed: false, assignedBy: "John", id: "3", custrecordBbProject: "2");
    ProjectAction projectAction4 =
        ProjectAction(title: "Roofing and Siding Replacement", assignedTime: "5/25/2022 4:00:00 PM", completed: false, assignedBy: "Emily", id: "4", custrecordBbProject: "3");
    List<ProjectAction> actions = [projectAction1, projectAction2, projectAction3, projectAction4];
    if (projectId == null) {
      return actions;
    }
    return actions.where((element) => element.custrecordBbProject == projectId).toList();
  }

  List<ActionChecklist> mockActionChecklist(String? actionId) {
    ActionChecklist actionChecklist1 =
        ActionChecklist(title: "Replace old plumbing fixtures", completedDate: "12/21/2022", completed: false, custrecordBbPachklistProjectAction: "1");
    ActionChecklist actionChecklist2 =
        ActionChecklist(title: "Upgrade electrical wiring and install new outlets", completedDate: "12/22/2022", completed: false, custrecordBbPachklistProjectAction: "1");
    ActionChecklist actionChecklist3 = ActionChecklist(title: "Install new light fixtures", completedDate: "12/23/2022", completed: false, custrecordBbPachklistProjectAction: "1");
    ActionChecklist actionChecklist4 =
        ActionChecklist(title: "Install new electrical and plumbing systems", completedDate: "12/24/2022", completed: false, custrecordBbPachklistProjectAction: "2");
    ActionChecklist actionChecklist5 = ActionChecklist(title: "Install new HVAC system", completedDate: "12/25/2022", completed: false, custrecordBbPachklistProjectAction: "2");
    ActionChecklist actionChecklist6 =
        ActionChecklist(title: "Inspect and maintain plumbing system", completedDate: "12/22/2022", completed: false, custrecordBbPachklistProjectAction: "3");
    ActionChecklist actionChecklist7 =
        ActionChecklist(title: "Replace any damaged or worn parts", completedDate: "12/23/2022", completed: false, custrecordBbPachklistProjectAction: "3");
    ActionChecklist actionChecklist8 =
        ActionChecklist(title: "Remove old roofing and siding", completedDate: "12/24/2022", completed: false, custrecordBbPachklistProjectAction: "4");
    ActionChecklist actionChecklist9 =
        ActionChecklist(title: "Install new roofing and siding", completedDate: "12/25/2022", completed: false, custrecordBbPachklistProjectAction: "4");
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
          trandate: "10/17/2022",
          displayfield: "Residential Plumbing and Electrical Upgrade",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Approved",
          hours: "7.5",
          employee: "t1@bb.com",
          csegBbProject: "1",
          startTime: "10/17/2022 9:00:00 AM",
          endTime: "10/17/2022 6:30:00 PM",
          location:"123 Main St, Anytown",
          breaks: [
            Break("startDate", "12:00 PM", "endDate", "1:00 PM"),
            Break("startDate", "4:00 PM", "endDate", "5:00 PM"),
          ]),
      TimeEntry(
        trandate: "10/16/2022",
        displayfield: "Residential Plumbing and Electrical Upgrade",
        actionsCount: 1,
        completeCount: 0,
        remainingCount: 1,
        type: "Approved",
        hours: "8.0",
        employee: "t1@bb.com",
        csegBbProject: "1",
        startTime: "10/16/2022 9:00:00 AM",
        endTime: "10/16/2022 7:00:00 PM",
        location:"123 Main St, Anytown",
          breaks: [
            Break("startDate", "12:00 PM", "endDate", "1:00 PM"),
            Break("startDate", "4:00 PM", "endDate", "5:00 PM"),
          ]
      ),
      TimeEntry(
          trandate: "10/15/2022",
          displayfield: "Commercial Building Renovation",
          actionsCount: 2,
          completeCount: 1,
          remainingCount: 1,
          type: "Clocked In",
          hours: "8.0",
          employee: "t2@bb.com",
          csegBbProject: "2",
          startTime: "10/15/2022 9:00:00 AM",
          endTime: "10/15/2022 7:00:00 PM",
          location:"555 Park Ave, Cityville",
          breaks: [
            Break("startDate", "12:00 PM", "endDate", "1:00 PM"),
            Break("startDate", "4:00 PM", "endDate", "5:00 PM"),
          ]),
      TimeEntry(
          trandate: "10/14/2022",
          displayfield: "Commercial Building Renovation",
          actionsCount: 2,
          completeCount: 1,
          remainingCount: 1,
          type: "Clocked In",
          hours: "6.5",
          employee: "t2@bb.com",
          csegBbProject: "2",
          startTime: "10/14/2022 9:00:00 AM",
          endTime: "10/14/2022 4:30:00 PM",
          location:"555 Park Ave, Cityville",
          breaks: [
            Break("startDate", "12:00 PM", "endDate", "1:00 PM"),
          ]),
      TimeEntry(
          trandate: "10/13/2022",
          displayfield: "HVAC and Plumbing Maintenance and Repair",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Clocked Out",
          hours: "4.0",
          employee: "t2@bb.com",
          csegBbProject: "3",
          startTime: "10/13/2022 9:00:00 AM",
          endTime: "10/13/2022 1:00:00 PM",
          location:"999 Elm St, Village",
          ),
      TimeEntry(
          trandate: "8/20/2022",
          displayfield: "HVAC and Plumbing Maintenance and Repair",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Clocked Out",
          hours: "8",
          employee: "t2@bb.com",
          csegBbProject: "3",
          startTime: "8/20/2022 9:00:00 AM",
          endTime: "8/20/2022 7:00:00 PM",
          location:"999 Elm St, Village",
          breaks: [
            Break("startDate", "12:00 PM", "endDate", "1:00 PM"),
            Break("startDate", "4:00 PM", "endDate", "5:00 PM"),
          ]),
      TimeEntry(
          trandate: "7/20/2022",
          displayfield: "HVAC and Plumbing Maintenance and Repair",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Clocked Out",
          hours: "10.5",
          employee: "t2@bb.com",
          csegBbProject: "3",
          startTime: "7/20/2022 9:00:00 AM",
          endTime: "7/20/2022 9:30:00 PM",
          location:"",
          breaks: [
            Break("startDate", "12:00 PM", "endDate", "1:00 PM"),
            Break("startDate", "4:00 PM", "endDate", "5:00 PM"),
          ]),
      TimeEntry(
          trandate: "6/20/2022",
          displayfield: "HVAC and Plumbing Maintenance and Repair",
          actionsCount: 1,
          completeCount: 0,
          remainingCount: 1,
          type: "Not Approved",
          hours: "8.0",
          employee: "t2@bb.com",
          csegBbProject: "3",
          startTime: "6/20/2022 9:00:00 AM",
          endTime: "6/20/2022 5:00:00 PM",
          location:"",
          breaks: [
            Break("startDate", "12:00 PM", "endDate", "1:00 PM"),
            Break("startDate", "4:00 PM", "endDate", "5:00 PM"),
          ]),
    ];
    if (userId == null) {
      return timeEntries;
    }
    return timeEntries.where((element) => element.employee == userId).toList();
  }

  List<Notes> mockProjectNotes(String projectId) {
    Notes notes1 = Notes(note: "Initial assessment of the property has been completed, and a plan for the upgrade has been developed.", noteId: "1", projectId: "1");
    Notes notes2 = Notes(note: "Demolition of existing fixtures and wiring has begun, and new plumbing and electrical components have been ordered.", noteId: "2", projectId: "1");
    Notes notes3 = Notes(note: "Demolition and removal of existing walls and floors is complete", noteId: "3", projectId: "2");
    Notes notes4 = Notes(note: "New electrical and plumbing systems have been installed and carpentry work is underway", noteId: "4", projectId: "2");
    Notes notes5 = Notes(note: "HVAC system has been inspected and maintained", noteId: "5", projectId: "3");
    Notes notes6 = Notes(note: "Plumbing system has been inspected and maintained and any damaged parts have been replaced", noteId: "6", projectId: "3");
    List<Notes> actions = [notes1, notes2, notes3, notes4, notes5, notes6];
    return actions.where((element) => element.projectId == projectId).toList();
  }
}
