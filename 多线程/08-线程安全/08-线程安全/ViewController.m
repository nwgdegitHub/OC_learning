//
//  ViewController.m
//  08-线程安全
//
//  Created by udc on 2021/4/8.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
//    [self initTicketStatusNotSave];
    
    [self initTicketStatusSave];
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

/**
 * 非线程安全：不使用 semaphore
 * 初始化火车票数量、卖票窗口（非线程安全）、并开始卖票
 */
//- (void)initTicketStatusNotSave {
//    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
//    NSLog(@"semaphore---begin");
//
//    self.ticketSurplusCount = 50;
//
//    // queue1 代表北京火车票售卖窗口
//    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue1", DISPATCH_QUEUE_SERIAL);
//    // queue2 代表上海火车票售卖窗口
//    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue2", DISPATCH_QUEUE_SERIAL);
//
//    __weak typeof(self) weakSelf = self;
//    dispatch_async(queue1, ^{
//        [weakSelf saleTicketNotSafe];
//    });
//
//    dispatch_async(queue2, ^{
//        [weakSelf saleTicketNotSafe];
//    });
//}

/**
 * 售卖火车票（非线程安全）
 */
//- (void)saleTicketNotSafe {
//    while (1) {
//
//        if (self.ticketSurplusCount > 0) {  // 如果还有票，继续售卖
//            self.ticketSurplusCount--;
//            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
//            [NSThread sleepForTimeInterval:0.2];
//        } else { // 如果已卖完，关闭售票窗口
//            NSLog(@"所有火车票均已售完");
//            break;
//        }
//
//    }
//}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 * 线程安全：使用 semaphore 加锁
 * 初始化火车票数量、卖票窗口（线程安全）、并开始卖票
 */
- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"semaphore---begin");
    
    semaphoreLock = dispatch_semaphore_create(1); //这里初始化必须传1 一个任务会用到一个信号量， 信号量为0时或者大于0时绿灯
    
    self.ticketSurplusCount = 50;
    
    // queue1 代表北京火车票售卖窗口
    dispatch_queue_t queue1 = dispatch_queue_create("net.bujige.testQueue1", DISPATCH_QUEUE_SERIAL);
    // queue2 代表上海火车票售卖窗口
    dispatch_queue_t queue2 = dispatch_queue_create("net.bujige.testQueue2", DISPATCH_QUEUE_SERIAL);
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(queue1, ^{
        [weakSelf saleTicketSafe];
    });
    
    dispatch_async(queue2, ^{
        [weakSelf saleTicketSafe];
    });
}

/**
 * 售卖火车票（线程安全）
 */
- (void)saleTicketSafe {
    while (1) {
        NSLog(@"saleTicketSafe-------------->");
//        NSLog(@"%@",semaphoreLock);
//        <OS_dispatch_semaphore: semaphore[0x6000031eead0] = { xref = 1, ref = 1, port = 0xa31f, value = -1, orig = 1 }>
        // 相当于加锁
        dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
        
        if (self.ticketSurplusCount > 0) {  // 如果还有票，继续售卖
            self.ticketSurplusCount--;
            NSLog(@"%@", [NSString stringWithFormat:@"剩余票数：%d 窗口：%@", self.ticketSurplusCount, [NSThread currentThread]]);
            [NSThread sleepForTimeInterval:0.2];
        } else { // 如果已卖完，关闭售票窗口
            NSLog(@"所有火车票均已售完");
            
            // 相当于解锁
            dispatch_semaphore_signal(semaphoreLock);
            break;
        }
        
        // 相当于解锁
        dispatch_semaphore_signal(semaphoreLock);
    }
}
@end
