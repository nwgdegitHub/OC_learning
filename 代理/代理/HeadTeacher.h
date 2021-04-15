//
//  HeadTeacher.h
//  代理
//
//  Created by udc on 2019/3/26.
//  Copyright © 2019年 udc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "grade.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeadTeacher : NSObject<grade> //遵守代理，会出现在自己的objc_protocol_list中

@end

NS_ASSUME_NONNULL_END
