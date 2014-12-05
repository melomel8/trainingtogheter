//
//  GeneralViewController.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 03/12/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "GeneralViewController.h"

@interface GeneralViewController ()

@end

@implementation GeneralViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    //costruisco correttamente il nome del nib
    NSString* deviceModel = [UIDevice currentDevice].model;
    
    //per evitare l'uguaglianza dei puntatori (STRAPERICOLOSA)
    NSString* completeNibName = [NSString stringWithString:nibNameOrNil];
    
    if ([deviceModel containsString:@"iPad"])
        completeNibName = [completeNibName stringByAppendingString:@"_iPad"];
    
    return [super initWithNibName:completeNibName bundle:nibBundleOrNil];
}



@end
