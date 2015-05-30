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

@interface GLField ()

@property (nonatomic) int** mathField;

@end

@implementation GLField

- (id)initWithCellRectSize:(int) cellRectSize
            RandomizeField:(BOOL) randomField
                ParentView:(UIView *) parentView
             TimerInterval:(float)timerInterval
{
    self = [super init];
    if (self)
    {
        _cellRectSize = cellRectSize;
        _parentView = parentView;
        _cellViews = [NSMutableArray new];
        _timerInterval = timerInterval;
        _fieldHeight = _parentView.frame.size.height / cellRectSize;
        _fieldWidth = _parentView.frame.size.width / cellRectSize;
        //_palette = [self paletteForMode:evolutionMode FromColor1:color1 ToColor:color2];
        _palette = @[[UIColor whiteColor],[UIColor blackColor]];
        [self generateFieldRandomized:YES];
    }
    return self;
}





# pragma mark - --- Palette generators ---
//#######################################

- (NSArray *) paletteForMode: (int) evolutionMode
                  FromColor1:(CIColor *) color1
                     ToColor:(CIColor *) color2{
    NSMutableArray *result = [NSMutableArray new];
    switch (evolutionMode) {
        case GLConwayMode:
            result = [self generateGradientPaletteFromColor1:color1
                                            ToColor2:color2
                                                Size:2];
            break;
            
        case GLCyclicMode:
                        result = [self generateCyclicPalette:4];
            break;
            
            
        default:
            break;
    }
    return result;
}

- (NSMutableArray *) generateCyclicPalette: (int) numberOfColors{
    NSMutableArray *result = [NSMutableArray new];
    float dH = 1.0 / (numberOfColors - 1);
    for (int i = 0; i < numberOfColors; i++) {
        [result addObject:[UIColor colorWithHue:dH*i saturation:1 brightness:1 alpha:1]];
    }
    return result;
}

- (NSMutableArray *) generateGradientPaletteFromColor1: (CIColor*) color1
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


# pragma mark - --- Generate and draw feild ---
//##########################################


- (void) generateFieldRandomized:(BOOL)random{

    self.mathField = malloc( sizeof(int*) * self.fieldHeight );
    for (int y = 0; y < _fieldHeight; y++ )
    {
        self.mathField[y] =  malloc( sizeof(int) * self.fieldWidth );
        NSMutableArray *newCellRow = [NSMutableArray new];
        for (int x = 0; x < _fieldWidth; x++)
        {
            int newCellState = (random)?arc4random()%self.palette.count:0;
            self.mathField[y][x] = newCellState;
            CGRect newCellFrame = CGRectMake(x * _cellRectSize, y * _cellRectSize, _cellRectSize, _cellRectSize);
            UIView *newCellView = [[UIView alloc] initWithFrame: newCellFrame];
            [self.parentView addSubview:newCellView];
            GLCell *newCell = [[GLCell alloc] initWithState: newCellState
                                                   Location: CGPointMake(x, y)
                                                   CellView: newCellView];
            newCell.color = [self.palette objectAtIndex:newCellState];
            [newCellRow insertObject:newCell atIndex:x];
        }
        [self.cellViews insertObject:newCellRow atIndex:y];
    }
}


- (void) drawField{
    for (int y = 0; y < _fieldHeight; y++ ){
        for (int x = 0; x < _fieldWidth; x++){
            GLCell * cellView = [[self.cellViews objectAtIndex:y] objectAtIndex:x];
            cellView.color = [self.palette objectAtIndex:self.mathField[y][x]];
            [cellView draw];
        }
    }
}


# pragma mark - --- Evolving process methods
//##########################################

- (void) startEvolvingProcess{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval
                                                  target:self
                                                selector:@selector(evolveFieldOnce)
                                                userInfo:nil
                                                 repeats:YES];
}


