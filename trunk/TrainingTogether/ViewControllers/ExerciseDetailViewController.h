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
    NSString*   ExerciseInstructions;
    NSArray*    exerciseArray;
    
    IBOutlet    UIView*         viewContainer;
    IBOutlet    UILabel*        exerciseNameLabel;
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

@end
