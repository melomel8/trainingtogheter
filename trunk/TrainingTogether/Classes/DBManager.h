//
//  DBManager.h
//  TrainingTogether
//
//  Created by Alessio Melani on 19/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBUtil.h"
#import "Difficulty.h"
#import "Training.h"
#import "Exercise.h"
#import "Media.h"


/* Classe che gestisce le query al db */
@interface DBManager : NSObject
{
    
}

/**
 Ritorna tutte le difficoltà presenti nel DB
 @return NSArray* che contiene oggetti di tipo Difficulty
 */
+ (NSArray*)getAllDifficulty;

/**
 Ritorna tutti gli allenamenti previsti per una certa Difficoltà(difficultyId)
 e un certo programma(programId)
 @return NSArray* che contiene oggetti di tipo Training
 */
+(NSArray*)getTraningsForDifficultiId:(NSInteger)difficultId selectedProgram: (NSInteger)programId;

/**
 Ritorna il programId di una certa difficoltà(difficultyId)
 @return NSInteger contenete il programId
 */
+(NSInteger)getProgramIdForDifficultyId:(NSInteger)difficultyId;


/**
 Ritorna tutti i media diversi da video di un certo exerciseId
 @return NSArray* che contiene oggetti di tipo Media
 */
+(NSArray*)getMediasForExercise:(NSInteger)exerciseId;

/**
 Ritorna tutti i media video di un certo exerciseId
 @return NSArray* che contiene oggetti di tipo Media
 */
+(NSArray*)getVideosForExercise:(NSInteger) exerciseId;

/**
 Ritorna tutti i media diversi dai video di un certo programma
 @param programId Identificativo del programma. -1 per non filtrare
 @return NSArray* che contiene oggetti di tipo Media
 */
+(NSArray*)getAllMediasFromProgram:(NSInteger)programId;

@end
