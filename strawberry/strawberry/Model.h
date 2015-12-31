//
//  Model.h
//  strawberry
//
//  Created by FanFamily on 15/12/31.
//  Copyright © 2015年 glory. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Model : NSObject

- (CGSize)brickSize;

- (UIView *)newbrick:(CGPoint)origin;

@end
