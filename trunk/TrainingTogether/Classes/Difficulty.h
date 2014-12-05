//
//  Difficulty.h
//  TrainingTogether
//
//  Created by Alessio Melani on 13/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

/**
 Classe che gestisce un livello di difficoltà
 */
@interface Difficulty : NSObject
{
    NSInteger DifficultyId;
    NSString* DifficultyName;
    NSString* DifficultyNote;
}

@property(nonatomic, assign) NSInteger DifficultyId;
@property(nonatomic, retain) NSString* DifficultyName;
@property(nonatomic, retain) NSString* DifficultyNote;

/*!
 Costruttore che inizializza un Difficulty
 @param resultSet Result Set che contiene i dati del livello di difficoltà
 */
- (id)initFromResultSet:(FMResultSet*)resultSet;



@end
