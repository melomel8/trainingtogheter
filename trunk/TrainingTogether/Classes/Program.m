//
//  Programs.m
//  TrainingTogether
//
//  Created by Alessio Melani on 13/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "Program.h"

@implementation Program
@synthesize ProgramId, ProgramName, ThumbPath;

- (id)initFromResultSet:(FMResultSet *)resultSet
{
    if ((self = [super init]))
    {
        ProgramId = [resultSet intForColumn:@"programId"];
        ProgramName = [resultSet stringForColumn:@"programName"];
        ThumbPath = [resultSet stringForColumn:@"thumbPath"];
    }
    return self;
}

@end
