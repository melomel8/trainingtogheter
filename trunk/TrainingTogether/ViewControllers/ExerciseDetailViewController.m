//
//  ExerciseDetailViewController.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 27/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "ExerciseDetailViewController.h"
#import "DBManager.h"
#import "ZoomableView.h"
#import "TimerViewController.h"
#import "UIBAlertView.h"

#ifndef EXERCISE_DETAIL_VIEW_CONTROLLER_CONSTANTS
#define HEIGHT_IPHONE 150.0f
#define WIDTH_IPHONE 200.0f
#define GAP_IPHONE 60.0f

#define HEIGHT_IPAD 433.0f
#define WIDTH_IPAD 576.9f
#define GAP_IPAD 95.5f

#define HEIGHT_IPAD_HORIZ 373.0f
#define WIDTH_IPAD_HORIZ  497.0f
#define GAP_IPAD_HORIZ 0.0f

#define ZOOM_VIEW_MARGIN 30.0f
#endif

@interface ExerciseDetailViewController ()

- (void)drawView;
- (void)imageTapped:(UITapGestureRecognizer*)sender;
- (void)notImageTapped:(UITapGestureRecognizer*)sender;
- (void)animationEnded;

@end

@implementation ExerciseDetailViewController

ZoomableView* zommedView;

@synthesize ExerciseId, ExerciseName, ExerciseRepCharge, ExerciseInstructions, NormalCharge, CircuitCharge, Recovery, CircuitRecovery;

- (void)viewDidLoad {
    [super viewDidLoad];
    exerciseArray = [DBManager getMediasForExercise:ExerciseId];
    int NUM_PHOTOS = exerciseArray.count;
    [self drawView];
    exerciseImgPageControl.numberOfPages = NUM_PHOTOS;
    exerciseImgPageControl.currentPage = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationItem setTitle:NSLocalizedString(@"exerciseDetailTitle", @"Exercise Detail")];
    exerciseNameLabel.text = ExerciseName;
    exerciseRepChargeLabel.text = ExerciseRepCharge;
    exerciseInstructionsTextView.text = NSLocalizedString(ExerciseInstructions, ExerciseInstructions);
    
}

