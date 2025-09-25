class DriverShiftRequest {
  final String? selectedDriverType;
  final List<String>? selectedWorkingDays;
  final Map<String, int>? preferredStartTime;
  final int? selectedHours;
  final Map<String, bool?>? declarations;

  DriverShiftRequest({
    this.selectedDriverType,
    this.selectedWorkingDays,
    this.preferredStartTime,
    this.selectedHours,
    this.declarations,
  });

  // Convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'selectedDriverType': selectedDriverType,
      'selectedWorkingDays': selectedWorkingDays,
      'preferredStartTime': preferredStartTime,
      'selectedHours': selectedHours,
      'declarations': declarations,
    };
  }
}
