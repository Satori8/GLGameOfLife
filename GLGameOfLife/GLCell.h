//
//  GLCell.h
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GLField;
@import CoreGraphics;
@import UIKit;

@interface GLCell : NSObject

@property (nonatomic) CGPoint location;
@property (nonatomic) GLField *parentField;
@property (nonatomic) UIView *cellView;
@property (nonatomic) BOOL alive;



- (void) evolve;
- (void) draw;
- (id)initWithState: (BOOL) alive
           Location: (CGPoint) location
        ParentField: (GLField *) parentField
           CellView:(UIView *) cellView;


@end