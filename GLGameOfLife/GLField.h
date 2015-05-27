//
//  GLField.h
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLCell.h"
@import UIKit;

@interface GLField : NSObject

@property (nonatomic) NSMutableArray *cells;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) int cellRectSize;
@property (nonatomic) UIView *parentView;

- (id)initWithCellRectSize:(int) cellRectSize
            RandomizeField:(BOOL) randomField
                ParentView:(UIView *) parentView;
- (void) startEvolvingProcess;
- (void) evolveFieldOnce;
- (void) drawField;

@end
