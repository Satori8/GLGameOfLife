//
//  ViewController.m
//  GLGameOfLife
//
//  Created by Александр on 27.05.15.
//  Copyright (c) 2015 Satori. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *gameOfLifeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.fieldGameOfLife = [[GLField alloc] initWithCellRectSize:4
                                                  RandomizeField:YES
                                                      ParentView:self.gameOfLifeView
                                                   TimerInterval:0.1];
    self.fieldGameOfLife.evolutionMode = GLCyclicMode;
    self.fieldGameOfLife.neighbourGird = GLVonNeumannSpace;
    self.fieldGameOfLife.cyclicTreshold = 1;
    self.fieldGameOfLife.neighbourRange = 1;
    self.fieldGameOfLife.palette = [self.fieldGameOfLife generateCyclicPalette:9];
//    self.fieldGameOfLife.palette = @[[UIColor whiteColor], [UIColor blackColor]];
    [self.fieldGameOfLife generateFieldRandomized:YES];
    [[self fieldGameOfLife] drawField];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self fieldGameOfLife] startEvolvingProcess];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
