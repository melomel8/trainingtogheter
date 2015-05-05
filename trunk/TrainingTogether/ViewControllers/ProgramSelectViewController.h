//
//  ProgramSelectViewController.h
//  TrainingTogether
//
//  Created by Susanna DiMauro on 27/04/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgramSelectViewController : GeneralViewController <UITableViewDataSource, UITableViewDelegate> 
{
    IBOutlet    UITableView*        programTable;
    IBOutlet    UITableViewCell*    levelCell;
                NSArray*            programsArray;
                NSArray*            programsPhotoArray;
    
}

@end
