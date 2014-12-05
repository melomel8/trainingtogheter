//
//  Exercise.h
//  TrainingTogether
//
//  Created by Alessio Melani on 13/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

/**
 Classe che gestisce un esercizio
 */
@interface Exercise : NSObject
{
    NSInteger ExerciseId;
    NSString* ExerciseName;
    NSString* ExerciseInstructions;
}

@property (nonatomic, assign) NSInteger ExerciseId;
@property (nonatomic, retain) NSString* ExerciseName;
@property (nonatomic, retain) NSString* ExerciseInstructions;

/*!
 Costruttore che inizializza un Difficulty
 @param resultSet Result Set che contiene i dati di un esercizio
 */
-(id)initFromResultSet:(FMResultSet*)resultSet;

@end

