import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          Text(
            'Connect with Stripe',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Set up secure payment processing with Stripe',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple.shade50,
            Colors.blue.shade50,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.purple.shade200),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.account_balance_wallet,
              size: 48.w,
              color: Colors.purple.shade600,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Stripe Payment Processing',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade800,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Connect your Stripe account to receive payments securely and efficiently',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.purple.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          _buildFeatureList(),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _isConnecting ? null : _connectStripe,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.h),
              ),
              child: _isConnecting
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text('Connecting...'),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.account_balance_wallet, size: 20.w),
                        SizedBox(width: 8.w),
                        Text('Connect Stripe'),
                      ],
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
              Icons.check_circle,
              color: Colors.green.shade600,
              size: 16.w,
            ),
            SizedBox(width: 8.w),
            Text(
              feature,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.purple.shade700,
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
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          Icon(
            Icons.check_circle,
            size: 48.w,
            color: Colors.green.shade600,
          ),
          SizedBox(height: 16.h),
          Text(
            'Stripe Connected Successfully!',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Your Stripe account is now connected and ready to process payments',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.green.shade700,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _isConnected = false;
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Disconnect',
                    style: TextStyle(color: Colors.red.shade600),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Stripe dashboard
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text('Dashboard'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Why Stripe?',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 12.h),
        _buildBenefitItem(
          'Fast Payouts',
          'Get paid within 2 business days',
          Icons.speed,
        ),
        _buildBenefitItem(
          'Low Fees',
          'Competitive rates starting at 2.9%',
          Icons.attach_money,
        ),
        _buildBenefitItem(
          'Global Reach',
          'Accept payments from customers worldwide',
          Icons.public,
        ),
        _buildBenefitItem(
          'Security',
          'Bank-level security and fraud protection',
          Icons.security,
        ),
      ],
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
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: Colors.blue.shade600,
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  description,
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

  Widget _buildSecurityInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security,
            color: Colors.blue.shade600,
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Stripe is PCI DSS compliant and uses industry-standard encryption to protect your data',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.blue.shade700,
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
        content: Text('Stripe connected successfully!'),
        backgroundColor: Colors.green,
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
