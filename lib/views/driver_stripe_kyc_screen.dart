import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import '../utils/custom_colors.dart';

class DriverStripeKycScreen extends StatefulWidget {
  const DriverStripeKycScreen({super.key});

  @override
  State<DriverStripeKycScreen> createState() => _DriverStripeKycScreenState();
}

class _DriverStripeKycScreenState extends State<DriverStripeKycScreen> {
  bool _isConnected = false;
  bool _isConnecting = false;

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
                      Iconsax.wallet_3,
                      color: CustomColors.primaryColor,
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Connect with Stripe',
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
                  'Set up secure payment processing with Stripe',
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
          
          if (!_isConnected) _buildStripeConnectionCard(),
          if (_isConnected) _buildConnectedCard(),
          
          SizedBox(height: 24.h),
          
          // Benefits Section
          _buildBenefitsSection(),
          
          SizedBox(height: 24.h),
          
          // Security Information
          _buildSecurityInfo(),
        ],
      ),
    );
  }

  Widget _buildStripeConnectionCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Icon(
              Iconsax.wallet_3,
              size: 48.w,
              color: CustomColors.primaryColor,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Stripe Payment Processing',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Connect your Stripe account to receive payments securely and efficiently',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 14.sp,
              color: CustomColors.blackColor.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          _buildFeatureList(),
          SizedBox(height: 24.h),
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: CustomColors.primaryColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: _isConnecting ? null : _connectStripe,
                child: Center(
                  child: _isConnecting
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(CustomColors.whiteColor),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              'Connecting...',
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.whiteColor,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.wallet_3, size: 20.sp, color: CustomColors.whiteColor),
                            SizedBox(width: 8.w),
                            Text(
                              'Connect Stripe',
                              style: TextStyle(
                                fontFamily: 'CircularStd',
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: CustomColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList() {
    final features = [
      'Secure payment processing',
      'Instant payouts',
      'Global payment methods',
      'Fraud protection',
      'Real-time analytics',
      'Mobile-optimized checkout',
    ];

    return Column(
      children: features.map((feature) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            Icon(
              Iconsax.tick_circle,
              color: CustomColors.primaryColor,
              size: 16.w,
            ),
            SizedBox(width: 8.w),
            Text(
              feature,
              style: TextStyle(
                fontFamily: 'CircularStd',
                fontSize: 14.sp,
                color: CustomColors.blackColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildConnectedCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: CustomColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: CustomColors.primaryColor,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Iconsax.tick_circle,
            size: 48.w,
            color: CustomColors.primaryColor,
          ),
          SizedBox(height: 16.h),
          Text(
            'Stripe Connected Successfully!',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your Stripe account is now connected and ready to process payments',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 14.sp,
              color: CustomColors.blackColor.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.red.shade400,
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        setState(() {
                          _isConnected = false;
                        });
                      },
                      child: Center(
                        child: Text(
                          'Disconnect',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        // Handle Stripe dashboard
                      },
                      child: Center(
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                            fontFamily: 'CircularStd',
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: CustomColors.whiteColor,
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

  Widget _buildBenefitsSection() {
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
            'Why Stripe?',
            style: TextStyle(
              fontFamily: 'CircularStd',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: CustomColors.blackColor,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBenefitItem(
            'Fast Payouts',
            'Get paid within 2 business days',
            Iconsax.flash_1,
          ),
          _buildBenefitItem(
            'Low Fees',
            'Competitive rates starting at 2.9%',
            Iconsax.dollar_circle,
          ),
          _buildBenefitItem(
            'Global Reach',
            'Accept payments from customers worldwide',
            Iconsax.global,
          ),
          _buildBenefitItem(
            'Security',
            'Bank-level security and fraud protection',
            Iconsax.shield_tick,
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String title, String description, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: CustomColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: CustomColors.primaryColor,
              size: 20.w,
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
                Text(
                  description,
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
    );
  }

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: CustomColors.primaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: CustomColors.primaryColor.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.shield_tick,
            color: CustomColors.primaryColor,
            size: 20.w,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Security & Compliance',
                  style: TextStyle(
                    fontFamily: 'CircularStd',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: CustomColors.blackColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Stripe is PCI DSS compliant and uses industry-standard encryption to protect your data',
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
    );
  }

  void _connectStripe() async {
    setState(() {
      _isConnecting = true;
    });

    // Simulate Stripe connection process
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isConnecting = false;
      _isConnected = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Stripe connected successfully!',
          style: TextStyle(
            fontFamily: 'CircularStd',
            color: CustomColors.whiteColor,
          ),
        ),
        backgroundColor: CustomColors.primaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Getters for accessing connection status
  bool get isConnected => _isConnected;
  Map<String, dynamic> getFormData() {
    return {
      'stripeConnected': _isConnected,
      'connectionDate': _isConnected ? DateTime.now().toIso8601String() : null,
    };
  }
}