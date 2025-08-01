import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_theme.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> 
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _logoScaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
    ));

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _startAnimation();
  }

  void _startAnimation() async {
    await _logoController.forward();
    await _textController.forward();
    
    // 3秒後にウェルカム画面へ遷移
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        context.go('/welcome');
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppTheme.primaryGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  // 上部スペース
                  SizedBox(height: 120.h),
              
              // KOFUKU ロゴセクション
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _logoFadeAnimation,
                        child: ScaleTransition(
                          scale: _logoScaleAnimation,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // KOFUKU ロゴ
                              Container(
                                width: 120.w,
                                height: 120.w,
                                decoration: BoxDecoration(
                                  color: AppTheme.darkCharcoal,
                                  borderRadius: BorderRadius.circular(24.r),
                                  boxShadow: AppTheme.elevatedShadow,
                                ),
                                child: Center(
                                  child: Text(
                                    'K',
                                    style: TextStyle(
                                      fontSize: 48.sp,
                                      fontWeight: FontWeight.w300,
                                      color: AppTheme.accentYellow,
                                      letterSpacing: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                              
                              SizedBox(height: 24.h),
                              
                              // KOFUKU テキスト
                              Text(
                                'KOFUKU',
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontSize: 36.sp,
                                  fontWeight: FontWeight.w200,
                                  letterSpacing: 4.0,
                                  color: AppTheme.darkCharcoal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // メッセージセクション
              Expanded(
                flex: 2,
                child: AnimatedBuilder(
                  animation: _textController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _textFadeAnimation,
                      child: SlideTransition(
                        position: _textSlideAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'その服に、あなたの"愛"は\nありますか？',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.6,
                                color: AppTheme.darkCharcoal,
                              ),
                            ),
                            
                            SizedBox(height: 16.h),
                            
                            Text(
                              'HOSPITALITY IS BEAUTY',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppTheme.softGray,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

                  // 下部スペース
                  SizedBox(height: 80.h),
                ],
              ),
              
              // 開発用スキップボタン（デバッグモードのみ）
              if (kDebugMode)
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.darkCharcoal.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppTheme.accentYellow.withValues(alpha: 0.6),
                        width: 1.0,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20.r),
                        onTap: () {
                          context.go('/');
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.skip_next,
                                color: AppTheme.accentYellow,
                                size: 16.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'SKIP',
                                style: TextStyle(
                                  color: AppTheme.accentYellow,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
} 