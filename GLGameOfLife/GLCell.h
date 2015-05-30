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
@property (nonatomic) UIView *cellView;
@property (nonatomic) int state;
@property (nonatomic) UIColor *color;

- (id)initWithState: (int) state
           Location: (CGPoint) location
           CellView:(UIView *) cellView;

- (void) draw;

@end
