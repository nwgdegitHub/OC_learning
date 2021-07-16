//
//  main.m
//  多线程
//
//  Created by udc on 2021/4/7.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}


/**
 
 谈谈多线程?
 
 1.  在系统中正在运行的一个应用程序称之为进程，每个进程之间是独立的，每个进程均运行在其专用且受保护的内存空间内。
 2. 一个进程要想执行任务，必须得有线程（每1个进程至少要有1条线程）线程是进程的基本执行单元，一个进程（程序）的所有任务都在线程中执行
 比如使用酷狗播放音乐、使用迅雷下载电影，都需要在线程中执行

 3. 如果想在1条线程执行多个任务，比如下载文件1，文件2，文件3，...那么只能一个一个地按顺序执行这些任务

 4. 当一个进程开启了多条线程，那么每条线程就可以执行不同的任务，这样就提高了程序的执行效率

 同一时间，CPU只能处理1条线程，只有1条线程在工作（执行），多线程并发（同时）执行，其实是CPU快速地在多条线程之间调度（切换）
 如果CPU调度线程的时间足够快，就造成了多线程并发执行的假象。
 线程越多，CPU在调度线程上的开销就越大。这也是多线程的优缺点。

 5.在iOS中一个iOS程序运行后，默认会开启1条线程，称为“主线程”或“UI线程”。
 主线程的主要作用：
 显示\刷新UI界面
 处理UI事件（比如点击事件、滚动事件、拖拽事件等）
 所以耗时操作不能放在主线程。

 6.现在iOS中用的最多的是GCD , 是 Apple 开发的一个多核编程的较新的解决方法。代码编写简单。
 
 
 
 
 『GCD』详尽总结：https://www.jianshu.com/p/2d57c72016c6
 
 GCD的使用步骤：
 1. 创建队列（串行队列或并发队列）
 2. 将任务追加到任务的等待队列中，然后系统就会根据任务类型执行任务（同步执行或异步执行）。

 两种特殊的队列：
 1.『主队列（Main Dispatch Queue）』，实质上就是一个普通的串行队列 。dispatch_queue_t queue = dispatch_get_main_queue();
 2. 『全局并发队列（Global Dispatch Queue）』 。dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 第一个参数表示队列优先级，一般用 DISPATCH_QUEUE_PRIORITY_DEFAULT。第二个参数暂时没用，用 0 即可。
 
 创建任务的方法：
 // 1.同步执行任务创建方法
 dispatch_sync(queue, ^{
     // 这里放同步执行任务代码
 });
 // 2.异步执行任务创建方法
 dispatch_async(queue, ^{
     // 这里放异步执行任务代码
 });
 
 四种组合：
 1.同步执行 + 并发队列
 2.异步执行 + 并发队列
 3.同步执行 + 串行队列
 4.异步执行 + 串行队列
 
 另外：    如果将同步任务放到主队列，那么会造成死锁
        如果将异步任务放到主队列，那么不会 开启新线程，会串行执行任务
 
 
 线程间的通信：
 当我们在子线程完成了相应任务，就需要回到主线程，那么就用到了线程之间的通讯。
 
        // 获取全局并发队列
     dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        // 获取主队列
     dispatch_queue_t mainQueue = dispatch_get_main_queue();
 
     dispatch_async(queue, ^{
         // 异步追加任务 1
         [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
         NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
         
         // 回到主线程
         dispatch_async(mainQueue, ^{
                一般会刷新tableView
         });
     });
 
当然这只是开发中常用的一些，GCD还有很多其他内容。
 
 dispatch_after
 dispatch_once
 dispatch_semaphore
 ...

 
 
 */

//例子不要运行在macOS命令行 这样模拟不了多线程

