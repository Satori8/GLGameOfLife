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
                                                            Mode:GLCyclicMode
                                                   PaletteColor1:[CIColor colorWithRed:1
                                                                                 green:1
                                                                                  blue:1]
                                                   PaletteColor2:[CIColor colorWithRed:0.5
                                                                                 green:0
                                                                                  blue:0]];
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
