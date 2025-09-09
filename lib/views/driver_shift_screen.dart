import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/custom_colors.dart';

class DriverShiftScreen extends StatefulWidget {
  const DriverShiftScreen({super.key});

  @override
  State<DriverShiftScreen> createState() => _DriverShiftScreenState();
}

class _DriverShiftScreenState extends State<DriverShiftScreen> {
  TimeOfDay _startTime = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = TimeOfDay(hour: 17, minute: 0);
  final Set<String> _selectedDays = {'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'};
  String _shiftType = 'full_time';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Working Schedule',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Set your working hours and availability',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 24.h),
          
          // Shift Type Selection
          _buildShiftTypeSection(),
          SizedBox(height: 24.h),
          
          // Working Hours
          _buildWorkingHoursSection(),
          SizedBox(height: 24.h),
          
          // Working Days
          _buildWorkingDaysSection(),
          SizedBox(height: 24.h),
          
          // Availability Settings
          _buildAvailabilitySection(),
        ],
      ),
    );
  }

  Widget _buildShiftTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shift Type',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildShiftTypeOption('Full Time', '8+ hours per day', Icons.schedule, 'full_time'),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildShiftTypeOption('Part Time', '4-7 hours per day', Icons.access_time, 'part_time'),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        _buildShiftTypeOption('Flexible', 'Variable hours', Icons.schedule_send, 'flexible'),
      ],
    );
  }

  Widget _buildShiftTypeOption(String title, String subtitle, IconData icon, String value) {
    final isSelected = _shiftType == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _shiftType = value;
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? CustomColors.purpleColor : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected ? CustomColors.purpleColor.withOpacity(0.1) : Colors.white,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? CustomColors.purpleColor : Colors.grey.shade600,
              size: 24.w,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? CustomColors.purpleColor : Colors.black87,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: CustomColors.purpleColor,
                size: 20.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHoursSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Working Hours',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildTimeSelector('Start Time', _startTime, () => _selectStartTime()),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _buildTimeSelector('End Time', _endTime, () => _selectEndTime()),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Colors.blue.shade600,
                size: 16.w,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'You can adjust your hours anytime in the app',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blue.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeSelector(String label, TimeOfDay time, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  color: Colors.grey.shade600,
                  size: 20.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  time.format(context),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingDaysSection() {
    final days = [
      {'name': 'Monday', 'short': 'Mon'},
      {'name': 'Tuesday', 'short': 'Tue'},
      {'name': 'Wednesday', 'short': 'Wed'},
      {'name': 'Thursday', 'short': 'Thu'},
      {'name': 'Friday', 'short': 'Fri'},
      {'name': 'Saturday', 'short': 'Sat'},
      {'name': 'Sunday', 'short': 'Sun'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Working Days',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: days.map((day) {
            final isSelected = _selectedDays.contains(day['name']);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedDays.remove(day['name']);
                  } else {
                    _selectedDays.add(day['name']!);
                  }
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? CustomColors.purpleColor : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected ? CustomColors.purpleColor : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  day['short']!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _selectAllDays,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: CustomColors.purpleColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Select All',
                  style: TextStyle(
                    color: CustomColors.purpleColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: OutlinedButton(
                onPressed: _clearAllDays,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAvailabilitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Availability Settings',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        _buildAvailabilityOption(
          'Available for immediate bookings',
          'Accept rides as soon as they come in',
          Icons.flash_on,
          true,
        ),
        _buildAvailabilityOption(
          'Advance booking only',
          'Only accept rides scheduled in advance',
          Icons.schedule,
          false,
        ),
        _buildAvailabilityOption(
          'Peak hours only',
          'Only work during high-demand periods',
          Icons.trending_up,
          false,
        ),
      ],
    );
  }

  Widget _buildAvailabilityOption(String title, String subtitle, IconData icon, bool isSelected) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Radio<bool>(
            value: isSelected,
            groupValue: true, // This would be managed by a state variable
            onChanged: (value) {
              // Handle availability option selection
            },
            activeColor: CustomColors.purpleColor,
          ),
          SizedBox(width: 8.w),
          Icon(
            icon,
            color: Colors.grey.shade600,
            size: 20.w,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  void _selectAllDays() {
    setState(() {
      _selectedDays.addAll([
        'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
      ]);
    });
  }

  void _clearAllDays() {
    setState(() {
      _selectedDays.clear();
    });
  }

  // Getters for accessing form data
  Map<String, String> getFormData() {
    return {
      'shiftType': _shiftType,
      'startTime': _startTime.format(context),
      'endTime': _endTime.format(context),
      'workingDays': _selectedDays.join(', '),
    };
  }
}
