//
//  GLCell.m
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import "GLCell.h"
#import "GLField.h"
@import UIKit;
@implementation GLCell

- (id)initWithState: (int) state
           Location: (CGPoint) location
        ParentField: (GLField *) parentField
           CellView: (UIView *) cellView
{
    self = [super init];
    if (self) {
        _location = location;
        _state = state;
        _parentField = parentField;
        _cellView = cellView;
        _color = [parentField.palette objectAtIndex:state];
    }
    return self;
}

- (NSSet *) getNeighboursInRange: (int) range{
    NSMutableSet *result = [NSMutableSet new];
    for (int x = -range; x <= range; x++) {
        for (int y = -range; y <= range; y++){
            int tx = self.location.x - x;
            int ty = self.location.y - y;
            if (tx >= 0 && ty >= 0 && tx < self.parentField.fieldSize.width && ty < self.parentField.fieldSize.height && !(x==0 && y==0)) {
                GLCell *neighbour = [[self.parentField.cells objectAtIndex:ty] objectAtIndex:tx];
                [result addObject:neighbour];
            }
        }
    }
    
    return result;
}

- (void) evolve{
    switch (self.parentField.evolutionMode) {
        case GLConwayMode:
            [self conwayRules];
            break;
            
        case GLCyclicMode:
            [self cyclicRules];
            break;
            
        default:
            [self conwayRules];
            break;
    }
}


- (void) cyclicRules{
    int treshold = 1;
    int N = 0;
    
    for(GLCell *neighbour in [self getNeighboursInRange:1]){
        if (_state+1 == neighbour.state ||
            (_state == _parentField.palette.count-1 && neighbour.state == 0)) {
            N++;
        }
    }
    if(N>treshold){
        _state++;
        if(_state > _parentField.palette.count - 1){
            _state = 0;
        }
    }
}

- (void) conwayRules{
    int aliveNeighbours = 0;
    for(GLCell *neighbour in [self getNeighboursInRange:1]){
        if (neighbour.state) {
            aliveNeighbours++;
        }
    }
    
    if(self.state){
        if(aliveNeighbours!=2 && aliveNeighbours != 3){
            _state = 0;
        }
    }else{
        if(aliveNeighbours==3){
            _state = 1;
        }
    }
}



- (void) draw{
    _color = [_parentField.palette objectAtIndex:_state];
    _cellView.backgroundColor = _color;
    [_cellView setNeedsDisplay];
}

@end
