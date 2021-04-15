//
//  HeadTeacher.m
//  代理
//
//  Created by udc on 2019/3/26.
//  Copyright © 2019年 udc. All rights reserved.
//

#import "HeadTeacher.h"
#import <objc/runtime.h>

@implementation HeadTeacher

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        unsigned int methodCount;
        Method *method = class_copyMethodList([self class], &methodCount);
        for (unsigned int i = 0; i < methodCount; i++) {
            Method me = method[i];
            NSLog(@"HeadTeacher 类的方法名称----%@",NSStringFromSelector(method_getName(me)));
        }
        free(method);
    }
    return self;
}


//如果此处没有实现 但是在[_delegate studentGradeFromDelegate]处调用了 会崩溃。虽然OC中[nil method] 不会崩溃，但是找不到方法，调用会崩溃, 所以这里是注意点。所以就出现协议两个修饰符@optional和@required （默认是后者，如果代理类没有实现，就会有一个黄色警告）
-(int)studentGradeFromDelegate
{
    return 100;
}

@end
