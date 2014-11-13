//
//  Exercise.m
//  TrainingTogether
//
//  Created by Alessio Melani on 13/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "Exercise.h"

@implementation Exercise
@synthesize ExerciseId, ExerciseName,ExerciseInstructions;

-(id)initFromResultSet:(FMResultSet *)resultSet;
{
    if ((self = [super init] ))
    {
        ExerciseId = [resultSet intForColumn:@"exerciseId"];
        ExerciseName = [resultSet stringForColumn:@"exerciseName"];
        ExerciseInstructions = [resultSet stringForColumn:@"exerciseInstructions"];
    }
    return self;
}

@end
