//
//  ViewController.m
//  常见的几种锁
//
//  Created by YJB on 2017/11/9.
//  Copyright © 2017年 YJB. All rights reserved.
//

//#import "ViewController.h"
//#import <pthread.h>
//
//@interface ViewController ()
//@property(nonatomic,assign)NSInteger tickets;
//@property(nonatomic,strong)dispatch_queue_t  concurrentQueue;
//@property(nonatomic,strong)NSLock  *mutexLock;
//@property(nonatomic,strong)NSRecursiveLock  *rsLock;
//@property(nonatomic,strong)NSConditionLock *theLock;
//@property(nonatomic,assign)pthread_mutex_t mutex;;
//@end
//
//@implementation ViewController
///**
// @synchronized
// NSLock 对象锁
// NSRecursiveLock 递归锁
// NSConditionLock 条件锁
// pthread_mutex 互斥锁（C语言）
// dispatch_semaphore 信号量实现加锁（GCD）
// OSSpinLock 自旋锁（暂不建议使用，会发生反转）
// */
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.mutexLock = [[NSLock alloc] init];
//    self.concurrentQueue = dispatch_queue_create("com.zddw.yjb", DISPATCH_QUEUE_CONCURRENT);
//    //设置票的数量为5
////    _tickets = 5;
////    dispatch_async(self.concurrentQueue, ^{
////        [self saleTickets1];
////    });
////    dispatch_async(self.concurrentQueue, ^{
////        [self saleTickets1];
////    });
//
////    [self testRecursiveLock];
////    [self testConditionLock];
//      [self testpthread_mutex];
//}
//
////递归锁:解决NSLock在同一线程中多次调用lock造成的死锁问题
//- (void)testRecursiveLock
//{
//    _rsLock = [[NSRecursiveLock alloc] init];
//    dispatch_async(self.concurrentQueue, ^{
//        static void(^TestMethod)(int);
//        TestMethod = ^(int value)
//        {
//            [_rsLock lock];
//            if (value > 0)
//            {
//                [NSThread sleepForTimeInterval:1];
//                NSLog(@" ====== 递归锁测试");
//                TestMethod(--value);
//            }
//            [_rsLock unlock];
//        };
//
//        TestMethod(5);
//    });
//}
//
////条件锁
//- (void)testConditionLock
//{
//    //主线程中
//    _theLock = [[NSConditionLock alloc] init];
//    //线程1
//    dispatch_async(self.concurrentQueue, ^{
//        //这里i的范围大于2的时候，可能会由于循环太快以至于锁一直处于使用中，导致线程2中的锁无法获得
//        for (int i=0;i<=2;i++)
//        {
//            [_theLock lock];
//            NSLog(@"thread1:%d",i);
//            sleep(1);
//            [_theLock unlockWithCondition:i];
//        }
//    });
//    //线程2
//    dispatch_async(self.concurrentQueue, ^{
//        //获得锁的条件是，内部的condition的值为2，并且该锁没有被使用
//            [_theLock lockWhenCondition:2];
//            NSLog(@"thread2");
//            [_theLock unlock];
//    });
//}
//
////互斥锁:注意使用完之后进行销毁
//- (void)testpthread_mutex
//{
//    pthread_mutex_init(&_mutex, NULL);
//    //线程1
//    dispatch_async(self.concurrentQueue, ^{
////        pthread_mutex_trylock(&mutex);尝试加锁，如果加锁成功，返回0，加锁失败返回非0值，加锁失败不会阻塞当前线程
//        pthread_mutex_lock(&_mutex);
//        NSLog(@"任务1");
//        sleep(2);
//        pthread_mutex_unlock(&_mutex);
//    });
//
//    //线程2
//    dispatch_async(self.concurrentQueue, ^{
//        sleep(1);
//        pthread_mutex_lock(&_mutex);
//        NSLog(@"任务2");
//        pthread_mutex_unlock(&_mutex);
//    });
//}
////c级别的锁，需要程序员自己释放内存
//- (void)dealloc
//{
//    pthread_mutex_destroy(&_mutex);
//}
//
//- (void)testsemaphore
//{
//    // 创建信号量
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    //线程1
//  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        NSLog(@"任务1");
//        sleep(10);
//        dispatch_semaphore_signal(semaphore);
//    });
//
//    //线程2
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        sleep(1);
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        NSLog(@"任务2");
//        dispatch_semaphore_signal(semaphore);
//    });
//}
//
////@synchronized(),性能最差
//- (void)saleTickets
//{
//    while (1)
//    {
//        @synchronized(self) {
//            [NSThread sleepForTimeInterval:1];
//            if (_tickets > 0) {
//                _tickets--;
//                NSLog(@"剩余票数= %ld, Thread:%@",_tickets,[NSThread currentThread]);
//            } else {
//                NSLog(@"票卖完了  Thread:%@",[NSThread currentThread]);
//                break;
//            }
//        }
//    }
//}
//
////对象锁NSLock
//- (void)saleTickets1
//{
////    tryLock试图获取一个锁，但是如果锁不可用的时候，它不会阻塞线程，相反，它只是返回NO。
////lockBeforeDate:方法试图获取一个锁，但是如果锁没有在规定的时间内被获得，它会让线程从阻塞状态变为非阻塞状态（或者返回NO）。
//    while (1) {
//        [NSThread sleepForTimeInterval:1];
//        //加锁
//        [_mutexLock lock];
//        //同一线程，不能多次调用 lock方法,会造成死锁
////        [_mutexLock lock];
//        if (_tickets > 0) {
//            _tickets--;
//            NSLog(@"剩余票数= %ld, Thread:%@",_tickets,[NSThread currentThread]);
//        } else {
//            NSLog(@"票卖完了  Thread:%@",[NSThread currentThread]);
//            break;
//        }
//        [_mutexLock unlock];
//    }
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSLog(@" ======= 点击屏幕");
//}
//
//@end
//


#import "ViewController.h"
//test-click-delegate
@protocol TestClickHelperDelegate <NSObject>
- (void)didEnd;
@end

//interface
@interface TestClickHelper : NSObject
@property (nonatomic, weak) id <TestClickHelperDelegate>delegate;
@property (nonatomic, copy) NSString *title;
- (void)start;
@end

@implementation TestClickHelper
- (void)start {
    if (self.delegate) {
        [self.delegate didEnd];
    }
    self.title = @"ttt";
}
@end


@interface ViewController ()<TestClickHelperDelegate>
@property (nonatomic) TestClickHelper *helper;
@end


@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    _helper = TestClickHelper.new;
    _helper.delegate = self;
//    [self performSelector:@selector(start) withObject:nil afterDelay:3];
    [self start];
}
- (void)start {
    [_helper start];
}
#pragma mark - TestClickHelperDelegate
- (void)didEnd {
    self.helper = nil;
}

@end


