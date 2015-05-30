//
//  GLCell.m
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import "GLCell.h"

@import UIKit;

@implementation GLCell

- (id)initWithState: (int) state
           Location: (CGPoint) location
           CellView: (UIView *) cellView
{
    self = [super init];
    if (self) {
        _location = location;
        _state = state;
        _cellView = cellView;
    }
    return self;
}


- (void) draw{
    _cellView.backgroundColor = _color;
    [_cellView setNeedsDisplay];
}

@end
