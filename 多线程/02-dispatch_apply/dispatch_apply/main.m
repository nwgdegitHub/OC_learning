/**
 通常我们会用 for 循环遍历，但是 GCD 给我们提供了快速迭代的方法 dispatch_apply。
 dispatch_apply 按照指定的次数将指定的任务追加到指定的队列中，并等待全部队列执行结束。
 如果是在串行队列中使用 dispatch_apply，那么就和 for 循环一样，按顺序同步执行。但是这样就体现不出快速迭代的意义了。

 我们可以利用并发队列进行异步执行。比如说遍历 0~5 这 6 个数字，for 循环的做法是每次取出一个元素，逐个遍历。dispatch_apply 可以 在多个线程中同时（异步）遍历多个数字。

 还有一点，无论是在串行队列，还是并发队列中，dispatch_apply 都会等待全部任务执行完毕，这点就像是同步操作，也像是队列组中的 dispatch_group_wait方法。

 作者：行走少年郎
 链接：https://www.jianshu.com/p/2d57c72016c6
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */


#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            
            NSLog(@"apply---begin");
            dispatch_apply(6, queue, ^(size_t index) {
                NSLog(@"%zd---%@",index, [NSThread currentThread]);
            });
            NSLog(@"apply---end");
        
    }
    return 0;
}
