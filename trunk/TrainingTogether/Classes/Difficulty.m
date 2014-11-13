//
//  Difficulty.m
//  TrainingTogether
//
//  Created by Alessio Melani on 13/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "Difficulty.h"

@implementation Difficulty
@synthesize DifficultyId, DifficultyName, DifficultyNote;

-(id)initFromResultSet:(FMResultSet *)resultSet
{
    if ((self = [super init]))
    {
        DifficultyId = [resultSet intForColumn:@"difficultyId"];
        DifficultyName = [resultSet stringForColumn:@"difficultyName"];
        DifficultyNote = [resultSet stringForColumn:@"difficultyNote"];
    }
    return self;
}

@end
