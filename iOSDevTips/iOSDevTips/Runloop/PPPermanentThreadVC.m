//
//  PPPermanentThreadVC.m
//  iOSDevTips
//
//  Created by panwei on 2020/4/20.
//  Copyright © 2020 WeirdPan. All rights reserved.
//  https://github.com/wooodypan/iOSDeveloperBlogArchieve/tree/master/Objc/%E5%B8%B8%E9%A9%BB%E7%BA%BF%E7%A8%8B%E6%98%AF%E4%B8%80%E7%A7%8D%E4%BB%80%E4%B9%88%E4%BD%93%E9%AA%8C

#import "PPPermanentThreadVC.h"

@interface PPPermanentThreadVC ()

@end

@implementation PPPermanentThreadVC

- (void)dealloc {
    
    NSLog(@"veryitman---MZCreatePermanentThreadController dealloc.");
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.title = @"创建常驻线程";
    
    // 启动线程
    [self permanentThread];
}
- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    // 取消线程
    // 实际业务场景中自行决定 canCancel 的设置, 这里只是示例
    BOOL canCancel = YES;
    if (canCancel) {
        [[self permanentThread] cancel];
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 模拟在指定线程上面再次执行方法
    SEL seltor = NSSelectorFromString(@"runAnyTime");
    
    [self performSelector:seltor onThread:[self permanentThread] withObject:nil waitUntilDone:NO];
}
- (NSThread *)permanentThread {
    
    static NSThread *thread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        thread = [[NSThread alloc] initWithTarget:self selector:@selector(asyncRun) object:nil];
        [thread setName:@"veryitman-thread"];
        
        // 同一个线程连续多次 start 会导致 crash
        [thread start];
    });
    
    return thread;
}
- (void)asyncRun {
    
    @autoreleasepool {
        
        NSLog(@"veryitman--asyncRun. Current Thread: %@", [NSThread currentThread]);
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        // 添加 source
        NSPort *port = [NSMachPort port];
        [runLoop addPort:port forMode:NSRunLoopCommonModes];
        
        NSLog(@"veryitman--asyncRun. Current RunLoop: %@", runLoop);
        
        // 执行其他逻辑
        //...
        
        // 手动开启 RunLoop
        [runLoop run];
        
        NSLog(@"veryitman--asyncRun. End Run.");
    }
}
- (void)runAnyTime {
    
    NSLog(@"veryitman--runAnyTime. Current Thread: %@", [NSThread currentThread]);
}

- (void)asyncRun00000001 {
    
    @autoreleasepool {
        
        NSLog(@"veryitman--asyncRun. Current Thread: %@", [NSThread currentThread]);
        
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        
        // 添加 source
        NSPort *port = [NSMachPort port];
        [runLoop addPort:port forMode:NSRunLoopCommonModes];
        
        NSLog(@"veryitman--asyncRun. Current RunLoop: %@", runLoop);
        
        // 执行其他逻辑
        //...
        
        // 手动开启 RunLoop
        [runLoop run];
        
        NSLog(@"veryitman--asyncRun. End Run.");
    }
}
@end
