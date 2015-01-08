//
//  Training.h
//  TrainingTogether
//
//  Created by Susanna DiMauro on 20/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Exercise.h"

@interface Training : NSObject
{
    NSInteger   programId;
    NSInteger   difficultyId;
    NSInteger   exerciseId;
    NSInteger   numberOfSeries;
    NSInteger   repetitions;
    NSInteger   circuitRepetitions;
    NSInteger   charge;
    NSInteger   pauseSeconds;
    NSString*   mediaId;
    NSString*   mediaPath;
    Exercise*   exercise;
}

@property (nonatomic, assign)   NSInteger   programId;
@property (nonatomic, assign)   NSInteger   difficultyId;
@property (nonatomic, assign)   NSInteger   exerciseId;
@property (nonatomic, assign)   NSInteger   numberOfSeries;
@property (nonatomic, assign)   NSInteger   repetitions;
@property (nonatomic, assign)   NSInteger   circuitRepetitions;
@property (nonatomic, assign)   NSInteger   charge;
@property (nonatomic, assign)   NSInteger   pauseSeconds;
@property (nonatomic, retain)   NSString*   mediaPath;
@property (nonatomic, retain)   Exercise*   exercise;

/*!
 Costruttore che inizializza un Training
 @param resultSet Result Set che contiene i dati dell'allemaneto
 */
- (id)initFromResultSet:(FMResultSet*)resultSet;


@end
