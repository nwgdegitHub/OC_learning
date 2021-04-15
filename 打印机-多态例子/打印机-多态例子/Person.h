//
//  Person.h
//  打印机-多态例子
//
//  Created by udc on 2021/4/2.
//

#import <Foundation/Foundation.h>
#import "Printer.h"
#import "ColorPrinter.h"
#import "BlackPrinter.h" 
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject{
    NSString *_name;
}
- (void)doPrint:(Printer *)printer;
@end

NS_ASSUME_NONNULL_END
