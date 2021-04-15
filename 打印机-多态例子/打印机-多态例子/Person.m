//
//  Person.m
//  打印机-多态例子
//
//  Created by udc on 2021/4/2.
//

#import "Person.h"

@implementation Person
- (void)doPrint:(Printer *)printer{
   [printer print];
} 
@end
