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
#define TIME_INTERVAL 0.125

@implementation GLField

- (id)initWithCellRectSize:(int) cellRectSize
            RandomizeField:(BOOL) randomField
                ParentView:(UIView *) parentView
                      Mode:(int) evolutionMode
             PaletteColor1:(CIColor *)color1
             PaletteColor2:(CIColor *)color2
{
    self = [super init];
    if (self)
    {
        _evolutionMode = evolutionMode;
        _cellRectSize = cellRectSize;
        _parentView = parentView;
        _cells = [NSMutableArray new];
        _fieldSize.height = _parentView.frame.size.height / cellRectSize;
        _fieldSize.width = _parentView.frame.size.width / cellRectSize;
        _palette = [self paletteForMode:evolutionMode FromColor1:color1 ToColor:color2];
        [self generateFieldRandomized:randomField];
    }
    return self;
}

- (NSArray *) paletteForMode: (int) evolutionMode
                  FromColor1:(CIColor *) color1
                     ToColor:(CIColor *) color2{
    NSMutableArray *result = [NSMutableArray new];
    switch (evolutionMode) {
        case GLConwayMode:
            result = [self generatePaletteFromColor1:color1
                                            ToColor2:color2
                                                Size:2];
            break;
            
        case GLCyclicMode:
            result = (NSMutableArray*)@[[UIColor colorWithRed:1 green:0 blue:0 alpha:0],
                       [CIColor colorWithRed:0.5 green:0.5 blue:0 alpha:0],
                       [CIColor colorWithRed:0 green:1 blue:0.5],
                       [CIColor colorWithRed:0 green:0 blue:1],
                       [CIColor colorWithRed:0.5 green:0 blue:0.5],
                       [CIColor colorWithRed:1 green:1 blue:0],
                       [CIColor colorWithRed:1 green:0 blue:1],
                       [CIColor colorWithRed:0 green:1 blue:0]];
//            result = [self generatePaletteFromColor1:color1
//                                            ToColor2:color2
//                                                Size:8];
            break;
            
            
        default:
            break;
    }
    return result;
}

- (NSMutableArray *) generatePaletteFromColor1: (CIColor*) color1
                                      ToColor2: (CIColor*) color2
                                          Size: (int) size{
    double dR,dG,dB;
    NSMutableArray *palette = [NSMutableArray new];
    
    
    dR = (color1.red - color2.red)/(size-1);
    dG = (color1.green - color2.green)/(size-1);
    dB = (color1.blue - color2.blue)/(size-1);
    for (int i = 0; i < size; i++) {
        float r = color1.red-dR*i;
        float g = color1.green-dG*i;
        float b = color1.blue-dB*i;
        CIColor *newColor = [CIColor colorWithRed:r
                                            green:g
                                             blue:b];
        NSLog(@"%f %f %f",r,g,b);
        [palette addObject:[UIColor colorWithCIColor:newColor]];
    }
    
    return palette;
}

- (void) generateFieldRandomized:(BOOL)random{
    for (int y = 0; y < _fieldSize.height; y++ )
    {
        NSMutableArray *newCellRow = [NSMutableArray new];
        for (int x = 0; x < _fieldSize.width; x++)
        {
            int newCellState = (random)?arc4random()%self.palette.count:0;
            CGRect newCellFrame = CGRectMake(x * _cellRectSize, y * _cellRectSize, _cellRectSize, _cellRectSize);
            UIView *newCellView = [[UIView alloc] initWithFrame: newCellFrame];
            [_parentView addSubview:newCellView];
            GLCell *newCell = [[GLCell alloc] initWithState: newCellState
                                                   Location: CGPointMake(x, y)
                                                ParentField: self
                                                   CellView: newCellView];
            [newCellRow insertObject:newCell atIndex:x];
        }
        [self.cells insertObject:newCellRow atIndex:y];
    }
}

- (void) startEvolvingProcess{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIME_INTERVAL
                                                  target:self
                                                selector:@selector(evolveFieldOnce)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void) drawField{
    for (int x = 0; x < _fieldSize.width; x++ ){
        for (int y = 0; y < _fieldSize.height; y++){
            [[[self.cells objectAtIndex:y] objectAtIndex:x] draw];
        }
    }
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