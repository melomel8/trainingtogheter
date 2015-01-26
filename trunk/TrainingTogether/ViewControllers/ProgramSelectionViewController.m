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

@interface ProgramSelectionViewController()<ProgramSelectionDelegate, UIAlertViewDelegate, UIDocumentInteractionControllerDelegate>
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
    [helpButton setTitle:NSLocalizedString(@"help", @"help") forState:UIControlStateNormal];
    
    programSelection = [[ProgramSelectionView alloc] initWithFrame:CGRectMake(0, 0, container.frame.size.width, container.frame.size.height)];
    
    [programSelection setAlpha:0.0f];
    programSelection.delegate = self;
    [container addSubview:programSelection];
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (programSelection.alpha == 0.0f)
    {
        [programSelection setCenter:CGPointMake(CGRectGetWidth(container.frame) / 2.0f, CGRectGetHeight(container.frame) / 2.0f)];
        CGFloat RADIUS = programSelection.radius;
        // Set up the shape of the circle
        circle = [CAShapeLayer layer];
        // Make a circular shape
        circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0 * RADIUS, 2.0 * RADIUS) cornerRadius:RADIUS].CGPath;
        // Center the shape in self.view
        circle.position = CGPointMake(CGRectGetMidX(container.frame)-RADIUS, CGRectGetMidY(container.frame)-RADIUS);
        
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
}

- (IBAction)helpButtonTapped:(id)sender
{
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"Tutorial" withExtension:@"pdf"];
    UIDocumentInteractionController* docPreview = [UIDocumentInteractionController interactionControllerWithURL:url];
    [docPreview setDelegate:self];
    [docPreview presentPreviewAnimated:YES];
}


#pragma mark - ProgramSelectionDelegate

- (void)sectorTapped:(id)sender withSector:(kSector)theSector isPurchased:(BOOL)isPurchased
{
    if (isPurchased)
    {
        PreviewViewController* previewViewController = [[PreviewViewController alloc] initWithNibName:@"PreviewViewController" bundle:nil];
        [self.navigationController pushViewController:previewViewController animated:YES];
    }
    else
    {
        UIAlertView* purchaseAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"purchaseTitle", @"TITLE") message:NSLocalizedString(@"purchaseMessage", @"Message") delegate:self cancelButtonTitle:NSLocalizedString(@"purchaseNo", @"NO") otherButtonTitles:NSLocalizedString(@"purchaseBuy", @"OK"), NSLocalizedString(@"purchaseRestore", @"RESTORE"), nil];
        [purchaseAlert show];
    }
    
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString* buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:NSLocalizedString(@"purchaseBuy", @"")])
    {
        //purchase item
    }
    else if ([buttonTitle isEqualToString:NSLocalizedString(@"purchaseRestore", @"")])
    {
        //restore purchases
    }
}

#pragma mark - UIDocumentInteraction Delegate

- (UIViewController*)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}

@end
