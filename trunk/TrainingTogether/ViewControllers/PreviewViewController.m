//
//  PreviewViewController.m
//  TrainingTogether
//
//  Created by Alessio Melani on 21/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import "PreviewViewController.h"
#import "DBManager.h"
#import "LevelSelectViewController.h"

#define ANIMATION_KEY_OBSCURE_IMAGES @"ObscureImages"
#define ANIMATION_KEY_SHOW_IMAGES @"ShowImages"

#define TIMER_INTERVAL 2.0f
#define ANIMATION_DURATION 0.7f

@interface PreviewViewController ()
{
    NSArray* medias;
    int currentIndex;
    NSTimer* timer;
}

- (void)timerTick:(id)sender;
- (void)animationDidStop:(NSString*)animationName finished:(NSNumber*)finished context:(void*)context;
- (void)imageTapped:(id)sender;

@end

@implementation PreviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    medias = [[NSArray alloc] initWithArray:[DBManager getAllMediasFromProgram:-1]];
    currentIndex = 0;
    
    //istanzio le prime due immagini e faccio partire il timer per lo slideshow
    Media* firstMedia = [medias objectAtIndex:0];
    
    
    NSArray* resComponents = [firstMedia.mediaPath componentsSeparatedByString:@"."];
    NSString* resType = [resComponents objectAtIndex:resComponents.count-1];
    NSString* resName = [[firstMedia.mediaPath componentsSeparatedByString:[NSString stringWithFormat:@".%@", resType]] objectAtIndex:0];
    UIImage* firstImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:resName ofType:resType]];
    
    //TODO: cancellare dopo test
    //UIImage* firstImage = [UIImage imageNamed:firstMedia.mediaPath];
    
    [frontImageView setImage:firstImage];
    
    [frontImageView setAlpha:1.0f];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(timerTick:) userInfo:nil repeats:NO];
    
    UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    [frontImageView addGestureRecognizer:tapGR];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerTick:(id)sender
{
    [UIView beginAnimations:ANIMATION_KEY_OBSCURE_IMAGES context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    [frontImageView setAlpha:0.0f];
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString *)animationName finished:(NSNumber *)finished context:(void *)context
{
    if ([animationName isEqualToString:ANIMATION_KEY_OBSCURE_IMAGES])
    {
        currentIndex += 1;
        if (currentIndex == medias.count)
            currentIndex = 0;
        Media* firstMedia = [medias objectAtIndex:currentIndex];
        
        NSArray* resComponents = [firstMedia.mediaPath componentsSeparatedByString:@"."];
        NSString* resType = [resComponents objectAtIndex:resComponents.count-1];
        NSString* resName = [[firstMedia.mediaPath componentsSeparatedByString:[NSString stringWithFormat:@".%@", resType]] objectAtIndex:0];
        UIImage* firstImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:resName ofType:resType]];
        
        //TODO: cancellare dopo test_-
        //UIImage* firstImage = [UIImage imageNamed:firstMedia.mediaPath];
        
        [frontImageView setImage:firstImage];
        
        [UIView beginAnimations:ANIMATION_KEY_SHOW_IMAGES context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationDuration:ANIMATION_DURATION];
        [frontImageView setAlpha:1.0f];
        [UIView commitAnimations];
    }
    else if ([animationName isEqualToString:ANIMATION_KEY_SHOW_IMAGES])
        timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(timerTick:) userInfo:nil repeats:NO];
}

- (void)imageTapped:(id)sender
{
    LevelSelectViewController* levelSelect = [[LevelSelectViewController alloc] initWithNibName:@"LevelSelectViewController" bundle:nil];
    
    NSMutableArray* viewControllers = [self.navigationController.viewControllers mutableCopy];
    int index = -1;
    for (UIViewController* vc in viewControllers)
    {
        if ([vc isKindOfClass:[PreviewViewController class]])
        {
            index = [viewControllers indexOfObject:vc];
            break;
        }
    }
    
    if (index != -1)
        [viewControllers replaceObjectAtIndex:index withObject:levelSelect];
    else
        [viewControllers addObject:levelSelect];
    
    [self.navigationController setViewControllers:viewControllers animated:YES];
}

@end
