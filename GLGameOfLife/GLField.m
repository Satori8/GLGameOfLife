//
//  GLField.m
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import "GLField.h"
#import "GLCell.h"

#define RANDOM YES

@implementation GLField

- (id)initWithCellRectSize:(int) cellRectSize
            RandomizeField:(BOOL) randomField
                ParentView:(UIView *) parentView{
    self = [super init];
    if (self) {
        self.cellRectSize = cellRectSize;
        self.parentView = parentView;
        self.cells = [NSMutableArray new];
        _fieldSize.height = (int)(self.parentView.frame.size.height / cellRectSize);
        _fieldSize.width = (int)(self.parentView.frame.size.width / cellRectSize);
        for (int y = 0; y < _fieldSize.height; y++ ){
            NSMutableArray *newCellRow = [NSMutableArray new];
            for (int x = 0; x < _fieldSize.width; x++){
                BOOL newCellState = (RANDOM)?arc4random()%2:NO;
                CGRect newCellFrame = CGRectMake(x * cellRectSize, y * cellRectSize, cellRectSize, cellRectSize);
                UIView *newCellView = [[UIView alloc] initWithFrame: newCellFrame];
                [parentView addSubview:newCellView];
                GLCell *newCell = [[GLCell alloc] initWithState: (BOOL)newCellState
                                                       Location: CGPointMake(x, y)
                                                    ParentField: self
                                                       CellView: newCellView];
                [newCellRow insertObject:newCell atIndex:x];
            }
            [self.cells insertObject:newCellRow atIndex:y];
        }
    }
    
    return self;
}


- (void) startEvolvingProcess{

}

- (void) drawField{
    for (int x = 0; x < _fieldSize.width; x++ ){
        for (int y = 0; y < _fieldSize.height; y++){
            [[[self.cells objectAtIndex:y] objectAtIndex:x] draw];
        }
    }
    [[self parentView] setNeedsDisplay];
}

- (void) evolveFieldOnce{
    for (int x = 0; x < _fieldSize.width; x++ ){
        for (int y = 0; y < _fieldSize.height; y++){
            [[[self.cells objectAtIndex:y] objectAtIndex:x] evolve];
        }
    }
    [self drawField];
}


@end
