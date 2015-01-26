//
//  ExerciseDetailViewController.h
//  TrainingTogether
//
//  Created by Susanna DiMauro on 27/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseDetailViewController : GeneralViewController <UIScrollViewDelegate>
{
    NSInteger   ExerciseId;
    NSString*   ExerciseName;
    NSString*   ExerciseRepCharge;
    NSInteger   NormalCharge;
    NSInteger   CircuitCharge;
    NSInteger   Recovery;
    NSInteger   CircuitRecovery;
    NSString*   ExerciseInstructions;
    NSArray*    exerciseArray;
    
    IBOutlet    UIView*         viewContainer;
    IBOutlet    UILabel*        exerciseNameLabel;
    IBOutlet    UIButton*       chronoButton;
    IBOutlet    UIScrollView*   exerciseImgScrollView;
    IBOutlet    UIPageControl*  exerciseImgPageControl;
    IBOutlet    UILabel*        exerciseRepChargeLabel;
    IBOutlet    UITextView*     exerciseInstructionsTextView;
    IBOutlet    UIView*         viewGray;
    IBOutlet    UIView*         viewGrayIpad;
    
}

@property (nonatomic, assign) NSInteger ExerciseId;
@property (nonatomic, retain) NSString* ExerciseName;
@property (nonatomic, retain) NSString* ExerciseRepCharge;
@property (nonatomic, retain) NSString* ExerciseInstructions;
@property (nonatomic, assign) NSInteger NormalCharge;
@property (nonatomic, assign) NSInteger CircuitCharge;
@property (nonatomic, assign) NSInteger CircuitRecovery;
@property (nonatomic, assign) NSInteger Recovery;

- (IBAction)chronoButtonTapped:(id)sender;

@end
