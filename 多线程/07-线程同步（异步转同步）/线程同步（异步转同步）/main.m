/**
 下面程序的运行：
 semaphore 初始创建时计数为 0。
 异步执行 将 任务 1 追加到队列之后，不做等待，接着执行 dispatch_semaphore_wait 方法，semaphore 减 1，此时 semaphore == -1，当前线程进入等待状态。
 然后，异步任务 1 开始执行。任务 1 执行到 dispatch_semaphore_signal 之后，总信号量加 1，此时 semaphore == 0，正在被阻塞的线程（主线程）恢复继续执行。
 最后打印 semaphore---end,number = 100。
 这样就实现了线程同步，将异步执行任务转换为同步执行任务。

 作者：行走少年郎
 链接：https://www.jianshu.com/p/2d57c72016c6
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 线程同步：可理解为线程 A 和 线程 B 一块配合，A 执行到一定程度时要依靠线程 B 的某个结果，于是停下来，示意 B 运行；B 依言执行，再将结果给 A；A 再继续操作。
 
 */


#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
            NSLog(@"semaphore---begin");
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            
            __block int number = 0;
            dispatch_async(queue, ^{
                // 追加任务 1
                [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
                NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
                
                number = 100;
                
                dispatch_semaphore_signal(semaphore);
            });
            
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"semaphore---end,number = %zd",number);
    }
    return 0;
}
