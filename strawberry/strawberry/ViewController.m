//
//  ViewController.m
//  strawberry
//
//  Created by FanFamily on 15/12/31.
//  Copyright © 2015年 glory. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

@interface ViewController ()

@property (nonatomic) UIDynamicAnimator* animator;
@property (nonatomic) Model* model;
@property (nonatomic) UICollisionBehavior* collision;
@property (nonatomic) NSMutableArray* bricks;
@property (nonatomic) UIView* first;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _model = [[Model alloc] init];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    _bricks = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 20; i++) {
        UIView* v = [_model newbrick:CGPointMake(10 + i*(34 + _model.brickSize.width), [[UIScreen mainScreen] bounds].size.height - _model.brickSize.height)];
        if (i == 0) {
            _first = v;
        }
        [self.view addSubview:v];
        [_bricks addObject:v];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    UIGravityBehavior* gravity = [[UIGravityBehavior alloc] initWithItems:_bricks];
    gravity.magnitude = 10;
    [self.animator addBehavior:gravity];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:_bricks];
    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];
    [self.animator addBehavior:_collision];
    
    UIPushBehavior* push = [[UIPushBehavior alloc] initWithItems:@[_first] mode:UIPushBehaviorModeInstantaneous];
    [push setTargetOffsetFromCenter:UIOffsetMake(0, -_model.brickSize.height/4) forItem:_first];
    [push setAngle:0 magnitude:.1];
    [self.animator addBehavior:push];
}
@end
