//
//  LevelSelectViewController.m
//  TrainingTogether
//
//  Created by Alessio Melani on 19/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "LevelSelectViewController.h"
#import "DBManager.h"

@interface LevelSelectViewController ()

@end

@implementation LevelSelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    difficultiesArray = [DBManager getAllDifficulty];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationItem setTitle:NSLocalizedString(@"levelSelectionTitle", @"Select Your Level")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return difficultiesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CELL_IDENTIFIER = @"CellIdentifier";
    
    UITableViewCell* theCell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!theCell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"DifficultyCell" owner:self options:NULL];
        theCell = levelCell;
        //theCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_IDENTIFIER];
    }
    
    //popolo la cella
    Difficulty* currentDifficulty = [difficultiesArray objectAtIndex:indexPath.row];
    levelNameLabel.text = NSLocalizedString(currentDifficulty.DifficultyName, currentDifficulty.DifficultyName);
    
    return theCell;
}

#pragma mark - UITableViewDelegate


@end
