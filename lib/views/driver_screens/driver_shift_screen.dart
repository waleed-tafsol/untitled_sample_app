import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../../view_models/driver_registration_view_model.dart';

class DriverShiftScreen extends StatelessWidget {
  const DriverShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DriverRegistrationViewModel>(
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.getFormKeyForStep(4),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
              child: AnimationLimiter(
                child: Column(
                  children: [
                    // Header
                    _buildHeader(context),
                    SizedBox(height: 30.h),

                    // Driver Type Options
                    Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder: (widget) => FlipAnimation(
                          duration: Duration(seconds: 1),
                          child: FadeInAnimation(
                            child: widget,
                          ),
                        ),
                        children: [
                          _buildDriverTypeOption(
                            context,
                            title: 'Full-Time Driver',
                            description: 'Minimum 24 hours/week • 4+ days • 6+ hours/day • Higher priority for rides\n\nPriority bookings\nFlexible hours',
                            isRecommended: true,
                            isSelected: viewModel.isFullTimeDriver,
                            onTap: () => viewModel.setDriverType('fullTime'),
                          ),
                          SizedBox(height: 20.h),

                          _buildDriverTypeOption(
                            context,
                            title: 'Part-time Driver/Student',
                            description: 'Maximum 24 hours/week • Up to 3 days • 6 hours/day max • Study-friendly schedule\n\nWeekend focus\nFlexible timing',
                            isRecommended: false,
                            isSelected: viewModel.isPartTimeDriver,
                            onTap: () => viewModel.setDriverType('partTime'),
                          ),
                          // Show working days and hours sections when driver type is selected
                          if (viewModel.isFullTimeDriver || viewModel.isPartTimeDriver) ...[
                            SizedBox(height: 30.h),

                            // Working Days Section
                            _buildWorkingDaysSection(context, viewModel),
                            SizedBox(height: 20.h),

                            // Working Hours Section
                            _buildWorkingHoursSection(context, viewModel),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        black24w600(data: 'Shift Selection'),
        grey12(data: 'Choose the driver type that best fits your schedule and availability.',centre: true),
      ],
    );
  }

  Widget _buildWorkingDaysSection(BuildContext context, DriverRegistrationViewModel viewModel) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final isFullTime = viewModel.isFullTimeDriver;
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
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
                Iconsax.calendar_1,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Working Days'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: isFullTime 
                ? 'Select at least 4 days per week for full-time drivers'
                : 'Select up to 3 days per week for part-time drivers',
          ),
          SizedBox(height: 20.h),
          
          // Days Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: days.map((day) {
                final isSelected = viewModel.isWorkingDaySelected(day);
                final canSelect = isFullTime || viewModel.getSelectedWorkingDaysCount < 3 || isSelected;
                
                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: canSelect ? () => viewModel.toggleWorkingDay(day) : null,
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? CustomColors.primaryColor
                            : CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected 
                              ? CustomColors.primaryColor
                              : CustomColors.greyColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: isSelected 
                                ? CustomColors.whiteColor
                                : canSelect 
                                    ? CustomColors.blackColor
                                    : CustomColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Validation message
          if (!viewModel.isValidWorkingDaysSelection) ...[
            SizedBox(height: 12.h),
            Text(
              isFullTime 
                  ? 'Please select at least 4 days'
                  : 'Please select 1-3 days',
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 12.sp,
                color: Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildWorkingHoursSection(BuildContext context, DriverRegistrationViewModel viewModel) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[9],
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
              black18w500(data: 'Working Hours'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: 'Set your preferred start time and number of working hours per day',
          ),
          SizedBox(height: 20.h),
          
          // Preferred Start Time
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preferred Start Time',
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: viewModel.getPreferredStartTime,
                  );
                  if (picked != null) {
                    viewModel.setPreferredStartTime(picked);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: CustomColors.greyColor.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.clock,
                        color: CustomColors.primaryColor,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        viewModel.getPreferredStartTime.format(context),
                        style: TextStyle(
                          fontFamily: 'CircularStd',
                          fontSize: 14.sp,
                          color: CustomColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 20.h),
          
          // Hours per Day
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hours per Day',
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: CustomColors.blackColor,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColors.greyColor.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Iconsax.timer,
                          color: CustomColors.primaryColor,
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          '${viewModel.getSelectedHours} hours',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => viewModel.setSelectedHours(viewModel.getSelectedHours - 1),
                          child: Container(
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(
                              color: viewModel.getSelectedHours > viewModel.getMinHours
                                  ? CustomColors.primaryColor.withOpacity(0.1)
                                  : CustomColors.greyColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: viewModel.getSelectedHours > viewModel.getMinHours
                                    ? CustomColors.primaryColor.withOpacity(0.3)
                                    : CustomColors.greyColor.withOpacity(0.3),
                              ),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 18.w,
                              color: viewModel.getSelectedHours > viewModel.getMinHours
                                  ? CustomColors.primaryColor
                                  : CustomColors.greyColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () => viewModel.setSelectedHours(viewModel.getSelectedHours + 1),
                          child: Container(
                            width: 32.w,
                            height: 32.w,
                            decoration: BoxDecoration(
                              color: viewModel.getSelectedHours < viewModel.getMaxHours
                                  ? CustomColors.primaryColor.withOpacity(0.1)
                                  : CustomColors.greyColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: viewModel.getSelectedHours < viewModel.getMaxHours
                                    ? CustomColors.primaryColor.withOpacity(0.3)
                                    : CustomColors.greyColor.withOpacity(0.3),
                              ),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 18.w,
                              color: viewModel.getSelectedHours < viewModel.getMaxHours
                                  ? CustomColors.primaryColor
                                  : CustomColors.greyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          // Hours range info
          SizedBox(height: 12.h),
          Text(
            'Range: ${viewModel.getMinHours}-${viewModel.getMaxHours} hours per day',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 12.sp,
              color: CustomColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDriverTypeOption(
    BuildContext context, {
    required String title,
    required String description,
    required bool isRecommended,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: isSelected 
              ? CustomColors.primaryColor.withOpacity(0.1)
              : CustomColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected 
                ? CustomColors.primaryColor
                : CustomColors.greyColor.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected 
              ? [
                  BoxShadow(
                    color: CustomColors.primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ]
              : kElevationToShadow[2],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Recommended Badge
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'CircularStd',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: CustomColors.blackColor,
                    ),
                  ),
                ),
                if (isRecommended) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: CustomColors.primaryColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'Recommended',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: CustomColors.whiteColor,
                      ),
                    ),
                  ),
                ],
                SizedBox(width: 12.w),
                // Checkbox
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected 
                          ? CustomColors.primaryColor
                          : CustomColors.greyColor.withOpacity(0.5),
                      width: 2,
                    ),
                    color: isSelected 
                        ? CustomColors.primaryColor
                        : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          color: CustomColors.whiteColor,
                          size: 16.w,
                        )
                      : null,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            
            // Description
            Text(
              description,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 12.sp,
                color: CustomColors.blackColor.withOpacity(0.7),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}