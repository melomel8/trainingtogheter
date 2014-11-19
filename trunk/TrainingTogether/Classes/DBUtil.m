//
//  DBUtil.m
//  TrainingTogether
//
//  Created by Alessio Melani on 19/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "DBUtil.h"

@implementation DBUtil

static FMDatabase *db;

+ (FMDatabase *)instance
{    
    db = [FMDatabase databaseWithPath:[DBUtil dbPath]];
    if (![db open]) 
    {
        NSLog(@"Error in opening DB");
        return nil;
    }
	return db;
}

+ (NSString *)dbPath
{
    NSArray* searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentFolderPath = [searchPaths objectAtIndex:0];
    return [documentFolderPath stringByAppendingPathComponent:@"storage.sqlite"];
}

@end
