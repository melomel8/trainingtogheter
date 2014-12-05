//
//  ExerciseDetailViewController.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 27/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "ExerciseDetailViewController.h"
#import "DBManager.h"

@interface ExerciseDetailViewController ()

@end

@implementation ExerciseDetailViewController

@synthesize ExerciseId, ExerciseName, ExerciseRepCharge, ExerciseInstructions;

- (void)viewDidLoad {
    [super viewDidLoad];
    exerciseArray = [DBManager getMediasForExercise:ExerciseId];
    //TODO controllare che esista almeno una foto?
    int   NUM_PHOTOS    = exerciseArray.count;
    float HEIGHT        = 150;
    float WIDTH         = 200;
    float GAP           = 60;
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

@end