#pragma mark - Mie Procedure
- (void)drawView
{
    NSString* deviceModel = [UIDevice currentDevice].model;
    BOOL isIpad = [deviceModel containsString:@"iPad"];
    //TODO controllare che esista almeno una foto?
    int NUM_PHOTOS = exerciseArray.count;
    float HEIGHT, WIDTH, GAP, x, y;
    
    if (isIpad)
    {
        UIInterfaceOrientation myAppOrientation =   [[UIApplication sharedApplication ] statusBarOrientation];
        if ((myAppOrientation == UIDeviceOrientationPortrait) || (myAppOrientation== UIDeviceOrientationPortraitUpsideDown))
        {
            HEIGHT = HEIGHT_IPAD;
            WIDTH = WIDTH_IPAD;
            GAP = GAP_IPAD;
            x = GAP;
            y = 0;
            
            //TITOLO
            [exerciseNameLabel setFrame: CGRectMake(12,74,663,72)];
            [exerciseNameLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:24.0f]];
            
            //PULSANTE CRONOMETRO
            [chronoButton setFrame:CGRectMake(688, 74, 70, 70)];
            
            //CARICO/PAUSA
            [exerciseRepChargeLabel setFrame: CGRectMake(81,662,606,21)];
            [exerciseRepChargeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:19.0f]];
            
            //ISTRUZIONI
            [exerciseInstructionsTextView setFrame: CGRectMake(81,725,606,291)];
            [exerciseInstructionsTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
            
            //SCROLLVIEW
            [exerciseImgScrollView setFrame: CGRectMake(0,161,768,433)];
            
            //PAGECONTROL
            [exerciseImgPageControl setFrame: CGRectMake(365,597,56,37)];
        }
        else // non è in verticale
        {
            HEIGHT = HEIGHT_IPAD_HORIZ;
            WIDTH = WIDTH_IPAD_HORIZ;
            GAP = GAP_IPAD_HORIZ;
            x = GAP;
            y = 0;
            
            //TITOLO
            [exerciseNameLabel setFrame: CGRectMake(54, 111, 834, 72)];
            [exerciseNameLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:(29.0f)]];
            
            //PULSANTE CRONOMETRO
            [chronoButton setFrame:CGRectMake(901, 111, 70, 70)];
            
            //CARICO/PAUSA
            [exerciseRepChargeLabel setFrame: CGRectMake(583,247,390,30)];
            [exerciseRepChargeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:(21.0f)]];
            
            //ISTRUZIONI
            [exerciseInstructionsTextView setFrame: CGRectMake(583,303,390,317)];
            [exerciseInstructionsTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:(19.0f)]];
            
            //SCROLLVIEW
            [exerciseImgScrollView setFrame: CGRectMake(45,247,497,373)];
            
            //PAGECONTROL
            [exerciseImgPageControl setFrame: CGRectMake(276,619,39,37)];
        }
    }
    else //non è un Ipad
    {
        HEIGHT = HEIGHT_IPHONE;
        WIDTH = WIDTH_IPHONE;
        GAP = GAP_IPHONE;
        x = GAP;
        y = 0;
        
        //TITOLO
        [exerciseNameLabel setFrame: CGRectMake(8,66,265,56)];
        [exerciseNameLabel setFont:[UIFont fontWithName:@"ArialRoundedMTBold" size:(18.0f)]];
        
        //CARICO/PAUSA
        [exerciseRepChargeLabel setFrame: CGRectMake(0,314,self.view.frame.size.width,21)];
        [exerciseRepChargeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:(18.0f)]];
        
        //ISTRUZIONI
        [exerciseInstructionsTextView setFrame: CGRectMake(24,341,272,212)];
        [exerciseInstructionsTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:(14.0f)]];
        
        //SCROLLVIEW
        [exerciseImgScrollView setFrame: CGRectMake(0,127,self.view.frame.size.width,150)];
        
        //PAGECONTROL
        [exerciseImgPageControl setFrame: CGRectMake(132,278,56,37)];
        
    }
    
    DLog(@"Num record in exerciseArray: %d ", NUM_PHOTOS);
    
    [exerciseImgScrollView setContentSize:CGSizeMake(((WIDTH*NUM_PHOTOS)+(GAP*2*NUM_PHOTOS)), HEIGHT)];
    
    [exerciseImgScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    for (int i=0; i<= NUM_PHOTOS-1; i++)
    {
        Media* medias = [[Media alloc] init];
        medias = [exerciseArray objectAtIndex:i];
        UIImage* exerciseImage = [UIImage imageNamed:medias.mediaPath];
        DLog(@"IMG: %@", medias.mediaPath);
        UIImageView* exerciseImageView = [[UIImageView alloc] initWithImage:exerciseImage];
        [exerciseImageView setFrame:CGRectMake(x, y, WIDTH, HEIGHT)];
        [exerciseImageView setUserInteractionEnabled:YES];
        [exerciseImageView setContentMode:UIViewContentModeScaleAspectFit];
        [exerciseImgScrollView addSubview:exerciseImageView];
        x = x + WIDTH + (2*GAP);
        
        //Aggiungo il TapGR per il tap dell'immagine
        UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        [exerciseImageView addGestureRecognizer:tapGR];
    }
    
    //Mi posiziono alla foto eventualmente selezionata in un altro orientamento
    int page = exerciseImgPageControl.currentPage;
    [exerciseImgScrollView setContentOffset:CGPointMake((exerciseImgScrollView.frame.size.width*page), y) animated:NO];
    
}

