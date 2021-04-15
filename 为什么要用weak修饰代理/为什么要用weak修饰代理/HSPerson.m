//
//  HSPerson.m
//  为什么要用weak修饰代理
//
//  Created by udc on 2019/4/4.
//  Copyright © 2019年 udc. All rights reserved.
//

#import "HSPerson.h"
#import "HSDog.h"

@interface HSPerson()
/** 强引用dog*/

@property (nonatomic, strong) HSDog *dog;

@end

@implementation HSPerson

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // 实例化dog
        self.dog = [[HSDog alloc] init];
        // dog的delegate引用self,self的retainCount，取决于delegate修饰，weak：retainCount不变，strong：retainCount + 1
        self.dog.delegate = self;
        
    }
    return self;
    
}


- (void)dealloc
{
    NSLog(@"HSPerson----销毁");
    
}

    
@end
