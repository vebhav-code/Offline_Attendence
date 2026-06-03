class WorkerModel {
  final String workerId;
  final String name;
  final String phone;
  final String department;
  final String site;
  final String imagePath;

  WorkerModel({
    required this.workerId,
    required this.name,
    required this.phone,
    required this.department,
    required this.site,
    required this.imagePath,
  });

  factory WorkerModel.fromMap(
    Map<String, String> map,
  ) {
    return WorkerModel(
      workerId:
          map["workerId"] ??
          "EMP-8829-24",
      name:
          map["name"] ??
          "Ayush Gupta",
      phone:
          map["phone"] ??
          "+91 9876543210",
      department:
          map["department"] ??
          "Construction",
      site:
          map["site"] ??
          "Site A",
      imagePath:
          map["imagePath"] ?? "",
    );
  }
}
