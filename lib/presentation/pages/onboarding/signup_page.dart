import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_theme.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _agreeToTerms = false;
  bool _agreeToMarketing = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.pureWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.pureWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, 
            color: AppTheme.darkCharcoal, size: 20.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(
          '会員登録',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.darkCharcoal,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32.h),
              
              // ソーシャルログインセクション
              Text(
                'かんたん登録',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // ソーシャルログインボタン
              Column(
                children: [
                  // Apple でサインアップ
                  _buildSocialButton(
                    icon: Icons.apple,
                    label: 'Apple でサインアップ',
                    backgroundColor: AppTheme.darkCharcoal,
                    textColor: AppTheme.pureWhite,
                    onTap: () => _showComingSoon('Apple ログイン'),
                  ),
                  
                  SizedBox(height: 12.h),
                  
                  // Google で登録
                  _buildSocialButton(
                    icon: Icons.g_mobiledata,
                    label: 'Google で登録',
                    backgroundColor: AppTheme.pureWhite,
                    textColor: AppTheme.darkCharcoal,
                    borderColor: AppTheme.borderGray,
                    onTap: () => _showComingSoon('Google ログイン'),
                  ),
                  
                  SizedBox(height: 12.h),
                  
                  // LINE で登録
                  _buildSocialButton(
                    icon: Icons.chat_bubble,
                    label: 'LINE で登録',
                    backgroundColor: Color(0xFF00C300),
                    textColor: AppTheme.pureWhite,
                    onTap: () => _showComingSoon('LINE ログイン'),
                  ),
                  
                  SizedBox(height: 12.h),
                  
                  // Facebook で登録
                  _buildSocialButton(
                    icon: Icons.facebook,
                    label: 'Facebook で登録',
                    backgroundColor: Color(0xFF1877F2),
                    textColor: AppTheme.pureWhite,
                    onTap: () => _showComingSoon('Facebook ログイン'),
                  ),
                ],
              ),
              
              SizedBox(height: 32.h),
              
              // または
              Row(
                children: [
                  Expanded(child: Divider(color: AppTheme.borderGray)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'または',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.softGray,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppTheme.borderGray)),
                ],
              ),
              
              SizedBox(height: 32.h),
              
              // メール登録フォーム
              Text(
                'メールアドレスで登録',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              
              SizedBox(height: 16.h),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // メールアドレス
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'メールアドレス',
                        hintText: 'example@kofuku.com',
                        filled: true,
                        fillColor: AppTheme.lightGray,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppTheme.borderGray),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppTheme.borderGray),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppTheme.darkCharcoal),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'メールアドレスを入力してください';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return '有効なメールアドレスを入力してください';
                        }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // パスワード
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'パスワード',
                        hintText: '8文字以上で入力してください',
                        filled: true,
                        fillColor: AppTheme.lightGray,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: AppTheme.softGray,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppTheme.borderGray),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppTheme.borderGray),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: AppTheme.darkCharcoal),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'パスワードを入力してください';
                        }
                        if (value.length < 8) {
                          return 'パスワードは8文字以上で入力してください';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // 同意チェックボックス
              Column(
                children: [
                  CheckboxListTile(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppTheme.darkCharcoal,
                    title: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.darkCharcoal,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(text: '利用規約 と プライバシーポリシー に同意する'),
                        ],
                      ),
                    ),
                  ),
                  
                  CheckboxListTile(
                    value: _agreeToMarketing,
                    onChanged: (value) {
                      setState(() {
                        _agreeToMarketing = value ?? false;
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppTheme.darkCharcoal,
                    title: Text(
                      'お得なクーポンやキャンペーン情報などをメール配信',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.darkCharcoal,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 32.h),
              
              // 登録ボタン
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: _agreeToTerms ? _handleSignup : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _agreeToTerms ? AppTheme.darkCharcoal : AppTheme.softGray,
                    foregroundColor: AppTheme.pureWhite,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    '登録する',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 32.h),
              
              // 既にアカウントをお持ちの方
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.go('/login');
                  },
                  child: Text(
                    '既にアカウントをお持ちの方はこちら',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.softGray,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required Color backgroundColor,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20.sp, color: textColor),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          side: borderColor != null 
              ? BorderSide(color: borderColor, width: 1.0) 
              : null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature は開発中です'),
        backgroundColor: AppTheme.darkCharcoal,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }

  void _handleSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: 実際のサインアップ処理
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('サインアップ機能は開発中です'),
          backgroundColor: AppTheme.darkCharcoal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      );
      
      // 仮でホーム画面に遷移
      context.go('/');
    }
  }
} 