//
//  ViewController.m
//  OC基础
//
//  Created by udc on 2021/7/13.
//

#import "ViewController.h"
#import "AppDelegate.h"
#include <mach/mach_time.h>
// 记住把 IOKit.framework 从iOS设备中拖出来，然后导入
#include <UIKit/UIkit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self.btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)click{
    //调用代码使APP进入后台，达到点击Home键的效果。（私有API）
    [[UIApplication sharedApplication] performSelector:@selector(suspend)];
}





@end
