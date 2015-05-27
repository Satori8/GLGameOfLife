//
//  GLCell.m
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import "GLCell.h"

@implementation GLCell

- (id)initWithState: (BOOL) alive
           Location: (CGPoint) location
        ParentField: (GLField *) parentField
           CellView: (UIView *) cellView
{
    self = [super init];
    if (self) {
        self.location = location;
        self.alive = alive;
        self.parentField = parentField;
        cellView.backgroundColor = (alive)?[UIColor blackColor]:[UIColor whiteColor];
        self.cellView = cellView;
    
    }
    return self;
}

- (void) evolve{
    
}

- (void) draw{
    [self.cellView setNeedsDisplay];
}

@end
