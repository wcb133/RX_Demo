//
//  ViewController.m
//  core animation
//
//  Created by YJB on 2017/11/9.
//  Copyright © 2017年 YJB. All rights reserved.
//

#import "CABasicAnimationVC.h"

@interface CABasicAnimationVC ()<CAAnimationDelegate>
@property(nonatomic,strong)CALayer  *aniLayer;
@end

#define buttonName @[@"位移",@"缩放",@"透明度",@"旋转",@"圆角"]
@implementation CABasicAnimationVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.aniLayer = [[CALayer alloc] init];
    _aniLayer.bounds = CGRectMake(0, 0, 100, 100);
    _aniLayer.position = self.view.center;
    _aniLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_aniLayer];
    //
    for (int i = 0; i < 5; i++) {
        UIButton *aniButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aniButton.tag = i;
        [aniButton setTitle:buttonName[i] forState:UIControlStateNormal];
        aniButton.exclusiveTouch = YES;
        aniButton.frame = CGRectMake(10, 50 + 60 * i, 100, 50);
        aniButton.backgroundColor = [UIColor blueColor];
        [aniButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aniButton];
    }
}
-(void)tapAction:(UIButton*)button{
    [self basicAnimationWithTag:button.tag];
}

-(void)basicAnimationWithTag:(NSInteger)tag{
    CABasicAnimation *basicAni = nil;
    switch (tag) {
        case 0:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"position"];
            //到达位置
            basicAni.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
            break;
        case 1:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            //到达缩放
            basicAni.toValue = @(0.1f);
            break;
        case 2:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
            //透明度
            basicAni.toValue=@(0.1f);
            break;
        case 3:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"transform"];
            //3D
            basicAni.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2+M_PI_4, 1, 1, 0)];
            break;
        case 4:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
            //圆角
            basicAni.toValue=@(50);
            break;
            
        default:
            break;
    }
    
    //设置代理
    basicAni.delegate = self;
    //延时执行
    //basicAni.beginTime = CACurrentMediaTime() + 2;
    //动画时间
    basicAni.duration = 3;
    //动画节奏
    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画速率
    //basicAni.speed = 0.1;
    //图层会保持显示动画执行后的状态。但在实质上，图层的属性值还是动画执行前的初始值，并没有真正被改变，所以不建议使用removedOnCompletion配合fillMode的方式来实现动画结束时，图层不跳转回原位的实现
//    basicAni.removedOnCompletion = NO;
//    basicAni.fillMode = kCAFillModeForwards;
    //动画完成后是否以动画形式回到初始值,默认为NO,设置为NO，并且配合动画结束的代理方法即可实现图层不跳转回原位
    basicAni.autoreverses = NO;
    //动画时间偏移
    //basicAni.timeOffset = 0.5;
    //添加动画
    [_aniLayer addAnimation:basicAni forKey:NSStringFromSelector(_cmd)];
}
//暂停动画
-(void)animationPause{
    //获取当前layer的动画媒体时间
    CFTimeInterval interval = [_aniLayer convertTime:CACurrentMediaTime() toLayer:nil];
    //设置时间偏移量,保证停留在当前位置
    _aniLayer.timeOffset = interval;
    //暂定动画
    _aniLayer.speed = 0;
}
//恢复动画
-(void)animationResume{
    //获取暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime() - _aniLayer.timeOffset;
    //设置偏移量
    _aniLayer.timeOffset = 0;
    //设置开始时间
    _aniLayer.beginTime = beginTime;
    //开始动画
    _aniLayer.speed = 1;
}
//停止动画
-(void)animationStop{
    //[_aniLayer removeAllAnimations];
    //[_aniLayer removeAnimationForKey:@"groupAnimation"];
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{
   
}

-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    //set the backgroundColor property to match animation toValue
    if ([anim.keyPath isEqualToString:@"position"]) {
        //开启一个事务，并且禁用该事务的隐式动画
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.aniLayer.position = CGPointMake(self.view.center.x + 100, self.view.center.y + 100);
        [CATransaction commit];
    }
}

@end
