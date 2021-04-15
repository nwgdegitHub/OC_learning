/**
 有时候我们会有这样的需求：分别异步执行2个耗时任务，然后当2个耗时任务都执行完毕后再回到主线程执行任务。这时候我们可以用到 GCD 的队列组。
 */
//  main.m
//  dispatch_group
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
            
        //dispatch_group_notify相当于监听 队列组
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                // 等前面的异步任务 1、任务 2 都执行完毕后，回到主线程执行下边任务
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程

                NSLog(@"group---end");
            });
    }
    return 0;
}
