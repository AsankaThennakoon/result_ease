class Student {
  final String name;
  final String indexNo;
  final Map<String, String> courseData; // Field to store course data

  Student({required this.name, required this.indexNo, required this.courseData});

  static fromJson(Map<String, dynamic> data) {
    print(data.toString());

    return Student(
      name: data['name'] ?? '',
      indexNo: data['indexNo'] ?? '',
      courseData: Map<String, String>.from(data['courseData'] ?? {}), // Convert dynamic to Map<String, String>
    );
  }
}
