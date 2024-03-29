class Student{

  final String name;
  final String indexNo;

  Student({required this.name,required this.indexNo});

  static fromJson(Map<String, dynamic> data) { return Student(
      name: data['name'] ?? '',
      indexNo: data['indexNo'] ?? '',
    );}
}