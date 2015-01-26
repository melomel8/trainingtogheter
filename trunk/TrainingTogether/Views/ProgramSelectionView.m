//
//  ProgramSelectionView.m
//  TrainingTogether
//
//  Created by Alessio Melani on 15/01/15.
//  Copyright (c) 2015 Alessio Melani. All rights reserved.
//

#import "ProgramSelectionView.h"

#ifndef PROGRAM_SELECTION_VIEW_CONSTANTS
#define PROGRAM_SELECTION_VIEW_CONSTANTS @""

#define CORE_STABILITY_COLOR [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1.000]
#define FITBALL_TRAINING_COLOR [UIColor colorWithRed:0.549 green:0.718 blue:0.980 alpha:1.000]
#define SUSPENSION_TRAINING_COLOR [UIColor colorWithRed:0.357 green:1.000 blue:0.031 alpha:1.000]
#define CALISTHENSIC_TRAINING_COLOR [UIColor colorWithRed:1.000 green:1.000 blue:0.055 alpha:1.000]
#define COORDINATIVE_TRAINING_COLOR [UIColor colorWithRed:0.914 green:0.055 blue:0.051 alpha:1.000]
#define IN_YOUR_HOME_TRAINING_COLOR [UIColor colorWithRed:0.412 green:0.122 blue:0.627 alpha:1.000]
#define FUNCTIONAL_TRAINING_COLOR [UIColor colorWithRed:0.114 green:0.247 blue:0.463 alpha:1.000]
#define METABOLIC_TRAINING_COLOR [UIColor colorWithRed:0.459 green:0.459 blue:0.459 alpha:1.000]

#define SECTIONS 8

#endif

@interface ProgramSelectionView()
{
    NSMutableArray*     paths;
    NSArray*            purchasedProgram; //contiene i numeri (0,1,2,...) dei programmi acquistati
    int                 selectedPath;
}

- (UIColor*)getFillColorForSection:(int)section;
- (NSString*)getNameForProgram:(kSector)program;
- (BOOL)isProgramPurchased:(kSector)program;
- (void)lockSectorWithCenter:(CGPoint)centerPoint;

@end

@implementation ProgramSelectionView
@synthesize delegate, radius;

#pragma mark - Private Methods


- (UIColor*)getFillColorForSection:(int)section
{
    UIColor* fillColor;
    
    if (selectedPath == section)
        fillColor = [UIColor orangeColor];
    else
    {
        switch (section)
        {
            case 0:
                fillColor = CORE_STABILITY_COLOR;
                break;
            case 1:
                fillColor = FITBALL_TRAINING_COLOR;
                break;
            case 2:
                fillColor = SUSPENSION_TRAINING_COLOR;
                break;
            case 3:
                fillColor = CALISTHENSIC_TRAINING_COLOR;
                break;
            case 4:
                fillColor = COORDINATIVE_TRAINING_COLOR;
                break;
            case 5:
                fillColor = IN_YOUR_HOME_TRAINING_COLOR;
                break;
            case 6:
                fillColor = FUNCTIONAL_TRAINING_COLOR;
                break;
            case 7:
                fillColor = METABOLIC_TRAINING_COLOR;
                break;
            default:
                fillColor = [UIColor grayColor];
                break;
        }
    }
    return fillColor;
}

- (NSString*)getNameForProgram:(kSector)program
{
    NSString* name = @"";
    switch (program) {
        case kCoreStability:
            name = @"Core Stability";
            break;
        case kCalisthensicTraining:
            name = @"Calisthensic Training";
            break;
        case kCoordinativeTraining:
            name = @"Coordinative Training";
            break;
        case kFitballTraining:
            name = @"Fitball Training";
            break;
        case kFunctionalTraining:
            name = @"Functional Training";
            break;
        case kInYourHomeTraining:
            name = @"In Your Home";
            break;
        case kMetabolicTraining:
            name = @"Metabolic Training";
            break;
        case kSuspensionTraining:
            name = @"Suspension Training";
            break;
        default:
            break;
    }
    return name;
}

- (BOOL)isProgramPurchased:(kSector)program
{
    for (NSNumber* programNo in purchasedProgram)
        if ([programNo intValue] == program)
            return YES;
    return NO;
}

- (void)lockSectorWithCenter:(CGPoint)centerPoint
{
    UIImageView* imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImage* img = [UIImage imageNamed:@"Lock.png"];
    [imgView setImage:img];
    [imgView setCenter:centerPoint];
    [imgView setUserInteractionEnabled:YES];
    [self addSubview:imgView];
}



#pragma mark - UIView Methods

