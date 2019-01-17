//
//  SplashManager.m
//  SplashScreen
//
//  Created by Jason Liang on 1/17/19.
//

#import "RNSplashManager.h"

@implementation RNSplashManager

+ (RNSplashManager *)sharedInstance {
  static RNSplashManager *instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    instance = [[RNSplashManager alloc] init];
  });
  return instance;
}

+ (void)registerSplashViewController:(UIViewController *)splashVC withWindow:(UIWindow *)window {
  RNSplashManager *mgr = [RNSplashManager sharedInstance];
  NSAssert(window.rootViewController, @"Must have a rootViewController already assigned.");
  NSAssert(!window.isKeyWindow, @"Must not be the key window yet.");
  NSAssert(!mgr.shownSplashVC, @"Can only show custom splash VC once");
  mgr.shownSplashVC = YES;
  mgr.splashVC = splashVC;
  UIViewController *rootVC = [UIViewController new];
  [RNSplashManager embedViewController:splashVC intoRootViewController:rootVC top:YES];
  [RNSplashManager embedViewController:window.rootViewController intoRootViewController:rootVC top:NO];
  window.rootViewController = rootVC;
}

+ (void)embedViewController:(UIViewController *)vc intoRootViewController:(UIViewController *)rootVC top:(BOOL)top {
  [rootVC addChildViewController:vc];
  if (top) {
    [rootVC.view addSubview:vc.view];
  } else {
    [rootVC.view insertSubview:vc.view atIndex:0];
  }
  vc.view.frame = rootVC.view.bounds;
  vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


+ (void)hideSplashVC {
  RNSplashManager *mgr = [RNSplashManager sharedInstance];
  UIViewController *splashVC = mgr.splashVC;
  if (!splashVC) {
    return;
  }
  if ([splashVC conformsToProtocol:@protocol(RNSplashManagerDelegate)]) {
    [(UIViewController <RNSplashManagerDelegate> *)splashVC stopLoading];
  }
  [UIView animateWithDuration:mgr.fadeDuration delay:mgr.fadeDelay options:0 animations:^{
    splashVC.view.alpha = 0;
  } completion:^(BOOL finished) {
    [splashVC removeFromParentViewController];
    [splashVC.view removeFromSuperview];
    mgr.splashVC = nil;
    if (mgr.splashCompletionHandler) {
      mgr.splashCompletionHandler();
    }
  }];
}

@end
