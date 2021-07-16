//
//  HSDog.h
//  为什么要用weak修饰代理
//
//  Created by udc on 2019/4/4.
//  Copyright © 2019年 udc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSDog : NSObject

@property (nonatomic, weak) id delegate; //weak修饰 HSDog/HSPerson都会走dealloc 方法
//但是用strong修饰则不会 所以导致 经常说的内存泄露，该释放的内存并未释放！

@end

NS_ASSUME_NONNULL_END
