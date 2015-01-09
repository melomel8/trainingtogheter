//
//  TimerViewController.h
//  TrainingTogether
//
//  Created by Alessio Melani on 09/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : GeneralViewController
{
    IBOutlet    UIButton*   dismissButton;
    
    int     duration;
}

@property (nonatomic, assign)   int     duration;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil timeInterval:(int)timeInterval;
- (IBAction)dismissButtonTapped:(id)sender;

@end
