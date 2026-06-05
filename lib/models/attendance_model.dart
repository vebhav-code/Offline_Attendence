class AttendanceModel {
  final int? workerId;

  final DateTime date;

  final String status;

  final String? selfiePath;

  final DateTime markedAt;

  AttendanceModel({
    this.workerId,
    required this.date,
    required this.status,
    this.selfiePath,
    required this.markedAt,
  });
}
