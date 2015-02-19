//
//  LevelSelectViewController.m
//  TrainingTogether
//
//  Created by Alessio Melani on 19/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "LevelSelectViewController.h"
#import "DBManager.h"
#import "ProgramDetailViewController.h"

#define IMAGE_VIEW_TAG 1
#define LABEL_TAG 2
#define TUTORIAL @"Tutorial"
#define PLANNING @"Planning"
#define TABLE @"Table"

@interface LevelSelectViewController ()<UIActionSheetDelegate, UIDocumentInteractionControllerDelegate>

- (void)navigationBarRightButtonTapped:(id)sender;

@end

@implementation LevelSelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    difficultiesArray = [DBManager getAllDifficulty];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {   // if iOS 7
        self.edgesForExtendedLayout = UIRectEdgeNone; //layout adjustements
    }
    
    //aggiungo il pulsante di action sulla barra
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(navigationBarRightButtonTapped:)];
    [self.navigationItem setRightBarButtonItem:rightButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:NSLocalizedString(@"levelSelectionTitle", @"Select Your Level")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navigationBarRightButtonTapped:(id)sender
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"help", @"Help") delegate:self cancelButtonTitle:NSLocalizedString(@"close", @"Close") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"tutorial", @"Tutorial"), NSLocalizedString(@"trainingPlanning", @"Training Planning"), NSLocalizedString(@"exerciseTable", @"Exercise Table"), nil];
    [actionSheet showInView:self.view];
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
        //TODO rendere generico lo switch della cella tra iphone e Ipad p
        NSString* deviceModel = [UIDevice currentDevice].model;
        
        if ([deviceModel containsString:@"iPad"])
        
            [[NSBundle mainBundle] loadNibNamed:@"DifficultyCell_iPad" owner:self options:NULL];
        else
            [[NSBundle mainBundle] loadNibNamed:@"DifficultyCell" owner:self options:NULL];
        
        
        theCell = levelCell;
    }
    
    //prendo i "campi" della cella
    UIImageView* levelImageView = (UIImageView*)[theCell viewWithTag:IMAGE_VIEW_TAG];
    UILabel* levelNameLabel = (UILabel*)[theCell viewWithTag:LABEL_TAG];
    
    //popolo la cella
    Difficulty* currentDifficulty = [difficultiesArray objectAtIndex:indexPath.row];
    levelNameLabel.text = NSLocalizedString(currentDifficulty.DifficultyName, currentDifficulty.DifficultyName);
    UIImage* levelImage = [UIImage imageNamed:currentDifficulty.DifficultyImageName];
    
    levelImageView.image = levelImage;
    
    return theCell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Difficulty* d = [difficultiesArray objectAtIndex:indexPath.row];
    NSInteger difficultyId = d.DifficultyId;
    NSInteger programId = [DBManager getProgramIdForDifficultyId:difficultyId];
    if (programId != -1)
    {
        ProgramDetailViewController* programDetailVC = [[ProgramDetailViewController alloc] initWithNibName:@"ProgramDetailViewController" bundle:nil];
        programDetailVC.DifficultyId = difficultyId;
        programDetailVC.ProgramId = programId;
        [self.navigationController pushViewController:programDetailVC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    else
    {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"noProgramsTitle", @"No Programs") message:NSLocalizedString(@"noProgramsMessage", @"noProgramsMessage") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString* buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSString* resourceName = @"";
    if ([buttonTitle isEqualToString:NSLocalizedString(@"tutorial", @"Tutorial")])
        resourceName = TUTORIAL;
    else if ([buttonTitle isEqualToString:NSLocalizedString(@"trainingPlanning", @"Training Planning")])
        resourceName = PLANNING;
    else
        resourceName = TABLE;
    
    NSURL* url = [[NSBundle mainBundle] URLForResource:resourceName withExtension:@"pdf"];
    UIDocumentInteractionController* docPreview = [UIDocumentInteractionController interactionControllerWithURL:url];
    [docPreview setDelegate:self];
    [docPreview presentPreviewAnimated:YES];
    
}

#pragma mark - UIDocumentInteraction Delegate

- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

@end
