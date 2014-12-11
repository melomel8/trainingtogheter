//
//  ExerciseDetailViewController.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 27/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "ExerciseDetailViewController.h"
#import "DBManager.h"

#ifndef EXERCISE_DETAIL_VIEW_CONTROLLER_CONSTANTS
#define HEIGHT_IPHONE 150.0f
#define WIDTH_IPHONE 200.0f
#define GAP_IPHONE 60.0f
#define HEIGHT_IPAD 433.0f //325.0f
#define WIDTH_IPAD 576.9f//433.0f
#define GAP_IPAD 95.5f//167.5f
#endif

@interface ExerciseDetailViewController ()

@end

@implementation ExerciseDetailViewController

@synthesize ExerciseId, ExerciseName, ExerciseRepCharge, ExerciseInstructions;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    exerciseArray = [DBManager getMediasForExercise:ExerciseId];
    NSString* deviceModel = [UIDevice currentDevice].model;
    BOOL isIpad = [deviceModel containsString:@"iPad"];
    //TODO controllare che esista almeno una foto?
    int   NUM_PHOTOS    = exerciseArray.count;
    float HEIGHT        = isIpad ? HEIGHT_IPAD : HEIGHT_IPHONE;
    float WIDTH         = isIpad ? WIDTH_IPAD : WIDTH_IPHONE;
    float GAP           = isIpad ? GAP_IPAD : GAP_IPHONE;
    float x             = GAP;
    float Y             = 0;
    
    DLog(@"Num record in exerciseArray: %d ", NUM_PHOTOS);
    
    
    [exerciseImgScrollView setContentSize:CGSizeMake(((WIDTH*NUM_PHOTOS)+(GAP*2*NUM_PHOTOS)), HEIGHT)];
    
    for (int i=0; i<= NUM_PHOTOS-1; i++)
    {
        Media* medias = [[Media alloc] init];
        medias = [exerciseArray objectAtIndex:i];
        UIImage* exerciseImage = [UIImage imageNamed:medias.mediaPath];
        DLog(@"IMG: %@", medias.mediaPath);
        UIImageView* exerciseImageView = [[UIImageView alloc] initWithImage:exerciseImage];
        //se si tratta di un Ipad è permessa la rotazione in orizzontale e devo ridimensionare anche la UIImageView
        if (isIpad)
            exerciseImageView.autoresizingMask= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin ;//| UIViewAutoresizingFlexibleTopMargin ;
        
        [exerciseImageView setFrame:CGRectMake(x, Y, WIDTH, HEIGHT)];
        [exerciseImgScrollView addSubview:exerciseImageView];
        x = x + WIDTH + (2*GAP);
    }
    exerciseImgPageControl.numberOfPages = NUM_PHOTOS;
    exerciseImgPageControl.currentPage = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:NSLocalizedString(@"exerciseDetailTitle", @"Exercise Detail")];
    exerciseNameLabel.text = ExerciseName;
    exerciseRepChargeLabel.text = ExerciseRepCharge;
    exerciseInstructionsTextView.text = ExerciseInstructions;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = exerciseImgScrollView.frame.size.width;
    int page = floor((exerciseImgScrollView.contentOffset.x/pageWidth));
    exerciseImgPageControl.currentPage =page;
}

#pragma mark - Rotation Handling

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [UIView beginAnimations:@"AnimazioneMoltoFiga" context:NULL];
    [UIView setAnimationDuration:0.3f];
    verticalContainer.alpha = 0.0f;
    horizontalContainer.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //controllo quale sia l'orientamento del dispositivo e, sulla base di quello, rendo visibile uno dei due container
    [UIView beginAnimations:@"AnimazioneMoltoFiga" context:NULL];
    [UIView setAnimationDuration:0.3f];
    horizontalContainer.alpha = 1.0f;
    [UIView commitAnimations];
}

@end
