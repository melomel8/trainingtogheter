//
//  LevelSelectViewController.h
//  TrainingTogether
//
//  Created by Alessio Melani on 19/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelSelectViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet    UITableView*        levelTable;
                NSArray*            difficultiesArray;
}



@end
