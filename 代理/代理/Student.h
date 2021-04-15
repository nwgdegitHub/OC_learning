//
//  Student.h
//  代理
//
//  Created by udc on 2019/3/26.
//  Copyright © 2019年 udc. All rights reserved.
//  委托类
//用一个id类型的指针将代理对象进行了一个弱引用,这个id类型指针指向的对象，就是代理对象,其实委托方的代理属性本质上就是代理对象自身


#import <Foundation/Foundation.h>
#import "grade.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property(nonatomic,weak) id<grade>delegate;

-(void)myGrade; //查询自己的成绩


@end

NS_ASSUME_NONNULL_END
