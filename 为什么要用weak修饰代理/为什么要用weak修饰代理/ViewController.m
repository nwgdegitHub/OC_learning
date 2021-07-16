//
//  ViewController.m
//  为什么要用weak修饰代理
//
//  Created by udc on 2019/4/4.
//  Copyright © 2019年 udc. All rights reserved.
//

#import "ViewController.h"
#import "HSPerson.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 实例化person, self对person弱引用，person的retainCount不变
    
    HSPerson *person = [[HSPerson alloc] init];
    // NSLog(@"%d",[person retainCount]); ARC中已经不支持看引用计数了
   
    
}


- (void)dealloc
{
    
}

@end
