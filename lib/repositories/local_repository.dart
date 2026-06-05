import '../models/attendance_model.dart';
import '../models/worker_model.dart';

class LocalRepository {
  static final List<WorkerModel> workers = [
    WorkerModel(
      id: 1,
      name: "Rahul Kumar",
      employeeId: "EMP-1001",
      phone: "9876543210",
      age: 28,
      department: "Construction",
      photos: [],
    ),
    WorkerModel(
      id: 2,
      name: "Amit Singh",
      employeeId: "EMP-1002",
      phone: "9876543211",
      age: 30,
      department: "Electrical",
      photos: [],
    ),
  ];

  static final List<AttendanceModel> attendance = [];
}
