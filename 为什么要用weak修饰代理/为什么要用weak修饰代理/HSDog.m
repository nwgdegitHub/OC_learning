//
//  HSDog.m
//  为什么要用weak修饰代理
//
//  Created by udc on 2019/4/4.
//  Copyright © 2019年 udc. All rights reserved.
//

#import "HSDog.h"

@implementation HSDog

-(void)dealloc
{
    NSLog(@"HSDog----销毁");
}

@end
