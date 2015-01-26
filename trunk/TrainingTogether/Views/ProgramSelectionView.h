//
//  ProgramSelectionView.h
//  TrainingTogether
//
//  Created by Alessio Melani on 15/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    kCoreStability = 0,
    kFitballTraining,
    kSuspensionTraining,
    kCalisthensicTraining,
    kCoordinativeTraining,
    kInYourHomeTraining,
    kFunctionalTraining,
    kMetabolicTraining
}kSector;

@protocol ProgramSelectionDelegate <NSObject>

@optional
-(void)sectorTapped:(id)sender withSector:(kSector)theSector isPurchased:(BOOL)isPurchased;

@end

@interface ProgramSelectionView : UIView
{
    __unsafe_unretained id<ProgramSelectionDelegate>    delegate;
    
    CGFloat     radius;
}

@property(nonatomic, assign)      id<ProgramSelectionDelegate>    delegate;
@property(nonatomic, readonly)    CGFloat                         radius;

@end
