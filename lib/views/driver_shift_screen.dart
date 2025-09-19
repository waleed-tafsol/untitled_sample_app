import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
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
  String _availabilityType = 'immediate';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: CustomColors.primaryColor.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Iconsax.clock,
                      color: CustomColors.primaryColor,
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Working Schedule',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.blackColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Set your working hours and availability',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 14.sp,
                    color: CustomColors.blackColor.withValues(alpha: 0.6),
                  ),
                ),
              ],
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
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shift Type',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildShiftTypeOption('Full Time', '8+ hours per day', Iconsax.clock, 'full_time'),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildShiftTypeOption('Part Time', '4-7 hours per day', Iconsax.timer, 'part_time'),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          _buildShiftTypeOption('Flexible', 'Variable hours', Iconsax.clock_1, 'flexible'),
        ],
      ),
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
            color: isSelected 
                ? CustomColors.primaryColor 
                : CustomColors.primaryColor.withValues(alpha: 0.2),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected 
              ? CustomColors.primaryColor.withValues(alpha: 0.1) 
              : CustomColors.whiteColor,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? CustomColors.primaryColor 
                  : CustomColors.blackColor.withValues(alpha: 0.6),
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
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                          ? CustomColors.primaryColor 
                          : CustomColors.blackColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 12.sp,
                      color: CustomColors.blackColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Iconsax.tick_circle,
                color: CustomColors.primaryColor,
                size: 20.w,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkingHoursSection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Working Hours',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 20.h),
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
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: CustomColors.primaryColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.info_circle,
                  color: CustomColors.primaryColor,
                  size: 20.w,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'You can adjust your hours anytime in the app',
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 12.sp,
                      color: CustomColors.blackColor.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector(String label, TimeOfDay time, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: CustomColors.blackColor,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: CustomColors.primaryColor.withValues(alpha: 0.2),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.r),
              color: CustomColors.whiteColor,
            ),
            child: Row(
              children: [
                Icon(
                  Iconsax.clock,
                  color: CustomColors.primaryColor,
                  size: 20.w,
                ),
                SizedBox(width: 12.w),
                Text(
                  time.format(context),
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 14.sp,
                    color: CustomColors.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Iconsax.arrow_down_2,
                  color: CustomColors.blackColor.withValues(alpha: 0.4),
                  size: 16.w,
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

    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Working Days',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 16.h),
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? CustomColors.primaryColor 
                        : CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected 
                          ? CustomColors.primaryColor 
                          : CustomColors.primaryColor.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    day['short']!,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected 
                          ? CustomColors.whiteColor 
                          : CustomColors.blackColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: CustomColors.primaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: _selectAllDays,
                      child: Center(
                        child: Text(
                          'Select All',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            color: CustomColors.primaryColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Container(
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: CustomColors.blackColor.withValues(alpha: 0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: _clearAllDays,
                      child: Center(
                        child: Text(
                          'Clear All',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            color: CustomColors.blackColor.withValues(alpha: 0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilitySection() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Availability Settings',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 16.h),
          _buildAvailabilityOption(
            'Available for immediate bookings',
            'Accept rides as soon as they come in',
            Iconsax.flash_1,
            'immediate',
          ),
          _buildAvailabilityOption(
            'Advance booking only',
            'Only accept rides scheduled in advance',
            Iconsax.clock,
            'advance',
          ),
          _buildAvailabilityOption(
            'Peak hours only',
            'Only work during high-demand periods',
            Iconsax.trend_up,
            'peak',
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityOption(String title, String subtitle, IconData icon, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _availabilityType = value;
          });
        },
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: _availabilityType,
              onChanged: (value) {
                setState(() {
                  _availabilityType = value!;
                });
              },
              activeColor: CustomColors.primaryColor,
            ),
            SizedBox(width: 8.w),
            Icon(
              icon,
              color: CustomColors.primaryColor,
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
                      fontFamily: 'CircularStd',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.blackColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 12.sp,
                      color: CustomColors.blackColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      'availabilityType': _availabilityType,
    };
  }
}