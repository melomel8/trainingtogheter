//
//  Training.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 20/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "Training.h"

@implementation Training
@synthesize programId, difficultyId, exerciseId, numberOfSeries, repetitions, circuitRepetitions, charge, pauseSeconds, circuitPauseSeconds, exercise, mediaPath;

- (id)initFromResultSet:(FMResultSet*)resultSet;
{
    if  ((self = [super init]))
    {
        programId           = [resultSet intForColumn:@"programId"];
        difficultyId        = [resultSet intForColumn:@"difficultyId"];
        exerciseId          = [resultSet intForColumn:@"exerciseId"];
        numberOfSeries      = [resultSet intForColumn:@"numberOfSeries"];
        repetitions         = [resultSet intForColumn:@"repetitions"];
        circuitRepetitions  = [resultSet intForColumn:@"circuitRepetitions"];
        charge              = [resultSet intForColumn:@"charge"];
        pauseSeconds        = [resultSet intForColumn:@"pauseSeconds"];
        circuitPauseSeconds = [resultSet intForColumn:@"circuitPauseSeconds"];
        mediaPath           = [resultSet stringForColumn:@"mediaPath"];
        exercise            = [[Exercise alloc] initFromResultSet:resultSet];
    }
        
    return self;
}

@end
