/**
 暂停当前线程（阻塞当前线程），等待指定的 group 中的任务执行完成后，才会往下继续执行。
 
 
 */
//  main.m
//  dispatch_group_wait
//
//  Created by udc on 2021/4/8.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
            NSLog(@"group---begin");
            
            dispatch_group_t group =  dispatch_group_create();
            
            dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 追加任务 1
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
            });
            
            dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                // 追加任务 2
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
            });
            
            // 等待上面的任务全部完成后，会往下继续执行（会阻塞当前线程）
            dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
            
            NSLog(@"group---end");
    }
    return 0;
}
