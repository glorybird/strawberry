//
//  ViewController.m
//  strawberry
//
//  Created by FanFamily on 15/12/31.
//  Copyright © 2015年 glory. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

static NSInteger const kBallSize = 10;

@interface ViewController ()

@property (nonatomic) UIDynamicAnimator* animator;
@property (nonatomic) Model* model;
@property (nonatomic) UICollisionBehavior* collision;
@property (nonatomic) NSMutableArray* bricks;
@property (nonatomic) UIView* first;
@property (nonatomic) NSMutableArray *linksArray;
@property (nonatomic) UIView *balloon;
@property (nonatomic) CADisplayLink *displayLink;
@property (nonatomic) CAShapeLayer *linkLayer;
@property (nonatomic) UIView* ltLink1;
@property (nonatomic) UIAttachmentBehavior* linkAttachmentBehavior;
@property (nonatomic, assign) CGFloat dynamicsCount;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    
    [self setupShapeLayer];
    [self setUpBalloon];
    [self setupDisplayLink];
//    _model = [[Model alloc] init];
//    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
//    _bricks = [NSMutableArray array];
//    
//    for (NSInteger i = 0; i < 10; i++) {
//        UIView* v = [_model newbrick:CGPointMake(10 + i*(34 + _model.brickSize.width), [[UIScreen mainScreen] bounds].size.height - _model.brickSize.height)];
//        if (i == 0) {
//            _first = v;
//        }
//        [self.view addSubview:v];
//        [_bricks addObject:v];
//    }
    
}

- (void)setupShapeLayer{
    self.linkLayer = [CAShapeLayer layer];
    self.linkLayer.fillColor = [[UIColor clearColor] CGColor];
    self.linkLayer.lineJoin = kCALineJoinRound;
    self.linkLayer.lineWidth = 1.0f;
    self.linkLayer.strokeColor = [UIColor blackColor].CGColor;
    self.linkLayer.strokeEnd = 1.0f;
    [self.view.layer addSublayer:self.linkLayer];
}

- (void)setupDisplayLink{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayView)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)displayView{
    UIBezierPath* ballLinePath = [UIBezierPath bezierPath];
    [ballLinePath moveToPoint:self.ltLink1.center];
    [ballLinePath addLineToPoint:self.balloon.center];
    self.linkLayer.path = [ballLinePath CGPath];
}


- (void)setUpBalloon
{
    self.ltLink1 = [[UIView alloc] initWithFrame:CGRectMake(50, 0, 5, 5)];
    [self.ltLink1 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.ltLink1];
    
    self.balloon = [[UIView alloc] initWithFrame:CGRectMake(55, 50, kBallSize, kBallSize)];
    [self.balloon setBackgroundColor:[UIColor redColor]];
    self.balloon.layer.cornerRadius = kBallSize/2;
    [self.view addSubview:self.balloon];
    
    UIGravityBehavior* gravity = [[UIGravityBehavior alloc] initWithItems:@[self.balloon]];
    [self.animator addBehavior:gravity];
    
    self.linkAttachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.ltLink1
                                                   offsetFromCenter:UIOffsetMake(0, 0)
                                                     attachedToItem:self.balloon
                                                   offsetFromCenter:UIOffsetMake(0, 0)];
    UIAttachmentBehavior* fixedAttachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.ltLink1
                              offsetFromCenter:UIOffsetMake(0, 0)
                              attachedToAnchor:CGPointMake(52.5, 2.5)];
    [self.animator addBehavior:fixedAttachmentBehavior];
    [self.animator addBehavior:self.linkAttachmentBehavior];
    
    _collision = [[UICollisionBehavior alloc] initWithItems:@[self.balloon]];
    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];
    [self.animator addBehavior:_collision];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushRedBall:(id)sender
{
    UIPushBehavior* push = [[UIPushBehavior alloc] initWithItems:@[self.balloon] mode:UIPushBehaviorModeInstantaneous];
    [push setAngle:0 magnitude:.01];
    [self.animator addBehavior:push];
}

- (IBAction)cutLine:(id)sender
{
    [self.linkLayer removeFromSuperlayer];
    [self.animator removeBehavior:self.linkAttachmentBehavior];
    UIPushBehavior* push = [[UIPushBehavior alloc] initWithItems:@[self.balloon] mode:UIPushBehaviorModeInstantaneous];
    if (self.balloon.center.x >= self.ltLink1.center.x) {
        [push setAngle:0 magnitude:(self.balloon.center.x - 50) / 15 * .01];
    } else {
        [push setAngle:0 magnitude:- (self.balloon.center.x - 50) / 15 * .01];
    }
    [self.animator addBehavior:push];
}

//- (IBAction)play:(id)sender {
//    UIGravityBehavior* gravity = [[UIGravityBehavior alloc] initWithItems:_bricks];
//    gravity.magnitude = 10;
//    [self.animator addBehavior:gravity];
//    
//    _collision = [[UICollisionBehavior alloc] initWithItems:_bricks];
//    [_collision setTranslatesReferenceBoundsIntoBoundary:YES];
//    [self.animator addBehavior:_collision];
//    
//    UIPushBehavior* push = [[UIPushBehavior alloc] initWithItems:@[_first] mode:UIPushBehaviorModeInstantaneous];
//    [push setTargetOffsetFromCenter:UIOffsetMake(0, -_model.brickSize.height/4) forItem:_first];
//    [push setAngle:0 magnitude:.1];
//    [self.animator addBehavior:push];
//}
@end
