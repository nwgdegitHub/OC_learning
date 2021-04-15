/**
 
 dispatch_group_enter 标志着一个任务追加到 group，执行一次，相当于 group 中未执行完毕任务数 +1
 dispatch_group_leave 标志着一个任务离开了 group，执行一次，相当于 group 中未执行完毕任务数 -1。
 当 group 中未执行完毕任务数为0的时候，才会使 dispatch_group_wait 解除阻塞，以及执行追加到 dispatch_group_notify 中的任务。

 作者：行走少年郎
 链接：https://www.jianshu.com/p/2d57c72016c6
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 */
//  main.m
//  dispatch_group_enter和dispatch_group_leave
//
//  Created by udc on 2021/4/8.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
            NSLog(@"group---begin");
            
            dispatch_group_t group = dispatch_group_create();
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_group_enter(group);
            dispatch_async(queue, ^{
                // 追加任务 1
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程

                dispatch_group_leave(group);
            });
            
            dispatch_group_enter(group);
            dispatch_async(queue, ^{
                // 追加任务 2
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
                
                dispatch_group_leave(group);
            });
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                // 等前面的异步操作都执行完毕后，回到主线程.
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
            
                NSLog(@"group---end");
            });
    }
    return 0;
}
