class StudentModel1 {
  const StudentModel1({ this.age = 18 });
  final int age;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModel1 &&
          runtimeType == other.runtimeType &&
          age == other.age;

  @override
  int get hashCode => age.hashCode;
}
