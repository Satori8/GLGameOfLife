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
@class GLCell;


@import UIKit;

@interface GLField : NSObject

@property (nonatomic) NSMutableArray *cells;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) int cellRectSize;
@property (nonatomic) CGSize fieldSize;
@property (nonatomic) UIView *parentView;
@property (nonatomic) int evolutionMode;
@property (nonatomic) NSArray *palette;

- (id)initWithCellRectSize:(int) cellRectSize
            RandomizeField:(BOOL) randomField
                ParentView:(UIView *) parentView
                      Mode:(int) evolutionMode
             PaletteColor1:(CIColor *) color1
             PaletteColor2:(CIColor *) color2;
- (void) startEvolvingProcess;
- (void) evolveFieldOnce;
- (void) drawField;

@end
