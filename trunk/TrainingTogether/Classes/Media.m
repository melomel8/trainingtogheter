//
//  Media.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 01/12/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "Media.h"


@implementation Media

@synthesize mediaId, mediaPath;


-(id)initFromResultSet:(FMResultSet*) resulSet;
{
   if  ((self = [super init]))
    {
        mediaId     = [resulSet intForColumn:@"mediaId"];
        mediaPath   = [resulSet stringForColumn:@"mediaPath"];
    }
    return self;
}

@end
