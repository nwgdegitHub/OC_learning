//
//  ViewController.m
//  多线程
//
//  Created by udc on 2021/7/13.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSThread *thread2;
@property (nonatomic, strong) NSThread *thread3;
 
/**
 *  剩余票数
 */
@property (nonatomic, assign) int leftTicketCount;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftTicketCount = 1000;
         
        self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
        self.thread1.name = @"1号窗口";
         
        self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
        self.thread2.name = @"2号窗口";
         
        self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
        self.thread3.name = @"3号窗口";
    
    //开售
        [self.thread1 start];
        [self.thread2 start];
        [self.thread3 start];
}

/**
 *  卖票 加锁了就不会出现线程安全问题
 *  不加锁就会出问题
 */
- (void)saleTicket
{
    while (1) {
        // ()小括号里面放的是锁对象
        @synchronized(self) { // 开始加锁
            int count = self.leftTicketCount;
            if (count > 0) {
                [NSThread sleepForTimeInterval:0.05];//睡一会，为了让不同线程抢夺统一资源问题更加明显
                 
                self.leftTicketCount = count - 1;
                 
                NSLog(@"%@卖了一张票, 剩余%d张票", [NSThread currentThread].name, self.leftTicketCount);
            } else {
                return; // 退出循环
            }
        } // 解锁
    }
}
@end
