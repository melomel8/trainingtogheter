//
//  ProgramSelectViewController.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 27/04/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import "ProgramSelectViewController.h"
#import "LevelSelectViewController.h"
#define IMAGE_VIEW_TAG 1
#define LABEL_TAG 2

@interface ProgramSelectViewController ()

@end

@implementation ProgramSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    programsArray = [NSArray arrayWithObjects:@"Core Stability",@"Metabolic Training", nil];
    programsPhotoArray = [NSArray arrayWithObjects:@"01 basic.png",@"02 easy.png", nil];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {   // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:NSLocalizedString(@"selectYourProgramTitle", @"Select Your Program")];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return programsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CELL_IDENTIFIER = @"CellIdentifier";
    
    UITableViewCell* theCell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    if (!theCell)
    {
        //TODO rendere generico lo switch della cella tra iphone e Ipad p
        NSString* deviceModel = [UIDevice currentDevice].model;
        
        if ([deviceModel containsString:@"iPad"])
            [[NSBundle mainBundle] loadNibNamed:@"DifficultyCell_iPad" owner:self options:NULL];
        else
            [[NSBundle mainBundle] loadNibNamed:@"DifficultyCell" owner:self options:NULL];
        
        
        theCell = levelCell;
    }
    
    //prendo i "campi" della cella
    UIImageView* programImageView = (UIImageView*)[theCell viewWithTag:IMAGE_VIEW_TAG];
    UILabel* programNameLabel = (UILabel*)[theCell viewWithTag:LABEL_TAG];
    
    //popolo la cella
    NSString* currentProgram = [programsArray objectAtIndex:indexPath.row];
    programNameLabel.text = NSLocalizedString(currentProgram, currentProgram);
    UIImage* programImage = [UIImage imageNamed: [programsPhotoArray objectAtIndex:indexPath.row]];
    
    programImageView.image = programImage;
    
    return theCell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //chiamo la selezione del livello
    //in base al parametro passato,però, la selezione del livello produrrà effetti differenti
    
    LevelSelectViewController* levelSelectVC = [[LevelSelectViewController alloc] initWithNibName:@"LevelSelectViewController" bundle:nil ];
    NSString* _objectToDisplay = @"";
    
    if (indexPath.row == 0)
         _objectToDisplay=@"ESERCIZI";
    
    else if (indexPath.row == 1)
         _objectToDisplay=@"PDF";

    
    if ([_objectToDisplay isEqualToString:@""])
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notExpectedTitle", @"Not Expected View") message:NSLocalizedString(@"notExpectedMessage", @"notExpectedMessage") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
    else
    {
        levelSelectVC.objectToDisplay= _objectToDisplay;
        [self.navigationController pushViewController:levelSelectVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
    
   }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
