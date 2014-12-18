//
//  ZoomableView.h
//  TrainingTogether
//
//  Created by Susanna DiMauro on 18/12/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomableView : UIView

/*!
 Costruttore che inizializza la vista zoomabile
 @param UIImage     Immagine sulla quale è stato effettuato un Tap
 */

-(id) initWithImage:(UIImage*)imageTapped andFrame:(CGRect)frame;

@end
