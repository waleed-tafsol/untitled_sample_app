import 'package:flutter/material.dart';

class DriverShiftViewModel extends ChangeNotifier {
  // Driver type state management
  String _selectedDriverType = 'fullTime'; // 'fullTime' or 'partTime'

  // Working days and hours state management
  final Set<String> _selectedWorkingDays = {};
  TimeOfDay _preferredStartTime = TimeOfDay(hour: 9, minute: 0);
  int _selectedHours = 8;

  // Declarations state management
  final Map<String, bool?> _declarations = {
    'qualifiedToOperate': null,
    'consentToAgreement': null,
    'consentToInformationStatement': null,
  };

  // Form key management
  GlobalKey<FormState>? _formKey;

  // Driver type getters and setters
  String get getSelectedDriverType => _selectedDriverType;
  bool get isFullTimeDriver => _selectedDriverType == 'fullTime';
  bool get isPartTimeDriver => _selectedDriverType == 'partTime';

  void setDriverType(String driverType) {
    _selectedDriverType = driverType;
    // Reset selections when changing driver type
    _selectedWorkingDays.clear();
    _selectedHours = driverType == 'fullTime' ? 8 : 6;
    notifyListeners();
  }

  // Working days getters and setters
  Set<String> get getSelectedWorkingDays => Set.from(_selectedWorkingDays);
  bool isWorkingDaySelected(String day) => _selectedWorkingDays.contains(day);
  int get getSelectedWorkingDaysCount => _selectedWorkingDays.length;

  bool get isValidWorkingDaysSelection {
    if (isFullTimeDriver) {
      return _selectedWorkingDays.length >= 4;
    } else {
      return _selectedWorkingDays.length <= 3 && _selectedWorkingDays.length > 0;
    }
  }

  void toggleWorkingDay(String day) {
    // Convert full day names to short forms for consistency
    final dayMap = {
      'Monday': 'Mon',
      'Tuesday': 'Tue',
      'Wednesday': 'Wed',
      'Thursday': 'Thu',
      'Friday': 'Fri',
      'Saturday': 'Sat',
      'Sunday': 'Sun',
    };

    final shortDay = dayMap[day] ?? day;

    if (_selectedWorkingDays.contains(shortDay)) {
      _selectedWorkingDays.remove(shortDay);
    } else {
      if (isFullTimeDriver) {
        // No limit for full-time
        _selectedWorkingDays.add(shortDay);
      } else {
        // Max 3 days for part-time
        if (_selectedWorkingDays.length < 3) {
          _selectedWorkingDays.add(shortDay);
        }
      }
    }
    notifyListeners();
  }

  // Working hours getters and setters
  TimeOfDay get getPreferredStartTime => _preferredStartTime;
  int get getSelectedHours => _selectedHours;
  int get getMaxHours => isFullTimeDriver ? 12 : 8;
  int get getMinHours => isFullTimeDriver ? 6 : 4;

  void setPreferredStartTime(TimeOfDay time) {
    _preferredStartTime = time;
    notifyListeners();
  }

  void setSelectedHours(int hours) {
    if (hours >= getMinHours && hours <= getMaxHours) {
      _selectedHours = hours;
      notifyListeners();
    }
  }

  // Declaration getters and setters
  bool? getDeclaration(String declarationKey) => _declarations[declarationKey];
  bool get isQualifiedToOperate => _declarations['qualifiedToOperate'] ?? false;
  bool get hasConsentedToAgreement => _declarations['consentToAgreement'] ?? false;
  bool get hasConsentedToInformationStatement => _declarations['consentToInformationStatement'] ?? false;

  bool get areAllDeclarationsAccepted {
    return _declarations.values.every((value) => value == true);
  }

  void setDeclaration(String declarationKey, bool value) {
    _declarations[declarationKey] = value;
    notifyListeners();
  }

  void clearAllDeclarations() {
    _declarations.updateAll((key, value) => null);
    notifyListeners();
  }

  // Form key management
  GlobalKey<FormState> getFormKeyForStep(int step) {
    if (_formKey == null) {
      _formKey = GlobalKey<FormState>();
    }
    return _formKey!;
  }

  void resetFormKey() {
    if (_formKey != null) {
      _formKey!.currentState?.reset();
      _formKey = null;
    }
  }

  // Form validation
  bool validateForm() {
    if (_formKey?.currentState?.validate() == true) {
      return true;
    } else {
      return false;
    }
  }

  // Get all shift information as a map
  Map<String, dynamic> getShiftInfo() {
    return {
      'selectedDriverType': _selectedDriverType,
      'selectedWorkingDays': _selectedWorkingDays.toList(),
      'preferredStartTime': {
        'hour': _preferredStartTime.hour,
        'minute': _preferredStartTime.minute,
      },
      'selectedHours': _selectedHours,
      'declarations': Map.from(_declarations),
    };
  }

  // Set shift information from a map
  void setShiftInfo(Map<String, dynamic> shiftInfo) {
    _selectedDriverType = shiftInfo['selectedDriverType'] ?? 'fullTime';
    
    if (shiftInfo['selectedWorkingDays'] != null) {
      _selectedWorkingDays.clear();
      _selectedWorkingDays.addAll(List<String>.from(shiftInfo['selectedWorkingDays']));
    }
    
    if (shiftInfo['preferredStartTime'] != null) {
      final timeData = shiftInfo['preferredStartTime'];
      _preferredStartTime = TimeOfDay(
        hour: timeData['hour'] ?? 9,
        minute: timeData['minute'] ?? 0,
      );
    }
    
    _selectedHours = shiftInfo['selectedHours'] ?? 8;
    
    if (shiftInfo['declarations'] != null) {
      _declarations.clear();
      _declarations.addAll(Map<String, bool?>.from(shiftInfo['declarations']));
    }
    
    notifyListeners();
  }

  // Check if all required fields are filled
  bool get isFormComplete {
    return isValidWorkingDaysSelection && areAllDeclarationsAccepted;
  }

  // Clear all data
  void clearAllData() {
    _selectedDriverType = 'fullTime';
    _selectedWorkingDays.clear();
    _preferredStartTime = TimeOfDay(hour: 9, minute: 0);
    _selectedHours = 8;
    _declarations.updateAll((key, value) => null);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
