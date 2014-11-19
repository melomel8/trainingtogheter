//
//  DBUtil.h
//  TrainingTogether
//
//  Created by Alessio Melani on 19/11/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

/*! Classe che mette a disposizione alcune funzioni di utilità per il DB */
@interface DBUtil : NSObject 
{
    
}

/*!
 Restituisce l'istanza di un DB sqlite
 @return FMDatabase* che rappresenta l'istanza corrente del DB sqlite
 */
+ (FMDatabase*)instance;

/*!
 Restituisce il path in cui è salvato il DB
 @return NSString* che rappresenta il path in cui è salvato il DB
 */
+ (NSString*)dbPath;

@end
