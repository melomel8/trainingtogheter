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

#pragma mark - UITableViewDelegate


@end
