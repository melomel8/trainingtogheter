//
//  TimerViewController.m
//  TrainingTogether
//
//  Created by Alessio Melani on 09/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import "TimerViewController.h"
#import <DDHTimerControl/DDHTimerControl.h>

#define TIMER_WIDTH 128

@interface TimerViewController ()
{
    NSTimer*            theTimer;
    DDHTimerControl*    timerControl;
    BOOL                running;
    int                 ticks;
}

- (void)changeTimer:(id)sender;
- (void)timerTapped:(id)sender;
- (void)timerLongPressed:(id)sender;

@end

@implementation TimerViewController
@synthesize duration;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil timeInterval:(int)timeInterval
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        duration = timeInterval;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.142 green:0.149 blue:0.204 alpha:1.000];
    dismissButton.titleLabel.text = NSLocalizedString(@"close", @"Dismiss");
    ticks = 0;
    running = NO;
    
    timerControl = [DDHTimerControl timerControlWithType:DDHTimerTypeSolid];
    timerControl.maxValue = duration;
    timerControl.frame = CGRectMake(self.view.center.x - TIMER_WIDTH, self.view.center.y - TIMER_WIDTH, TIMER_WIDTH * 2, TIMER_WIDTH * 2);
    timerControl.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    timerControl.color = [UIColor orangeColor];
    timerControl.highlightColor = [UIColor redColor];

    timerControl.minutesOrSeconds = duration;
    timerControl.titleLabel.text = @"sec";
    timerControl.userInteractionEnabled = NO;
    [self.view addSubview:timerControl];
    
    UIView* grView = [[UIView alloc] initWithFrame:timerControl.frame];
    grView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [grView setBackgroundColor:[UIColor clearColor]];
    [grView setUserInteractionEnabled:YES];
    
    //tap per lo start e stop
    UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timerTapped:)];
    [grView addGestureRecognizer:tapGR];
    
    //long press per il reset
    UILongPressGestureRecognizer* longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(timerLongPressed:)];
    [grView addGestureRecognizer:longPressGR];
    
    [self.view addSubview:grView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissButtonTapped:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeTimer:(id)sender
{
    ticks += 1;
    timerControl.minutesOrSeconds = duration - ticks;
}

#pragma mark - Gesture Recognizer

- (void)timerTapped:(id)sender
{
    //se il timer sta girando lo fermo, altrimenti lo riattivo
    if (running)
    {
        [theTimer invalidate];
        theTimer = nil;
        running = NO;
    }
    else
    {
        running = YES;
        theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(changeTimer:) userInfo:nil repeats:YES];
    }
}

- (void)timerLongPressed:(id)sender
{
    //resetto il timer
    if (running)
        [self timerTapped:nil];
    ticks = 0;
    timerControl.minutesOrSeconds = duration;
}

@end
