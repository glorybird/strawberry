//
//  Model.m
//  strawberry
//
//  Created by FanFamily on 15/12/31.
//  Copyright © 2015年 glory. All rights reserved.
//

#import "Model.h"

@implementation Model

- (CGSize)brickSize
{
    return CGSizeMake(10, 50);
}

- (UIView *)newbrick:(CGPoint)origin
{
    UIView* brick = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, 10, 50)];
    brick.backgroundColor = [UIColor blackColor];
    return brick;
}

@end
