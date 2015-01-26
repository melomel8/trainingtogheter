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
        DLog(@"EXECUTING QUERY: %@", query);
        
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


+(NSInteger)getProgramIdForDifficultyId:(NSInteger)difficultyId;
{
    FMDatabase* db= [DBUtil instance];
    NSInteger   progrId = -1;
    NSInteger rowCount = 0;
    if (db)
    {
        NSString* query=[NSString stringWithFormat:  @"SELECT DISTINCT t.programId FROM tbTrainings t WHERE t.difficultyId=%d", difficultyId];
        DLog(@"EXECUTING 'getProgramIdForDifficultyId:(NSInteger)difficultyId' --> QUERY: %@", query);
        FMResultSet* rs= [db executeQuery:query];
        
        //TODO: da verificare se il metodo sottostante torna il numero di risultati
        //int rc = [rs.resultDictionary allKeys].count;
        
        while ([rs next])
        {
            progrId = [rs intForColumn:@"ProgramId"];
            rowCount += 1;
        }
        [db close];
    }
    
    DLog(@"rowCount= %d" , rowCount);
        
    if (rowCount == 1)
    {
        DLog(@"progriD= %d", progrId);
        return progrId;
    }
        
    else if ((rowCount >1))
    {
        DLog(@"ERRORE! Sono presenti più programmi per il difficultyId: %d", difficultyId);
        [NSException raise:@"InvalidArgumentException" format:@"Too many programs for provided difficulty"];
        return -1; //un errore bloccante ci potrebbe stare..
    }
        
    else
    {
        DLog(@"ERRORE! Non sono presenti programmi per questo difficultyId: %d", difficultyId);
        return -1;
    }
    
}

+(NSArray*)getTraningsForDifficultiId:(NSInteger)difficultyId selectedProgram: (NSInteger)programId;
{
    FMDatabase* db = [DBUtil instance];
    NSMutableArray* resultArray = [NSMutableArray array]; //ritorna un array vuoto
    if (db)
    {
        NSString* query = [NSString stringWithFormat:@"SELECT t.programId, t.difficultyId, t.exerciseId, t.numberOfSeries, t.repetitions, t.charge, t.circuitRepetitions, "
                                                             "t.pauseSeconds, t.circuitPauseSeconds, e.exerciseName, e.exerciseInstructions, min(m.mediapath) as mediapath "
                                                        "FROM tbTrainings t JOIN tbExercises e ON t.exerciseId = e.exerciseId "
                                                              "JOIN tbMediaExercise me ON t.exerciseId = me.exerciseId "
                                                              "JOIN tbMedias m ON m.mediaId = me.mediaId "
                                                       "WHERE t.difficultyId = %d "
                                                         "AND t.programId = %d "
                                                         "AND m.isVideo = 0 "
                                                       "group by t.programId, t.difficultyId, t.exerciseId, t.numberOfSeries, t.repetitions, t.charge, "
                                                                "t.pauseSeconds, e.exerciseName, e.exerciseInstructions",difficultyId,programId];
        
        DLog(@"EXECUTING 'getTraningsForDifficultiId:(NSInteger)difficultyId selectedProgram: (NSInteger)programId' --> QUERY: %@", query);
        
        FMResultSet* rs= [db executeQuery:query];
        
        while ([rs next])
        {
            //istanzio i Training
            Training* t = [[Training alloc] initFromResultSet:rs];
            [resultArray addObject:t];
            
        }
        [db close];
    }
    
    return resultArray.count > 0 ? [NSArray arrayWithArray:resultArray] : nil;
}

+(NSArray*)getMediasForExercise:(NSInteger) exerciseId;
{
    FMDatabase* db = [DBUtil instance];
    NSMutableArray* resultArray = [NSMutableArray array];
    if (db)
    {
        NSString* query = [NSString stringWithFormat:@"SELECT m.exerciseId, s.mediaId, s.mediaPath "
                                                        "FROM tbMediaExercise m JOIN tbMedias s "
                                                          "ON m.mediaId = s.mediaId "
                                                       "WHERE isVideo = 0 "
                                                         "AND m.exerciseId = %d",exerciseId];
        DLog(@"EXECUTING 'getMediasForExercise:(NSInteger) exerciseId' --> QUERY: %@", query);
        FMResultSet* rs = [db executeQuery:query];
        while ([rs next])
        {
            Media* m = [[Media alloc] initFromResultSet:rs];
            
            [resultArray addObject:m];
        }
        [db close];
    }

    return resultArray.count >0 ? [NSArray arrayWithArray:resultArray] : nil;
    
}

+(NSArray*)getAllMediasFromProgram:(NSInteger)programId
{
    //TODO: aggiornare la query quando ci saranno più programmi
    FMDatabase* db = [DBUtil instance];
    NSMutableArray* resultArray = [NSMutableArray array];
    if (db)
    {
        NSString* query = [NSString stringWithFormat:@"SELECT m.exerciseId, s.mediaId, s.mediaPath "
                           "FROM tbMediaExercise m JOIN tbMedias s "
                           "ON m.mediaId = s.mediaId "
                           "WHERE isVideo = 0 "];
        FMResultSet* rs = [db executeQuery:query];
        while ([rs next])
        {
            Media* m = [[Media alloc] initFromResultSet:rs];
            
            [resultArray addObject:m];
        }
        [db close];
    }
    
    return resultArray.count >0 ? [NSArray arrayWithArray:resultArray] : nil;
    
}

@end
