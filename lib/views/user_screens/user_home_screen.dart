import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/custom_colors.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        backgroundColor: CustomColors.whiteColor,
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: CustomColors.blackColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.notification,
              color: CustomColors.blackColor,
              size: 24.sp,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 8.w),
        ],
      ),
      drawer: Drawer(
        backgroundColor: CustomColors.whiteColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                color: CustomColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: CustomColors.whiteColor,
                      child: Icon(
                        Iconsax.user,
                        size: 30.sp,
                        color: CustomColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.whiteColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'john.doe@email.com',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 14.sp,
                        color: CustomColors.whiteColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Drawer Menu Items
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: [
                  _buildDrawerItem(
                    icon: Iconsax.home_2,
                    title: 'Home',
                    isSelected: true,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildDrawerItem(
                    icon: Iconsax.profile_2user,
                    title: 'Profile',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Iconsax.setting_2,
                    title: 'Settings',
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Iconsax.message_question,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  SizedBox(height: 20.h),
                  Divider(
                    color: CustomColors.blackColor.withValues(alpha: 0.1),
                    thickness: 1,
                  ),
                  SizedBox(height: 20.h),
                  _buildDrawerItem(
                    icon: Iconsax.logout,
                    title: 'Logout',
                    isLogout: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              
              // Welcome Section
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: CustomColors.blackColor,
                ),
              ),
              
              SizedBox(height: 8.h),
              
              Text(
                'Here\'s what\'s happening today',
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 16.sp,
                  color: CustomColors.blackColor.withValues(alpha: 0.6),
                ),
              ),
              
              SizedBox(height: 30.h),
              
              // Quick Actions Card
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
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.blackColor,
                      ),
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            icon: Iconsax.add_circle,
                            title: 'New Task',
                            onTap: () {},
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: _buildActionButton(
                            icon: Iconsax.calendar,
                            title: 'Schedule',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Recent Activity Card
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
                    Text(
                      'Recent Activity',
                      style: TextStyle(
                        fontFamily: 'CircularStd',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: CustomColors.blackColor,
                      ),
                    ),
                    
                    SizedBox(height: 20.h),
                    
                    _buildActivityItem(
                      icon: Iconsax.tick_circle,
                      title: 'Task Completed',
                      subtitle: 'Project milestone achieved',
                      time: '2 hours ago',
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    _buildActivityItem(
                      icon: Iconsax.message,
                      title: 'New Message',
                      subtitle: 'You have 3 unread messages',
                      time: '4 hours ago',
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    _buildActivityItem(
                      icon: Iconsax.notification,
                      title: 'Reminder',
                      subtitle: 'Meeting at 3:00 PM',
                      time: '6 hours ago',
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    bool isSelected = false,
    bool isLogout = false,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: isSelected ? CustomColors.primaryColor.withValues(alpha: 0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout 
              ? Colors.red.shade600 
              : isSelected 
                  ? CustomColors.primaryColor 
                  : CustomColors.blackColor.withValues(alpha: 0.7),
          size: 22.sp,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 16.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isLogout 
                ? Colors.red.shade600 
                : isSelected 
                    ? CustomColors.primaryColor 
                    : CustomColors.blackColor,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: CustomColors.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: CustomColors.primaryColor.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: CustomColors.primaryColor,
              size: 24.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: CustomColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: CustomColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            icon,
            color: CustomColors.primaryColor,
            size: 20.sp,
          ),
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
                  color: CustomColors.blackColor,
                ),
              ),
              SizedBox(height: 2.h),
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
        Text(
          time,
          style: TextStyle(
            fontFamily: 'CircularStd',
            fontSize: 10.sp,
            color: CustomColors.blackColor.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}