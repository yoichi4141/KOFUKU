import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_theme.dart';

class WelcomePage extends ConsumerWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.lightGray,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              
              // ロゴセクション
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppTheme.darkCharcoal,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: AppTheme.subtleShadow,
                ),
                child: Center(
                  child: Text(
                    'K',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w300,
                      color: AppTheme.accentYellow,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              Text(
                'KOFUKU',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.0,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              
              SizedBox(height: 40.h),
              
              // メインメッセージ
              Text(
                'あなたの愛の物語を\n共有しませんか？',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              
              SizedBox(height: 16.h),
              
              Text(
                '服に込められた思い出とエッセイで\n新しい持ち主との出会いを',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 14.sp,
                  color: AppTheme.softGray,
                  height: 1.6,
                ),
              ),
              
              const Spacer(),
              
              // ボタンセクション
              Column(
                children: [
                  // 会員登録ボタン
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.darkCharcoal,
                        foregroundColor: AppTheme.pureWhite,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        '会員登録',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 16.h),
                  
                  // ログインボタン
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.darkCharcoal,
                        side: BorderSide(
                          color: AppTheme.borderGray,
                          width: 1.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        backgroundColor: AppTheme.pureWhite,
                      ),
                      child: Text(
                        'ログイン',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // 利用規約・プライバシーポリシー
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TODO: 利用規約画面へ
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('利用規約は開発中です'),
                              backgroundColor: AppTheme.darkCharcoal,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          '利用規約',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color: AppTheme.softGray,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      
                      Text(
                        ' ・ ',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12.sp,
                          color: AppTheme.softGray,
                        ),
                      ),
                      
                      GestureDetector(
                        onTap: () {
                          // TODO: プライバシーポリシー画面へ
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('プライバシーポリシーは開発中です'),
                              backgroundColor: AppTheme.darkCharcoal,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'プライバシーポリシー',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 12.sp,
                            color: AppTheme.softGray,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
} 