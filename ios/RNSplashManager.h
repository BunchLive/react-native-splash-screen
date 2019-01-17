//
//  SplashManager.h
//  SplashScreen
//
//  Created by Jason Liang on 1/17/19.
//

#import <UIKit/UIKit.h>

@protocol RNSplashManagerDelegate <NSObject>

- (void)stopLoading;

@end

@interface RNSplashManager : NSObject

+ (RNSplashManager *)sharedInstance;

@property (nonatomic) UIViewController *splashVC;
@property (nonatomic) BOOL shownSplashVC;
@property (nonatomic) CGFloat fadeDuration;
@property (nonatomic) CGFloat fadeDelay;
@property (nonatomic) void (^splashCompletionHandler)();

+ (void)registerSplashViewController:(UIViewController *)splashVC withWindow:(UIWindow *)window;
+ (void)hideSplashVC;

@end
