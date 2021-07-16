/*
 一. 给分类添加属性, 分类是无法定义属性的
 参考MJRefresh, 里面得到了充分利用
 主要函数:
 void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);

 id objc_getAssociatedObject(id object, const void *key);

 void objc_removeAssociatedObjects(id object);
 
 可以想象成NSMultableDictionary -->
 
 objc_setAssociatedObject 相当于 setValue:forKey 进行关联value对象

 objc_getAssociatedObject 用来读取对象

 objc_AssociationPolicy  属性 是设定该value在object内的属性，即 assgin, (retain,nonatomic)...等

  objc_removeAssociatedObjects 函数来移除一个关联对象，或者使用objc_setAssociatedObject函数将key指定的关联对象设置为nil。
 
 key：要保证全局唯一，key与关联的对象是一一对应关系。必须全局唯一。通常用@selector(methodName)作为key。
 value：要关联的对象。
 policy：关联策略。有五种关联策略。
 OBJC_ASSOCIATION_ASSIGN 等价于 @property(assign)。
 OBJC_ASSOCIATION_RETAIN_NONATOMIC等价于 @property(strong, nonatomic)。
 OBJC_ASSOCIATION_COPY_NONATOMIC等价于@property(copy, nonatomic)。
 OBJC_ASSOCIATION_RETAIN等价于@property(strong,atomic)。
 OBJC_ASSOCIATION_COPY等价于@property(copy, atomic)。
 
 
 
 */








#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
