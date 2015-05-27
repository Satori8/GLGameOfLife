//
//  GLCell.m
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import "GLCell.h"
#import "GLField.h"

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
    int aliveNeighbours = 0;
    for (int x = -1; x <= 1; x++) {
        for (int y = -1; y <= 1; y++){
            int tx = self.location.x - x;
            int ty = self.location.y - y;
            if (tx > 0 && ty > 0 && tx < self.parentField.fieldSize.width && ty < self.parentField.fieldSize.height && !(x==0 && y==0)) {
                GLCell *neighbour = [[self.parentField.cells objectAtIndex:ty] objectAtIndex:tx];
                if (neighbour.alive) {
                    aliveNeighbours++;
                }
            }
        }
    }
    if(self.alive){
        if(aliveNeighbours!=2 && aliveNeighbours != 3){
            self.alive = NO;
        }
    }else{
        if(aliveNeighbours==3){
            self.alive = YES;
        }
    }
}

- (void) draw{
    self.cellView.backgroundColor = (self.alive)?[UIColor blackColor]:[UIColor whiteColor];
    [self.cellView setNeedsDisplay];
}

@end
