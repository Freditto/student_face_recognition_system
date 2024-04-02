import 'dart:typed_data'; // For Uint8List

class Student {
  int? id;
  String? regNumber; // Registration number
  String? first_name;
  String? last_name;
  String? gender;
  String? program;
  String? studentClass;
  String? ntaLevel;
  Uint8List? picture; // Student picture as byte array
  bool? isEligible;

  Student({
    this.id,
    this.regNumber,
    this.first_name,
    this.last_name,
    this.gender,
    this.program,
    this.studentClass,
    this.ntaLevel,
    this.picture,
    this.isEligible,
  });

  // Convert a Student object into a Map.
Map<String, dynamic> toMap() {
  var map = <String, dynamic>{
    'regNumber': regNumber,
    'first_name': first_name,
    'last_name': last_name,
    'gender': gender,
    'program': program,
    'class': studentClass,
    'ntaLevel': ntaLevel,
    'isEligible': isEligible != null ? (isEligible! ? 1 : 0) : null,
  };
  if (id != null) {
    map['id'] = id!;
  }
  if (picture != null) {
    map['picture'] = picture!;
  }
  return map;
}

  // Create a Student object from a Map object.
  Student.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    regNumber = map['regNumber'];
    first_name = map['first_name'];
    last_name = map['last_name'];
    gender = map['gender'];
    program = map['program'];
    studentClass = map['class'];
    ntaLevel = map['ntaLevel'];
    picture = map['picture'];
    isEligible = map['isEligible'] == 1;
  }
}