- (void) evolveFieldOnce{
    int **newMathField = malloc( sizeof(int*) * self.fieldHeight);
    for (int y = 0; y < _fieldHeight; y++){
        newMathField[y] = malloc( sizeof(int) * self.fieldHeight);
        for (int x = 0; x < _fieldWidth; x++){
            if(self.evolutionMode == GLConwayMode){
                newMathField[y][x] = [self conwayRulesAtCellState:self.mathField[y][x]
                                                        Neighours:[self getNeighboursInRange:self.neighbourRange
                                                                                  OnLocation:CGPointMake(x, y)]];
                int a = 0;
            }
            if(self.evolutionMode == GLCyclicMode){
                newMathField[y][x] = [self cyclicRulesAtCellState:self.mathField[y][x]
                                                        Neighours:[self getNeighboursInRange:self.neighbourRange
                                                                                  OnLocation:CGPointMake(x, y)]
                                                                                   Threshold:self.cyclicTreshold];
            }
        }
    }
    
    self.mathField = newMathField;
    
    [self drawField];
}




#pragma mark - --- Evolution rules
//##########################################


- (int) cyclicRulesAtCellState: (int) state Neighours: (NSArray *) neighbours Threshold: (int) treshold{
    int N = 0;
    
    int nextState = (state + 1) % self.palette.count;
    for(NSNumber *n in neighbours){
        if (n.intValue == nextState){
            N++;
            if(N>treshold){
                break;
            }
        }
    }
    if(N>treshold){
        return nextState;
    } else {
        return state;
    }
}


- (int) conwayRulesAtCellState: (int) state Neighours: (NSArray *) neighbours{
    int aliveNeighbours = 0;
    for(NSNumber *n in neighbours){
        if (n.intValue){
            aliveNeighbours++;
        }
    }
    
    if(state>0){
        if(aliveNeighbours<2 || aliveNeighbours > 3){
            return 0;
        } else {
            return 1;
        }
    } else{
        if (aliveNeighbours==3){
            return 1;
        } else {
            return 0;
        }
    }
}


- (NSArray *) getNeighboursInRange: (int) range OnLocation: (CGPoint) location{
    if(self.neighbourGird == GLVonNeumannSpace){
        return [self getVonNeumannNeighboursInRange:range onLocation:location];
    } else {
        return [self getMooreNeighboursInRange:range onLocation:location];
    }
}


#pragma mark - --- Neighbourhood grid ---
//##########################################


- (NSMutableArray *) getMooreNeighboursInRange: (int) range onLocation: (CGPoint) location{
    int xmin = (location.x - range > 0)?location.x - range:0;
    int xmax = (location.x + range < self.fieldWidth)?location.x + range:self.fieldWidth-1;
    int ymin = (location.y - range > 0)?location.y - range:0;
    int ymax = (location.y + range < self.fieldHeight)?location.y + range:self.fieldHeight-1;
    NSMutableArray *result = [NSMutableArray new];
    
    for (int y = ymin; y <= ymax; y++) {
        for (int x = xmin; x <= xmax; x++){
            if (x!=location.x || y!=location.y) {
                [result addObject:[NSNumber numberWithInteger:self.mathField[y][x]]];
            }
        }
    }
    
    return result;
}


- (NSMutableArray *) getVonNeumannNeighboursInRange: (int) range onLocation: (CGPoint) location{
    int xmin = (location.x - range > 0)?location.x - range:0;
    int xmax = (location.x + range < self.fieldWidth)?location.x + range:self.fieldWidth-1;
    int ymin = (location.y - range > 0)?location.y - range:0;
    int ymax = (location.y + range < self.fieldHeight)?location.y + range:self.fieldHeight-1;
    NSMutableArray *result = [NSMutableArray new];
    
    for (int y = ymin; y <= ymax; y++) {
        for (int x = xmin; x <= xmax; x++){
            if ((x!=location.x || y!=location.y) && (y - ymin)+(x - xmin) <= range) {
                [result addObject:[NSNumber numberWithInt:self.mathField[y][x]] ];
            }
        }
    }

    return result;
}




@end