class ExerciseModel {
  String name;
  double met;
  final String tag;

  ExerciseModel({
    this.name = '',
    this.met = 0,
    required this.tag,
  });

  static ExerciseModel fromJson(Map<String, dynamic> json) =>
      ExerciseModel(name: json['name'], met: json['mets'], tag: json['tag']);
}
