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
    
    self.fieldGameOfLife = [[GLField alloc] initWithCellRectSize:32
                                                  RandomizeField:YES
                                                      ParentView:self.gameOfLifeView];
    
    
    [[self fieldGameOfLife] drawField];
    [[self fieldGameOfLife] startEvolvingProcess];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.fieldGameOfLife evolveFieldOnce];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
