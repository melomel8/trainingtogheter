//
//  ProgramDetailViewController.h
//  TrainingTogether
//
//  Created by Susanna DiMauro on 20/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSInteger   ProgramId;
    NSInteger   DifficultyId;
    NSArray*    progrDetailArray;
    IBOutlet    UITableView*        programDetailTable;
    IBOutlet    UITableViewCell*    programDetailCel;
    //IBOutlet    UIImageView*        programDetailImageView;
    //IBOutlet    UILabel*            programDetailLabelExerciseName;
    //IBOutlet    UILabel*            programDetailLabelRepCharge;
}

@property (nonatomic, assign) NSInteger ProgramId;
@property (nonatomic, assign) NSInteger DifficultyId;

@end
