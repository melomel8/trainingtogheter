//
//  Media.h
//  TrainingTogether
//
//  Created by Susanna DiMauro on 01/12/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

@interface Media : NSObject
{
    NSInteger   mediaId;
    NSString*   mediaPath;
    
}
@property (nonatomic, assign) NSInteger     mediaId;
@property (nonatomic, retain) NSString*     mediaPath;

/*!
 Costruttore che inizializza un Media
 @param resultSet Result Set che contiene tutte le foto di un Exercise
 */
-(id)initFromResultSet:(FMResultSet*) resulSet;

@end
