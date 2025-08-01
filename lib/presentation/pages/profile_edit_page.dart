import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../utils/app_theme.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  
  // TextEditingControllers for form fields
  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _catchCopyController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers with current data
    _nameController = TextEditingController(text: '新垣土 クリスティーナ・エリーゼ');
    _usernameController = TextEditingController(text: '@christina');
    _catchCopyController = TextEditingController(text: '美しく、知らない。');
    _bioController = TextEditingController(
      text: '''古物の心を理解し、人と物との出会いを紡ぎます。
世界の中に息づく歴史、物の命とその背景を通読します。
発見の日々は続く、過去と未来の架け橋、美すというものの本質を求めて。''',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _catchCopyController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      appBar: AppBar(
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        title: Text(
          'プロフィール編集',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkCharcoal,
          ),
        ),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.darkCharcoal,
            size: 20.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: Text(
              '完了',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppTheme.darkCharcoal,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile image section
              Container(
                color: AppTheme.pureWhite,
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: Center(
                  child: Column(
                    children: [
                      // Large profile image
                      Stack(
                        children: [
                          Container(
                            width: 140.w,
                            height: 140.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 25,
                                  offset: Offset(0, 12),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.lightGray,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.brown.withValues(alpha: 0.3),
                                      Colors.amber.withValues(alpha: 0.3),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: 70.sp,
                                  color: AppTheme.darkCharcoal.withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ),
                          // Camera overlay
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.3),
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 32.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      // Add button
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.borderGray),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 16.sp,
                              color: AppTheme.darkCharcoal,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Add',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppTheme.darkCharcoal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Form fields section
              Container(
                color: AppTheme.pureWhite,
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    _buildFormField(
                      label: '名前',
                      controller: _nameController,
                      maxLines: 1,
                    ),
                    SizedBox(height: 24.h),
                    _buildFormField(
                      label: 'ユーザー名',
                      controller: _usernameController,
                      maxLines: 1,
                    ),
                    SizedBox(height: 24.h),
                    _buildFormField(
                      label: 'キャッチコピー',
                      controller: _catchCopyController,
                      maxLines: 1,
                    ),
                    SizedBox(height: 24.h),
                    _buildFormField(
                      label: '自己紹介',
                      controller: _bioController,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Bottom description
              Container(
                color: AppTheme.pureWhite,
                padding: EdgeInsets.all(20.w),
                child: Text(
                  '入力したプロフィール情報は、他のユーザーがあなたを見つけやすくするために使用されます。',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.softGray,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required int maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.darkCharcoal,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.lightGray.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: AppTheme.borderGray.withValues(alpha: 0.3),
            ),
          ),
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.darkCharcoal,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: AppTheme.softGray,
              ),
            ),
            validator: (value) {
              if (label == '名前' && (value == null || value.trim().isEmpty)) {
                return '名前を入力してください';
              }
              if (label == 'ユーザー名' && (value == null || value.trim().isEmpty)) {
                return 'ユーザー名を入力してください';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Save profile logic here
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('プロフィールを保存しました'),
          backgroundColor: AppTheme.darkCharcoal,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
      
      // Go back to profile page
      context.pop();
    }
  }
} 