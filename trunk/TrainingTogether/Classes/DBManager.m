//
//  DBManager.m
//  TrainingTogether
//
//  Created by Alessio Melani on 19/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+ (NSArray*)getAllDifficulty
{
    FMDatabase* db = [DBUtil instance];
    NSMutableArray* resultArray = [NSMutableArray array];
    if (db)
    {
        NSString* query = @"SELECT * FROM tbDifficulties";
        NSLog(@"EXECUTING QUERY: %@", query);
        
        FMResultSet* rs = [db executeQuery:query];
        while ([rs next])
        {
            //istanzio le varie Difficulty
            Difficulty* d = [[Difficulty alloc] initFromResultSet:rs];
            [resultArray addObject:d];
        }
        [db close];
    }
        
    return resultArray.count > 0 ? [NSArray arrayWithArray:resultArray] : nil;
}

@end
