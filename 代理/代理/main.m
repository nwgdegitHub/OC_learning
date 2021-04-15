//
//  main.m
//  代理
//
//  Created by udc on 2019/3/26.
//  Copyright © 2019年 udc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

#import "HeadTeacher.h"
#import "HeadMaster.h"

int main(int argc, const char * argv[]) {
    
    @autoreleasepool {
        
        Student *stu = [[Student alloc]init];
        
        HeadTeacher *ht = [HeadTeacher new];
    
        //HeadMaster *hm = [HeadMaster new];
        
        stu.delegate = ht; //班主任做代理
        //stu.delegate = hm;
        
        [stu myGrade];
        
    }
   
    return 0;
}
