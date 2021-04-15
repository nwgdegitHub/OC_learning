//
//  main.m
//  打印机-多态例子
//
//  Created by udc on 2021/4/2.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "BlackPrinter.h"
#import "ColorPrinter.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Person *person =[[Person alloc] init];
              
            ColorPrinter *colorPrint = [[ColorPrinter alloc] init];
            BlackPrinter *blackPrint = [[BlackPrinter alloc] init];
              
            //多态的定义
            /*
            Printer *p1 = [[ColorPrinter alloc] init];
            Printer *p2 = [[BlackPrinter alloc] init];
             
            [person doPrint:p1];
            [person doPrint:p2];
             */
              
            //通过控制台输入的命令来控制使用哪个打印机
            int cmd;
            do{
                scanf("%d",&cmd);
                if(cmd == 1){
                    [person doPrint:colorPrint];
                }else if(cmd == 2){
                    [person doPrint:blackPrint];
                }
            }while (1);
    }
    return 0;
}

//什么是多态？
//多态是面向对象的3大特征之一，多态是建立在继承的基础上的。
//多态的代码体现是父类指针指向子类对象。
//多态的好处是，不用定义多个函数来匹配相应的类型，你可以通过函数参数传入父类或者子类对象，最终调用会以实际对象为准。
//局限性就是，父类类型的对象不能直接调用子类的方法，如果想调用， 则必须强制转换。
