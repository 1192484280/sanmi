//
//  ColorArrManager.m
//  QYSD
//
//  Created by 郝祥聪 on 2019/8/19.
//  Copyright © 2019 qingyun. All rights reserved.
//

#import "ColorArrManager.h"

@implementation ColorArrManager

+ (NSArray *)getColorRGBA:(UIColor *)color {
    CGFloat numOfcomponents = CGColorGetNumberOfComponents(color.CGColor);
    NSArray *rgbaComponents;
    if (numOfcomponents == 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        rgbaComponents = [NSArray arrayWithObjects:@(components[0]), @(components[1]), @(components[2]), @(components[3]), nil];
    }
    return rgbaComponents;

}

@end