- (void)imageTapped:(UITapGestureRecognizer*)sender
{
    DLog(@"***HO TAPPATOOOO!!!***");
    if (zommedView == nil)
    {
        UIImageView* tappedView = (UIImageView*)sender.view;
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
        CGFloat viewY = self.view.frame.origin.y + ZOOM_VIEW_MARGIN + statusBarHeight;
        DLog(@"viewY è %f", viewY);
        zommedView = [[ZoomableView alloc] initWithImage:tappedView.image andFrame:CGRectMake((self.view.frame.origin.x + ZOOM_VIEW_MARGIN), (self.view.frame.origin.y + ZOOM_VIEW_MARGIN + statusBarHeight + navigationBarHeight), (self.view.frame.size.width - (2*ZOOM_VIEW_MARGIN)), (self.view.frame.size.height - (2*ZOOM_VIEW_MARGIN+statusBarHeight + navigationBarHeight)))];
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.view addSubview:zommedView];
        [zommedView setAlpha:0.0];
        //Aggiungo il TapGR per riconoscere il tap fuori dalla foto tappata
        UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(notImageTapped:)];
        [self.view addGestureRecognizer:tapGR];
        
        [UIView beginAnimations:@"AnimazioneAperturaView" context:NULL];
        [UIView setAnimationDuration:0.4f];
        [zommedView setAlpha:1.0];
        [viewGray setAlpha:0.8];
        [viewGrayIpad setAlpha:0.8];
        [UIView commitAnimations];
    }
}

-(void)notImageTapped:(UITapGestureRecognizer *)sender
{
    if (zommedView.alpha == 1)
    {
        DLog(@"***HO tappato fuori dalla foto***");
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [UIView beginAnimations:@"AnimazioneChiusuraView" context:NULL];
        [UIView setAnimationDuration:0.4f];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationEnded)];
        [zommedView setAlpha:0.0f];
        [viewGray setAlpha:0];
        [viewGrayIpad setAlpha:0];
        [UIView commitAnimations];
    }
}

- (void)animationEnded
{
    [zommedView removeFromSuperview];
    zommedView = nil;
    [self.view removeGestureRecognizer:[self.view.gestureRecognizers objectAtIndex:0]];
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
    viewContainer.alpha = 0.0f;
    [UIView commitAnimations];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self drawView];
    
    [UIView beginAnimations:@"AnimazioneMoltoFiga" context:NULL];
    [UIView setAnimationDuration:0.3f];
    //self.view.alpha = 1.0f;
    viewContainer.alpha = 1.0f;
    [UIView commitAnimations];
}

#pragma mark - IBAction

- (void)chronoButtonTapped:(id)sender
{
    UIBAlertView* alert = [[UIBAlertView alloc] initWithTitle:NSLocalizedString(@"workType", @"Work Type") message:NSLocalizedString(@"selectWork", @"Select Work") cancelButtonTitle:NSLocalizedString(@"undo", @"Undo") otherButtonTitles:NSLocalizedString(@"normal", @"Normal"), NSLocalizedString(@"circuit", @"Circuit"), NSLocalizedString(@"recovery", @"Recovery"), NSLocalizedString(@"circuitRec", @""), nil];
    [alert showWithDismissHandler:^(NSInteger selectedIndex, NSString *selectedTitle, BOOL didCancel)
    {
        if (didCancel)
        {
            DLog(@"User cancelled");
            return;
        }
        else
        {
            int timeInterval = 0;
            switch (selectedIndex)
            {
                case 1:
                    timeInterval = (int)NormalCharge;
                    break;
                case 2:
                    timeInterval = (int)CircuitCharge;
                    break;
                case 3:
                    timeInterval = (int)Recovery;
                    break;
                case 4:
                    timeInterval = (int)CircuitRecovery;
                    break;
                default:
                    break;
            }
            TimerViewController* timerViewController = [[TimerViewController alloc] initWithNibName:@"TimerViewController" bundle:nil timeInterval:timeInterval];
            [self presentViewController:timerViewController animated:YES completion:nil];
        }
    }];
}

@end
