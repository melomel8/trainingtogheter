//
//  ZoomableView.m
//  TrainingTogether
//
//  Created by Susanna DiMauro on 18/12/14.
//  Copyright (c) 2014 Alessio Melani. All rights reserved.
//

#import "ZoomableView.h"

@interface ZoomableView()

-(void) dismissImageView:(UIButton*)button;

@end

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
        //[myScrollView setBackgroundColor:[UIColor blackColor]];
        [myScrollView setBackgroundColor:[UIColor clearColor]];
        myImageView.contentMode = UIViewContentModeScaleAspectFit; //per mantenere le proporzioni dell'immagine
         self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
         myScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
         myImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth; // in modo che, anche se ruotata, si adatti alla view
        
        //rendo zommabile la foto
        myScrollView.minimumZoomScale = 1;
        myScrollView.maximumZoomScale = 2;
        myScrollView.delegate = self;
        
        [myScrollView setBounces:NO];
        [myScrollView setDirectionalLockEnabled:YES];
        myScrollView.showsVerticalScrollIndicator = NO;
        myScrollView.showsHorizontalScrollIndicator = NO;
        
        //aggiungo il bottone di chiusura della view
        /*UIButton *btnDismissImageView = [UIButton buttonWithType:UIButtonTypeSystem];
        [btnDismissImageView addTarget:self action:@selector(dismissImageView:) forControlEvents:UIControlEventTouchUpInside];
        [btnDismissImageView setTitle:@"X" forState:UIControlStateNormal];
        [btnDismissImageView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnDismissImageView setBackgroundColor:[UIColor darkGrayColor]];
        btnDismissImageView.frame = CGRectMake(myScrollView.frame.origin.x, myScrollView.frame.origin.y, 20.0, 20.0);
        [btnDismissImageView setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnDismissImageView.titleLabel.font= [UIFont fontWithName:@"ArialRoundedMTBold" size:20.0f];
        [self addSubview:btnDismissImageView];
        */
        
        [myImageView setImage:imageTapped];
        
    }
    
    return self;
}


-(void)dismissImageView:(UIButton*)button
{
    DLog(@"SONO DENTRO AL DISMISS");
    self.removeFromSuperview;
}


#pragma mark ScrollViewDelegate
-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView.subviews objectAtIndex:0]; //in quanto ho aggiunto una sola ImageView. Posso accederci, quindi, con l'indice dellaScrollView
}

@end
