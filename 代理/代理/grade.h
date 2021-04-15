//
//  grade.h
//  代理
//
//  Created by udc on 2019/3/26.
//  Copyright © 2019年 udc. All rights reserved.
//

#ifndef grade_h
#define grade_h

@protocol grade<NSObject>

@required; //必须实现
@optional; //可选实现

-(int)studentGradeFromDelegate;

@end

#endif /* grade_h */
