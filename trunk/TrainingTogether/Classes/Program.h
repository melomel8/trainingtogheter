//
//  Programs.h
//  TrainingTogether
//
//  Created by Alessio Melani on 13/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

/** Classe che gestisce un programma di allenamento */
@interface Program : NSObject
{
    NSInteger   ProgramId;
    NSString*   ProgramName;
    NSString*   ThumbPath;
}

@property(nonatomic, assign)    NSInteger   ProgramId;
@property(nonatomic, retain)    NSString*   ProgramName;
@property(nonatomic, retain)    NSString*   ThumbPath;

/*!
 Costruttore, che inizializza un programma di allenamento a partire da un result set
 @param resultSet Result set che contiene i dati del programma di allenamento
 */
- (id)initFromResultSet:(FMResultSet*)resultSet;

@end
