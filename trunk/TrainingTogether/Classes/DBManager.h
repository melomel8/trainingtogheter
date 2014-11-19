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

/* Classe che gestisce le query al db */
@interface DBManager : NSObject
{
    
}

/**
 Ritorna tutte le difficoltà presenti nel DB
 @return NSArray* che contiene oggetti di tipo Difficulty
 */
+ (NSArray*)getAllDifficulty;

@end
