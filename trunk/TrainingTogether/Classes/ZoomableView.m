//
//  ZoomableView.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 18/12/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "ZoomableView.h"

@implementation ZoomableView

- (id)initWithImage:(UIImage *)imageTapped andFrame:(CGRect)frame
{
    //Al momento dell'inizializzazione di una view occorre che venga passato anche il frame altrimenti non sarà in grado di disegnarla
    if ((self = [super initWithFrame:frame]))
    {
        //l'origine è 0,0 in quanto è relativa alla posizione all'interno della view
        UIScrollView* myScrollView =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        UIImageView* myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)] ;
        
        //visualizzo gli oggetti creati
        [self addSubview:myScrollView];
        [myScrollView addSubview:myImageView];
        [myImageView addSubview:imageTapped];
        
    }
    
    return self;
}


@end
