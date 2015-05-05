//
//  LevelSelectViewController.h
//  TrainingTogether
//
//  Created by Alessio Melani on 19/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelSelectViewController : GeneralViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet    UITableView*        levelTable;
    IBOutlet    UITableViewCell*    levelCell;
                NSArray*            difficultiesArray;
                NSString*           objectToDisplay;    //per capire se andranno visualizzati i pdf o l'elenco degli esercizi
}

@property (nonatomic, retain) NSString* objectToDisplay;

@end
