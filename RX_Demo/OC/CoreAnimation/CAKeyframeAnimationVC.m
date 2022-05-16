//
//  ViewController.m
//  CAKeyframeAnimation
//
//  Created by YJB on 2017/11/18.
//  Copyright © 2017年 YJB. All rights reserved.
//

#import "CAKeyframeAnimationVC.h"

@interface CAKeyframeAnimationVC ()
@property(nonatomic,weak)CALayer  *aniLayer;
@property(nonatomic,weak)CALayer *shipLayer;
@property(nonatomic,strong)UIBezierPath *bezierPath;
@property(nonatomic,weak)CALayer *rotationLayer;
@end

@implementation CAKeyframeAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLayer];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [self moveAnimation];
//    [self groupAnimation];
    
      [self rotationAnimation];
}


/**
 利用虚拟属性进行动画，原本transform.rotation属性是不存在的，也可以用transform.scale做缩小/放大动画
 */
- (void)rotationAnimation
{
//    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    containerView.backgroundColor = [UIColor greenColor];
//    containerView.center = self.view.center;
//    [self.view addSubview:containerView];
    
    if (self.rotationLayer == nil)
    {
        CALayer *rotationLayer = [CALayer layer];
        rotationLayer.frame = CGRectMake(0, 0, 128, 128);
        rotationLayer.position = self.view.center;
        self.rotationLayer = rotationLayer;
        //    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Ship.png"].CGImage;
        rotationLayer.backgroundColor = [UIColor greenColor].CGColor;
        [self.view.layer addSublayer:rotationLayer];
    }
   
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 8.0;
    //转4圈
    animation.byValue = @(M_PI * 8);
    [self.rotationLayer addAnimation:animation forKey:nil];
}

/**
 关键帧动画
 */
- (void)moveAnimation
{
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0;
    animation.path = self.bezierPath.CGPath;
    //让视图沿着相切路径的方向动画
    animation.rotationMode = kCAAnimationRotateAuto;
    [self.shipLayer addAnimation:animation forKey:nil];
}


/**
 组合动画
 */
- (void)groupAnimation
{
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation1.duration = 4.0;
    animation1.path = self.bezierPath.CGPath;
    //让视图沿着相切路径的方向动画
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    //这里的值不能直接用[UIColor blueColor]设置，必须这么设置，否则没效果
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    //create group animation
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1, animation2];
    groupAnimation.duration = 4.0;
    //add the animation to the color layer
    [self.shipLayer addAnimation:groupAnimation forKey:nil];
}

- (void)createLayer
{
    //create a path
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    self.bezierPath = bezierPath;
    [bezierPath moveToPoint:CGPointMake(20, 150)];
    [bezierPath addCurveToPoint:CGPointMake(320, 150) controlPoint1:CGPointMake(95, 0) controlPoint2:CGPointMake(245, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.view.layer addSublayer:pathLayer];
    //add the ship
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 64, 64);
    shipLayer.position = CGPointMake(0, 150);
    //    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"Ship.png"].CGImage;
    shipLayer.backgroundColor = [UIColor blueColor].CGColor;
    self.shipLayer = shipLayer;
    [self.view.layer addSublayer:shipLayer];
}

/**
 颜色动画
 */
- (void)changeColor
{
     CALayer *aniLayer = [[CALayer alloc] init];
    self.aniLayer = aniLayer;
    aniLayer.bounds = CGRectMake(0, 0, 100, 100);
    aniLayer.position = self.view.center;
    aniLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer addSublayer:aniLayer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 2.0;
    //为了动画的平滑特性，设置开始和结束的颜色是blueColor，因为动画一开始的时候是瞬间切换到第一颜色，然后开始动画改编颜色，关键帧动画不像基本动画，动画结束之后不会回复原来的颜色
    animation.values = @[
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor ];
    //apply animation to layer
    [aniLayer addAnimation:animation forKey:nil];
}


@end
