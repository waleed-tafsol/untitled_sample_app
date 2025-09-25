class DriverShiftModel {
  final String? selectedDriverType;
  final List<String>? selectedWorkingDays;
  final Map<String, int>? preferredStartTime;
  final int? selectedHours;
  final Map<String, bool?>? declarations;

  DriverShiftModel({
    this.selectedDriverType,
    this.selectedWorkingDays,
    this.preferredStartTime,
    this.selectedHours,
    this.declarations,
  });

  static DriverShiftModel fromJson(Map<String, dynamic> json) {
    return DriverShiftModel(
      selectedDriverType: json['selectedDriverType'] as String?,
      selectedWorkingDays: json['selectedWorkingDays'] != null 
          ? List<String>.from(json['selectedWorkingDays']) 
          : null,
      preferredStartTime: json['preferredStartTime'] != null 
          ? Map<String, int>.from(json['preferredStartTime']) 
          : null,
      selectedHours: json['selectedHours'] as int?,
      declarations: json['declarations'] != null 
          ? Map<String, bool?>.from(json['declarations']) 
          : null,
    );
  }
}
