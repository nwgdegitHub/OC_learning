//
//  Student.m
//  代理
//
//  Created by udc on 2019/3/26.
//  Copyright © 2019年 udc. All rights reserved.
//
//-(instancetype)init
//{
//    //NSLog(@"Student-init");
//    return self;
//}
//NSLog(@"%@",_delegate); // <HeadTeacher: 0x10054bbb0>
// // 委托方让代理方执行操作，实际上是在委托类中向这个id类型指针指向的对象发送消息

#import "Student.h"

@implementation Student

-(void)myGrade
{
    if ([_delegate respondsToSelector:@selector(studentGradeFromDelegate)]) {
        
        NSLog(@"我是学生，我的成绩查到了%d",[_delegate studentGradeFromDelegate]);
        
    }
}
@end
