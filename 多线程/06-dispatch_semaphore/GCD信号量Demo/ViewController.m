/**
 1）dispatch_semaphore_create的声明为：
 　　dispatch_semaphore_t dispatch_semaphore_create(long value);
 　　传入的参数为long，输出一个dispatch_semaphore_t类型且值为value的信号量。
 　　值得注意的是，这里的传入的参数value必须大于或等于0，否则dispatch_semaphore_create会返回NULL。
 　　（关于信号量，我就不在这里累述了，网上很多介绍这个的。我们这里主要讲一下dispatch_semaphore这三个函数的用法）。

 （2）dispatch_semaphore_signal的声明为：
 　　long dispatch_semaphore_signal(dispatch_semaphore_t dsema)
 　　这个函数会使传入的信号量dsema的值加1；
 　　
 (3) dispatch_semaphore_wait的声明为：
 　　long dispatch_semaphore_wait(dispatch_semaphore_t dsema, dispatch_time_t timeout)；
 timeout
 DISPATCH_TIME_NOW　　表示当前；
 DISPATCH_TIME_FOREVER　　表示遥远的未来；
 也可以自己创建
 dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, 110001000*1000);
 　　　　　表示当前时间向后延时一秒为timeout的时间。


 作者：请叫我魔法师
 链接：https://www.jianshu.com/p/73470d7de082
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 不是所有并发请求都需要刷新tableView, 有可能有的请求需要同步数据，然后另一个请求需要等同步数据完成才会处理结果，但也不是需要依赖。
 详细例子参考：
 https://www.cnblogs.com/wangkejia/p/12600352.html#!comments
 
 */

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self dispatch_group_function1];
}

-(void)dispatch_group_function1
{
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(100);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0); //信号量初始化为0 ，可以进入主线程对UI刷新 当子线程分配了耗时任务，这时候dispatch_semaphore_wait 函数会消耗信号量 ，耗时任务结束，信号量会恢复+1
    
    
//    断点1
    //<OS_dispatch_semaphore: semaphore[0x600000cb8140] = { xref = 1, ref = 1, port = 0x0, value = 100, orig = 100 }>
    
    //这里为啥是0
    //这里的传入的参数value必须大于或等于0，否则dispatch_semaphore_create会返回NULL。
 
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_queue_create("com.dispatch.test", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 请求完成，可以通知界面刷新界面等操作
            NSLog(@"第一步网络请求完成");
            
            // 使信号的信号量+1，这里的信号量本来为0，+1信号量为1(绿灯)
            dispatch_semaphore_signal(semaphore);
            //    断点3
            //<OS_dispatch_semaphore: semaphore[0x600003a56b20] = { xref = 2, ref = 1, port = 0x0, value = 99, orig = 100 }>
        }];
        
        [task resume];
        
        // 以下还要进行一些其他的耗时操作
        NSLog(@"第一步网络请求----耗时操作继续进行%@",[NSThread currentThread]);
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        //    断点2
        //<OS_dispatch_semaphore: semaphore[0x600002b79680] = { xref = 4, ref = 1, port = 0x0, value = 98, orig = 100 }>
        
    });
    
    dispatch_group_async(group, queue, ^{
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.github.com"]];
        
        NSURLSessionDownloadTask *task = [[NSURLSession sharedSession] downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            // 请求完成，可以通知界面刷新界面等操作
            NSLog(@"第二步网络请求完成");
            
            // 使信号的信号量+1，这里的信号量本来为0，+1信号量为1(绿灯)
            dispatch_semaphore_signal(semaphore);
            //<OS_dispatch_semaphore: semaphore[0x600001894820] = { xref = 1, ref = 1, port = 0x0, value = 100, orig = 100 }>
        }];
        
        [task resume];
        
        // 以下还要进行一些其他的耗时操作
        NSLog(@"第二步网络请求----耗时操作继续进行%@",[NSThread currentThread]);
        
        dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);
        //断点2
        //<OS_dispatch_semaphore: semaphore[0x600001894820] = { xref = 6, ref = 1, port = 0x0, value = 98, orig = 100 }>
        
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"刷新界面等在主线程的操作");
    });
}


@end
