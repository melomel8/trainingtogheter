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
#define HEIGHT_IPAD_HORIZ 433.0f
#define WIDTH_IPAD_HORIZ 576.9f
#define GAP_IPAD_HORIZ 95.5f
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
    

    float HEIGHT, WIDTH, GAP, x, y;
    
    if (isIpad)
    {
        
        UIDeviceOrientation myOrientation = [UIDevice currentDevice].orientation;
        if ((myOrientation == UIDeviceOrientationPortrait) || (myOrientation== UIDeviceOrientationPortraitUpsideDown))
        {
            HEIGHT = HEIGHT_IPAD;
            WIDTH = WIDTH_IPAD;
            GAP = GAP_IPAD;
            x = GAP;
            y = 0;
        }
        else // non è in verticale
        {
            HEIGHT = HEIGHT_IPAD_HORIZ;
            WIDTH = WIDTH_IPAD_HORIZ;
            GAP = GAP_IPAD_HORIZ;
            x = GAP;
            y = 0;
        }
    }
    else //non è un Ipad
    {
        HEIGHT = HEIGHT_IPHONE;
        WIDTH = WIDTH_IPHONE;
        GAP = GAP_IPHONE;
        x = GAP;
        y = 0;
    }
    
    
    DLog(@"Num record in exerciseArray: %d ", NUM_PHOTOS);
    
    [exerciseImgScrollView setContentSize:CGSizeMake(((WIDTH*NUM_PHOTOS)+(GAP*2*NUM_PHOTOS)), HEIGHT)];
    
    for (int i=0; i<= NUM_PHOTOS-1; i++)
    {
        Media* medias = [[Media alloc] init];
        medias = [exerciseArray objectAtIndex:i];
        UIImage* exerciseImage = [UIImage imageNamed:medias.mediaPath];
        DLog(@"IMG: %@", medias.mediaPath);
        UIImageView* exerciseImageView = [[UIImageView alloc] initWithImage:exerciseImage];
      
        [exerciseImageView setFrame:CGRectMake(x, y, WIDTH, HEIGHT)];
        //[horiz_ImageView setFrame:CGRectMake(x, y, WIDTH, HEIGHT)];
        [exerciseImgScrollView addSubview:exerciseImageView];
        //[horiz_exerciseImgScrollView addSubview:horiz_ImageView];
        x = x + WIDTH + (2*GAP); //modificare!!
    }
    exerciseImgPageControl.numberOfPages = NUM_PHOTOS;
    exerciseImgPageControl.currentPage = 0;
    
    //horiz_exerciseImgPageControl.numberOfPages = NUM_PHOTOS;
    //horiz_exerciseImgPageControl.currentPage = 0;
    
    DLog(@"Num di Pagine VERT: %d ", exerciseImgPageControl.numberOfPages);
    //DLog(@"Num di Pagine Horiz: %d ", horiz_exerciseImgPageControl.numberOfPages);
    
    DLog(@"ScrollView VERT- bounds: %d ", exerciseImgScrollView.bounds);
    //DLog(@"ScrollView HORIZ - bounds: %d ", horiz_exerciseImgScrollView.bounds);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:NSLocalizedString(@"exerciseDetailTitle", @"Exercise Detail")];
    exerciseNameLabel.text = ExerciseName;
    exerciseRepChargeLabel.text = ExerciseRepCharge;
    exerciseInstructionsTextView.text = ExerciseInstructions;
    
    //valorizzo le variabili della vista orizzontale
    //horiz_exerciseNameLabel.text = ExerciseName;
    //horiz_exerciseRepChargeLabel.text = ExerciseRepCharge;
    //horiz_exerciseInstructionsTextView.text = ExerciseInstructions;
    
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
    /*verticalContainer.alpha = 0.0f;
    horizontalContainer.alpha = 0.0f;*/
    self.view.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //controllo quale sia l'orientamento del dispositivo e, sulla base di quello, rendo visibile uno dei due container
    NSString* deviceModel = [UIDevice currentDevice].model;
    BOOL isIpad = [deviceModel containsString:@"iPad"];
    
    if (isIpad)
    {
        UIDeviceOrientation myOrientation = [UIDevice currentDevice].orientation;
        if ((myOrientation == UIDeviceOrientationPortrait) || (myOrientation == UIDeviceOrientationPortraitUpsideDown))
        {
            //TITOLO
            [exerciseNameLabel setFrame: CGRectMake(12,74,744,72)];
            [exerciseNameLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:24.0f]];
            
            //CARICO/PAUSA
            [exerciseRepChargeLabel setFrame: CGRectMake(256,662,256,21)];
            [exerciseRepChargeLabel setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:19.0f]];
            
            //ISTRUZIONI
            [exerciseInstructionsTextView setFrame: CGRectMake(81,725,606,291)];
            [exerciseInstructionsTextView setFont:[UIFont fontWithName:@"System" size:18.0f]];
            
            //SCROLLVIEW
            [exerciseImgScrollView setFrame: CGRectMake(0,161,768,433)];
            
            //PAGECONTROL
            [exerciseImgPageControl setFrame: CGRectMake(365,597,56,37)];

            
        }
        else //orizzontale
        {
            //TITOLO
            [exerciseNameLabel setFrame: CGRectMake(54, 111, 917, 72)];
            [exerciseNameLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:29.0f]];
            
            //CARICO/PAUSA
            [exerciseRepChargeLabel setFrame: CGRectMake(779,247,124,30)];
            [exerciseRepChargeLabel setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:21.0f]];
            
            //ISTRUZIONI
            [exerciseInstructionsTextView setFrame: CGRectMake(683,303,316,317)];
            [exerciseInstructionsTextView setFont:[UIFont fontWithName:@"System" size:19.0f]];
            
            //SCROLLVIEW
            [exerciseImgScrollView setFrame: CGRectMake(14,247,654,373)];
            
            //PAGECONTROL
            [exerciseImgPageControl setFrame: CGRectMake(320,619,39,37)];
        }
    }
    else //non è un Ipad
    {
        //TITOLO
        [exerciseNameLabel setFrame: CGRectMake(8,66,304,56)];
        [exerciseNameLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18.0f]];
        
        //CARICO/PAUSA
        [exerciseRepChargeLabel setFrame: CGRectMake(81,314,159,21)];
        [exerciseRepChargeLabel setFont:[UIFont fontWithName:@"Helvetica Neue Bold" size:18.0f]];
        
        //ISTRUZIONI
        [exerciseInstructionsTextView setFrame: CGRectMake(24,341,272,212)];
        [exerciseInstructionsTextView setFont:[UIFont fontWithName:@"System" size:14.0f]];
        
        //SCROLLVIEW
        [exerciseImgScrollView setFrame: CGRectMake(0,127,320,150)];
        
        //PAGECONTROL
        [exerciseImgPageControl setFrame: CGRectMake(132,278,56,37)];
    }
    
    
    [UIView beginAnimations:@"AnimazioneMoltoFiga" context:NULL];
    [UIView setAnimationDuration:0.3f];
    self.view.alpha = 1.0f;
    
    /*if ((myOrientation == UIDeviceOrientationPortrait) || (myOrientation == UIDeviceOrientationPortraitUpsideDown))
        verticalContainer.alpha = 1.0f;
    else
        horizontalContainer.alpha = 1.0f; //proprietà della view: 0 non visibile, 1 completamente visibile
    */
     
    [UIView commitAnimations];
}

@end
