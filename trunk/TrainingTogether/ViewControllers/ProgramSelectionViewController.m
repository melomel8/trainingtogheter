//
//  ProgramSelectionViewController.m
//  TrainingTogether
//
//  Created by Alessio Melani on 15/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import "ProgramSelectionViewController.h"
#import "ProgramSelectionView.h"
#import "PreviewViewController.h"

@interface ProgramSelectionViewController()<ProgramSelectionDelegate>
{
    ProgramSelectionView*   programSelection;
    CAShapeLayer*           circle;
}

- (void)addProgramSelection;

@end



@implementation ProgramSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [titleLabel setText:NSLocalizedString(@"selectYourProgramTitle", @"Select Your Program")];
    
    programSelection = [[ProgramSelectionView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-RADIUS, CGRectGetMidY(self.view.frame)-RADIUS, 2 *  RADIUS, 2 * RADIUS)];
    [programSelection setAlpha:0.0f];
    programSelection.delegate = self;
    [self.view addSubview:programSelection];
    
    // Set up the shape of the circle
    circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * RADIUS, 2.0 * RADIUS) cornerRadius:RADIUS].CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(CGRectGetMidX(self.view.frame)-RADIUS, CGRectGetMidY(self.view.frame)-RADIUS);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = [UIColor whiteColor].CGColor;
    circle.lineWidth = 2.0f;
    
    // Add to parent layer
    [self.view.layer addSublayer:circle];
    
    // Configure animation
    [CATransaction begin];
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 2.0; // "animate over 2 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //animation callback
    [CATransaction setCompletionBlock:^{
        [self addProgramSelection];
    }];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addProgramSelection
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:2.0f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [programSelection setAlpha:1.0f];
    circle.lineWidth = 0.0f;
    [UIView commitAnimations];
    
}

#pragma mark - ProgramSelectionDelegate

- (void)sectorTapped:(id)sender withSector:(kSector)theSector
{
    PreviewViewController* previewViewController = [[PreviewViewController alloc] initWithNibName:@"PreviewViewController" bundle:nil];
    [self.navigationController pushViewController:previewViewController animated:YES];
    
}

@end
