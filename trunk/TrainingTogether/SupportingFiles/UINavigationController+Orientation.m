//
//  UINavigationController+Orientation.m
//  TrainingTogether
//
//  Created by Alessio Melani on 23/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import "UINavigationController+Orientation.h"
#import "ProgramSelectionViewController.h"
#import "PreviewViewController.h"

@implementation UINavigationController (Orientation)


- (BOOL)shouldAutorotate
{
    id currentViewController = self.topViewController;
    
    if ([currentViewController isKindOfClass:[ProgramSelectionViewController class]] || [currentViewController isKindOfClass:[PreviewViewController class]])
        return NO;
    else
        return YES;
}

@end