- (void)drawRect:(CGRect)rect
{
    [self setBackgroundColor:[UIColor clearColor]];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSString* deviceModel = [UIDevice currentDevice].model;
    BOOL isIpad = [deviceModel containsString:@"iPad"];

    CGPoint center = CGPointMake(CGRectGetWidth(rect) / 2.0f, CGRectGetHeight(rect) / 2.0f);
    
    CGFloat FONT_SIZE = isIpad ? 20.0f : 10.0f;
    
    for (int i = 0; i < SECTIONS; i++)
    {
        UIColor* fillColor = [self getFillColorForSection:i];
        UIBezierPath* theArc = [UIBezierPath bezierPath];
        theArc.lineWidth = 10.0f;
        [theArc moveToPoint:center];
        [theArc addArcWithCenter:center radius:radius startAngle:(i * M_PI_4) - M_PI_2 endAngle:((i+1) * M_PI_4) - M_PI_2 clockwise:YES];
        [fillColor setFill];
        [theArc fill];
        [[UIColor blackColor] setStroke];
        [theArc stroke];
        [theArc closePath];
        [paths addObject:theArc];
        
        //disegno la stringa di testo
        NSString* title = [self getNameForProgram:i];
        CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:FONT_SIZE]}];
        CGFloat rotationAngle = - M_PI_2 - (M_PI_4 / 2) + ((i+1) * M_PI_4);
        
        float x = center.x + (radius / 2) * cos(rotationAngle);
        float y = center.y + (radius / 2) * sin(rotationAngle);
        
        UILabel* textLabel = [[UILabel alloc] initWithFrame:CGRectMake(x - ((radius - 15.0f) / 2), y - (textSize.height / 2), radius - 15.0f, textSize.height)];
        [textLabel setText:title];
        [textLabel setTextAlignment:rotationAngle < M_PI_2 ? NSTextAlignmentRight : NSTextAlignmentLeft];
        [textLabel setFont:[UIFont boldSystemFontOfSize:FONT_SIZE]];
        [textLabel setTextColor:[UIColor whiteColor]];
        [textLabel setBackgroundColor:[UIColor clearColor]];
        [textLabel setTransform:CGAffineTransformMakeRotation(rotationAngle < M_PI_2 ? rotationAngle : rotationAngle + M_PI)];
        [self addSubview:textLabel];
        
        if (![self isProgramPurchased:i])
            [self lockSectorWithCenter:CGPointMake(x, y)];
    }
    
    UIBezierPath* firstLine = [UIBezierPath bezierPath];
    firstLine.lineWidth = 10.0f;
    [firstLine moveToPoint:CGPointMake(center.x-radius, center.y)];
    [firstLine addLineToPoint:CGPointMake(center.x+radius, center.y)];
    [[UIColor blackColor] setStroke];
    [firstLine stroke];
    [firstLine closePath];
    
    [firstLine moveToPoint:CGPointMake(center.x, center.y - radius)];
    [firstLine addLineToPoint:CGPointMake(center.x, center.y + radius)];
    [[UIColor blackColor] setStroke];
    [firstLine stroke];
    [firstLine closePath];
    
}

#pragma mark - Public Methods

- (id)init
{
    if ((self = [super init]))
    {
        selectedPath = -1;
        paths = [[NSMutableArray alloc] init];
        purchasedProgram = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:kCoreStability], nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        selectedPath = -1;
        paths = [[NSMutableArray alloc] init];
        purchasedProgram = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:kCoreStability], nil];
        radius = frame.size.width > frame.size.height ? frame.size.width / 2.0f : frame.size.height / 2.0f;
        
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* theTouch = [[event allTouches] anyObject];
    CGPoint location = [theTouch locationInView:self];
    for (UIBezierPath* thePath in paths)
    {
        if ([thePath containsPoint:location] && self.delegate && [self.delegate respondsToSelector:@selector(sectorTapped:withSector:isPurchased:)])
        {
            selectedPath = -1;
            int tappedPath = [paths indexOfObject:thePath];
            [self setNeedsDisplay];
            [self.delegate sectorTapped:self withSector:tappedPath isPurchased:[self isProgramPurchased:tappedPath]];
            break;
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    selectedPath = -1;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* theTouch = [[event allTouches] anyObject];
    CGPoint location = [theTouch locationInView:self];
    BOOL finded = NO;
    for (UIBezierPath* thePath in paths)
    {
        if ([thePath containsPoint:location])
        {
            finded = YES;
            selectedPath = [paths indexOfObject:thePath];
            [self setNeedsDisplay];
            break;
        }
    }
    if (!finded)
    {
        selectedPath = -1;
        [self setNeedsDisplay];
    }
}


@end
