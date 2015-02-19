//
//  ProgramDetailViewController.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 20/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "ProgramDetailViewController.h"
#import "DBManager.h"
#import "ExerciseDetailViewController.h"

#define IMAGE_VIEW_TAG 1
#define LABEL_EXERCISE_NAME_TAG 2
#define LABEL_REP_CHARGE 3

@interface ProgramDetailViewController ()

@end

@implementation ProgramDetailViewController

@synthesize ProgramId, DifficultyId;

- (void)viewDidLoad {
    [super viewDidLoad];
    progrDetailArray = [DBManager getTraningsForDifficultiId:DifficultyId selectedProgram:ProgramId];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:NSLocalizedString(@"programDetailTitle",@"Program Detail")];
    
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
    return progrDetailArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CELL_IDENTIFIER = @"CellIdentifier";   //creo una costante con il nome della coda delle celle da riutilizzare
    UITableViewCell* progDetailCell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER]; //chiedo al tableView se ci sono celle da poter riutilizzare
    if (!progDetailCell) //se non ci sono celle disponibili
    {
        NSString* deviceModel = [UIDevice currentDevice].model;
        
        //creo una cella caricando lo xib nel mainbundle dell'applicazione
        if ([deviceModel containsString:@"iPad"])
        
           [[NSBundle mainBundle] loadNibNamed:@"ProgramDetailCell_iPad" owner:self options:NULL];
        else
            [[NSBundle mainBundle] loadNibNamed:@"ProgramDetailCell" owner:self options:NULL]; 
        
        progDetailCell = programDetailCel; //associo alla cella la variabile legata all'interfaccia grafica
    }
    
    //associo elementi grafici con quelli appena creati tramite il tag
    UIImageView* programDetailImageView = (UIImageView*) [progDetailCell viewWithTag:IMAGE_VIEW_TAG];
    UILabel* programDetailLabelExerciseName = (UILabel*) [progDetailCell viewWithTag:LABEL_EXERCISE_NAME_TAG];
    UILabel* programDetailLabelRepCharge = (UILabel*) [progDetailCell viewWithTag:LABEL_REP_CHARGE];
    
    //popolo la cella
    Training* currentTraining = [progrDetailArray objectAtIndex:indexPath.row];
    programDetailLabelExerciseName.text= NSLocalizedString(currentTraining.exercise.ExerciseName, currentTraining.exerciseName);
    programDetailLabelRepCharge.text= [NSString stringWithFormat:@"%@: %dx%d\" r.%d\" - %@: %d\"", NSLocalizedString(@"normal", @"Normal"), (int)currentTraining.numberOfSeries, (int)currentTraining.repetitions, (int)currentTraining.pauseSeconds, NSLocalizedString(@"circuit", @"circuit"), (int)currentTraining.circuitRepetitions];
    
    NSArray* resComponents = [currentTraining.mediaPath componentsSeparatedByString:@"."];
    NSString* resType = [resComponents objectAtIndex:resComponents.count-1];
    NSString* resName = [[currentTraining.mediaPath componentsSeparatedByString:[NSString stringWithFormat:@".%@", resType]] objectAtIndex:0];
    UIImage* progDetailImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:resName ofType:resType]];
    
    //TODO: cancellare dopo test
    //UIImage* progDetailImage = [UIImage imageNamed:currentTraining.mediaPath];
    DLog(@"***CARICO NOME FOTO: %@ ***",currentTraining.mediaPath);
    programDetailImageView.image = progDetailImage;
    
    
    return progDetailCell;
    
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Training* t = [progrDetailArray objectAtIndex:indexPath.row];
    ExerciseDetailViewController* exerciseVC = [[ExerciseDetailViewController alloc] initWithNibName:@"ExerciseDetailViewController" bundle:nil];
    exerciseVC.ExerciseId = t.exerciseId;
    exerciseVC.ExerciseName = NSLocalizedString(t.exercise.ExerciseName, t.exercise.ExerciseName);
    exerciseVC.ExerciseRepCharge = [NSString stringWithFormat:@"%@: %dx%d\" r.%d\" - %@: %d\"", NSLocalizedString(@"normal", @"Normal"), (int)t.numberOfSeries, (int)t.repetitions, (int)t.pauseSeconds, NSLocalizedString(@"circuit", @"circuit"), (int)t.circuitRepetitions];
    exerciseVC.ExerciseInstructions = NSLocalizedString(t.exercise.ExerciseInstructions, t.exercise.ExerciseInstructions);
    exerciseVC.NormalCharge = t.repetitions;
    exerciseVC.CircuitCharge = t.circuitRepetitions;
    exerciseVC.Recovery = t.pauseSeconds;
    exerciseVC.CircuitRecovery = t.circuitPauseSeconds;
    DLog(@"ID_ESERCIZIO: %d ", t.exerciseId);
    DLog(@"NOME_ESERCIZIO: %@ ", t.exercise.ExerciseName);
    DLog(@"REP_CHARGE: %@ ", exerciseVC.ExerciseRepCharge);
    DLog(@"REP_CHARGE: %@ ", exerciseVC.ExerciseInstructions);
    
    [self.navigationController pushViewController:exerciseVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
