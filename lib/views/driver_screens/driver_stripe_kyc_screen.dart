import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_font_style.dart';
import '../../utils/custom_buttons.dart';
import '../../view_models/driver_registration_view_model.dart';

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
    return Consumer<DriverRegistrationViewModel>(
      builder: (context, viewModel, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
            child: Column(
              children: [
                // Header
                _buildHeader(context),
                SizedBox(height: 20.h),
                
                // Stripe Connection Section
                _buildStripeConnectionSection(context),
                SizedBox(height: 20.h),
                
                // Benefits Section
                _buildBenefitsSection(context),
                SizedBox(height: 20.h),
                
                // Security Information
                _buildSecurityInfo(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        black24w600(data: 'Stripe KYC'),
        grey12(data: 'Connect with Stripe for secure payment processing and compliance verification.'),
      ],
    );
  }

  Widget _buildStripeConnectionSection(BuildContext context) {
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
        children: [
          Row(
            children: [
              Icon(
                Iconsax.wallet_3,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Stripe Account'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: 'Connect your Stripe account to receive payments securely and efficiently',
          ),
          SizedBox(height: 20.h),
          
          if (!_isConnected) _buildConnectionCard(context),
          if (_isConnected) _buildConnectedCard(context),
        ],
      ),
    );
  }

  Widget _buildConnectionCard(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: CustomColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              Icon(
                Iconsax.wallet_3,
                size: 48.w,
                color: CustomColors.primaryColor,
              ),
              SizedBox(height: 16.h),
              black18w500(data: 'Connect to Stripe'),
              SizedBox(height: 8.h),
              grey12(
                data: 'Set up secure payment processing with industry-leading security',
              ),
              SizedBox(height: 20.h),
              
              // Features List
              _buildFeatureList(context),
              SizedBox(height: 24.h),
              
              // Connect Button
              customButton(
                text: _isConnecting ? 'Connecting...' : 'Connect with Stripe',
                onTap: _isConnecting ? () {} : _connectStripe,
                colored: !_isConnecting,
                icon: Iconsax.wallet_3,
                height: 50,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildConnectedCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.green.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Iconsax.tick_circle,
                color: Colors.green,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Connected Successfully',
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          grey12(
            data: 'Your Stripe account is connected and ready for payments',
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: customButton(
                  text: 'View Account',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Opening Stripe Dashboard')),
                    );
                  },
                  colored: false,
                  icon: Iconsax.eye,
                  height: 40,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: customButton(
                  text: 'Disconnect',
                  onTap: _disconnectStripe,
                  colored: false,
                  icon: Iconsax.logout,
                  height: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureList(BuildContext context) {
    final features = [
      'Secure payment processing',
      'PCI DSS compliance',
      'Real-time transaction monitoring',
      'Automated tax calculations',
      'Multi-currency support',
      'Fraud protection',
    ];

    return Column(
      children: features.map((feature) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            Icon(
              Iconsax.tick_circle,
              color: CustomColors.primaryColor,
              size: 16.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                feature,
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 12.sp,
                  color: CustomColors.blackColor.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildBenefitsSection(BuildContext context) {
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
        children: [
          Row(
            children: [
              Icon(
                Iconsax.star,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Benefits'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: 'Why choose Stripe for your payment processing needs',
          ),
          SizedBox(height: 20.h),
          
          _buildBenefitItem(
            context,
            icon: Iconsax.shield_tick,
            title: 'Bank-Level Security',
            description: 'PCI DSS Level 1 compliance with end-to-end encryption',
          ),
          SizedBox(height: 16.h),
          
          _buildBenefitItem(
            context,
            icon: Iconsax.global,
            title: 'Global Reach',
            description: 'Accept payments from customers worldwide in 135+ currencies',
          ),
          SizedBox(height: 16.h),
          
          _buildBenefitItem(
            context,
            icon: Iconsax.chart_2,
            title: 'Real-Time Analytics',
            description: 'Track your earnings and transactions with detailed insights',
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: CustomColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
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
              SizedBox(height: 4.h),
              Text(
                description,
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 12.sp,
                  color: CustomColors.blackColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSecurityInfo(BuildContext context) {
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
        children: [
          Row(
            children: [
              Icon(
                Iconsax.security_safe,
                color: CustomColors.primaryColor,
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              black18w500(data: 'Security & Compliance'),
            ],
          ),
          SizedBox(height: 8.h),
          grey12(
            data: 'Your data and payments are protected by industry-leading security measures',
          ),
          SizedBox(height: 20.h),
          
          _buildSecurityItem(
            context,
            'PCI DSS Level 1',
            'Highest level of payment security certification',
          ),
          SizedBox(height: 12.h),
          
          _buildSecurityItem(
            context,
            '256-bit SSL Encryption',
            'All data is encrypted in transit and at rest',
          ),
          SizedBox(height: 12.h),
          
          _buildSecurityItem(
            context,
            'Fraud Detection',
            'Advanced machine learning algorithms prevent fraudulent transactions',
          ),
          SizedBox(height: 12.h),
          
          _buildSecurityItem(
            context,
            'Regular Audits',
            'Continuous security monitoring and compliance verification',
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityItem(
    BuildContext context,
    String title,
    String description,
  ) {
    return Row(
      children: [
        Icon(
          Iconsax.tick_circle,
          color: Colors.green,
          size: 16.sp,
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
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: CustomColors.blackColor,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontFamily: 'CircularStd',
                  fontSize: 10.sp,
                  color: CustomColors.blackColor.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _connectStripe() async {
    setState(() {
      _isConnecting = true;
    });

    // Simulate connection process
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isConnecting = false;
      _isConnected = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Successfully connected to Stripe!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _disconnectStripe() {
    setState(() {
      _isConnected = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Disconnected from Stripe'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}