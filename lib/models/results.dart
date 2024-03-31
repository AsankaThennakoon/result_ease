class Results {
  final String name;
  final String indexNo;
  final Map<String, String> courseData; // Field to store course data
  final String batch;
  final String semester;
  final String year;
  final String userId;

  Results({
    required this.name,
    required this.indexNo,
    required this.courseData,
    required this.batch,
    required this.semester,
    required this.year,
    required this.userId,
  });

  static fromJson(Map<String, dynamic> data) {
    print(data.toString());

    return Results(
      name: data['name'] ?? '',
      indexNo: data['indexNo'] ?? '',
      courseData: Map<String, String>.from(data['courseData'] ?? {}),
      batch: data['batch'] ?? '',
      semester: data['semester'] ?? '',
      year: data['year'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
}
