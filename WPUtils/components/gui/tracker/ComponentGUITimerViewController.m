//
//  ComponentTrackerViewController.m
//  georunning
//
//  Created by William Pompei on 01/10/14.
//  Copyright (c) 2014 William Pompei. All rights reserved.
//

#import "ComponentGUITimerViewController.h"
#import "ComponentTimer.h"
#import "FormattingUtil.h"

@interface ComponentGUITimerViewController (){
   ComponentTimer *timer;
}

@property (weak, nonatomic) IBOutlet UILabel *labelTimer;

@end

@implementation ComponentGUITimerViewController

#pragma mark -

-( void)start{
   timer = [[ComponentTimer alloc] init];
   [timer setupStartTimerBlock:^{
      [self updateTimerString:[FormattingUtil formatTime: 0]];
   }];
   [timer setupStopTimerBlock:^(NSTimeInterval start, NSTimeInterval stop, NSTimeInterval elapsed) {
      [self updateTimerString:[FormattingUtil formatTime: elapsed]];
   }];
   [timer setupRunningTimerBlock:^(NSTimeInterval elapsed) {
      [self updateTimerString:[FormattingUtil formatTime: elapsed]];
   }];
   
   [timer startTimer: 1];
}

-( void)stop{
   [timer stopTimer];
}

#pragma mark -
-( void)updateTimerString:( NSString *)string{
   self.labelTimer.text = string;
}

#pragma mark -
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
   if (self) {
      // Custom initialization
   }
   return self;
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

@end
