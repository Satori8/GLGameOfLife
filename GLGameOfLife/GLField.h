//
//  GLField.h
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import <Foundation/Foundation.h>
#define GLConwayMode 1
#define GLCyclicMode 2
#define GLVonNeumannSpace 10
#define GLMooreSpace      11
@class GLCell;


@import UIKit;

@interface GLField : NSObject

@property (nonatomic) NSMutableArray *cellViews;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) int cellRectSize;
@property (nonatomic) int fieldWidth;
@property (nonatomic) int fieldHeight;
@property (nonatomic) UIView *parentView;
@property (nonatomic) int evolutionMode;
@property (nonatomic) int cyclicTreshold;
@property (nonatomic) NSArray *palette;
@property (nonatomic) int neighbourGird;
@property (nonatomic) int neighbourRange;
@property (nonatomic) float timerInterval;

- (id)initWithCellRectSize:(int) cellRectSize
            RandomizeField:(BOOL) randomField
                ParentView:(UIView *) parentView
             TimerInterval:(float) timerInterval;

- (void) startEvolvingProcess;
- (void) evolveFieldOnce;
- (NSMutableArray *) generateCyclicPalette: (int) numberOfColors;
- (void) generateFieldRandomized:(BOOL)random;
- (void) drawField;

@end
