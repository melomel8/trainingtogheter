//
//  ProgramSelectionViewController.h
//  TrainingTogether
//
//  Created by Alessio Melani on 15/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramSelectionViewController : GeneralViewController
{
    IBOutlet    UILabel*    titleLabel;
    IBOutlet    UIView*     container;
    IBOutlet    UIButton*   helpButton;
}

- (IBAction)helpButtonTapped:(id)sender;

@end
