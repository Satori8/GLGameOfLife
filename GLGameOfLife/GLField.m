//
//  GLField.m
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import "GLField.h"

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
        for (int y = 0; y < self.parentView.frame.size.width; y+=self.cellRectSize ){
            NSMutableArray *newCellRow = [NSMutableArray new];
            for (int x = 0; x < self.parentView.frame.size.height; x+=self.cellRectSize){
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
    for (int x = 0; x < self.parentView.frame.size.width; x+=self.cellRectSize ){
        for (int y = 0; y < self.parentView.frame.size.height; y+=self.cellRectSize){
            [[[self.cells objectAtIndex:x] objectAtIndex:y] draw];
        }
    }
}

- (void) evolveFieldOnce{
    for (int x = 0; x < self.parentView.frame.size.width; x+=self.cellRectSize ){
        for (int y = 0; y < self.parentView.frame.size.height; y+=self.cellRectSize){
            [[[self.cells objectAtIndex:x] objectAtIndex:y] evolve];
        }
    }
}


@end
