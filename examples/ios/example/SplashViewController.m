//
//  SplashViewController.m

//
//  Created by Jason Liang on 3/29/18.
//

#import "SplashViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface SplashViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) int wordIndex;
@end

@implementation SplashViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.gradientLayer = [[CAGradientLayer alloc] init];
  UIColor *color1 = [[UIColor alloc] initWithRed:159.0/255.0 green:63.0/255.0 blue:233.0/255.0 alpha:1];
  UIColor *color2 = [[UIColor alloc] initWithRed:99.0/255.0 green:20.0/255.0 blue:179.0/255.0 alpha:1];
  self.gradientLayer.colors = @[(id)color1.CGColor, (id)color2.CGColor];
  [self.view.layer insertSublayer:self.gradientLayer below:self.logoImageView.layer];
  [UIView animateWithDuration:0.5f
                        delay:0.0f
                      options: (UIViewAnimationOptionRepeat |
                                UIViewAnimationOptionAutoreverse |
                                UIViewAnimationOptionBeginFromCurrentState)
                   animations: ^(void){self.logoImageView.alpha = 0.6;}
                   completion:NULL];
  [self startLoadingWords];
}

- (void)updateToNextIndex {
  NSArray *words =
  @[
    @"loading...",
    @"assembling bunnies...",
    @"the bits are breeding",
    @"while the little elves draw your map",
    @"a few bits tried to escape, but we caught them",
    @"checking the gravitational constant in your locale",
    @"go ahead -- hold your breath",
    @"at least you’re not on hold",
    @"hum something loud while others stare",
    @"we love you just the way you are",
    @"we’re testing your patience",
    @"as if you had any other choice",
    @"don’t think of purple hippos",
    @"while the satellite moves into position",
    @"the bits are flowing slowly today",
    @"it’s still faster than you could draw it",
    @"are we there yet?",
    @"HELP!, I’m being held hostage, and forced to write the stupid lines!",
    @"behind you! Ha, ha, gotcha!",
    @"working... So, how are you?",
    @"prepare for awesomeness!",
    @"QUIET !!! I’m trying to think here",
    @"don’t panic",
    @"so, do you come here often?",
    @"creating Time-Loop Inversion Field",
    @"rewinding the VHS...",
    @"performing magic...",
    @"i just wanna look good for you, good for you",
    @"applying my makeup"
    ];
  self.loadingLabel.text = NSLocalizedString(words[self.wordIndex], nil);
  self.wordIndex = (int)arc4random_uniform((int)words.count);
}

- (void)startLoadingWords {
  [self.timer invalidate];
  __weak SplashViewController *weakSelf = self;
  self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
    if ([timer isValid]) {
      [weakSelf updateToNextIndex];
    }
  }];
  [self.timer fire];
}

- (void)viewDidLayoutSubviews {
  self.gradientLayer.frame = self.view.bounds;
}

#pragma mark - RNSplashScreenVCDelegate
- (void)stopLoading {
  [self.timer invalidate];
  self.timer = nil;
}

@end
