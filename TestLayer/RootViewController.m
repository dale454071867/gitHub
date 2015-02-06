//
//  RootViewController.m
//  TestLayer
//
//  Created by DL on 15/2/4.
//  Copyright (c) 2015年 DL. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CAAnimation+Tag.h"
#import "RootViewController2.h"
@interface RootViewController ()
{
    CALayer *layer;
}
@property (weak, nonatomic) IBOutlet UIView *anView;
@property (weak, nonatomic) IBOutlet UIImageView *rotatingView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.123213
//
//    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 1.0f;         /* 间隔时间*/
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; /* 动画的开始与结束的快慢*/
//    transition.type = @"rippleEffect"; /* 各种动画效果*/
//    //@"cube" @"moveIn" @"reveal" @"fade"(default) @"pageCurl" @"pageUnCurl" @"suckEffect" @"rippleEffect" @"oglFlip"
//    
//    transition.subtype = kCATransitionFromRight;   /* 动画方向*/
//    transition.delegate = self;
//    [self.view.layer /* 在想添加CA动画的VIEW的层上添加此代码*/addAnimation:transition forKey:nil];
}
//仿push
- (IBAction)beginAnimation:(id)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.6f;
    
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    
   
    transition.timingFunction = UIViewAnimationCurveEaseInOut;
    self.anView.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [self.view.layer addAnimation:transition forKey:@"animation"];
}
//旋转换图
- (IBAction)animation_two:(id)sender {
    [UIView beginAnimations:@"animationRotatingViewA" context:nil];
//    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.6f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.rotatingView cache:YES];
    NSArray *array = @[[UIImage imageNamed:@"icon-wifi3x"],[UIImage imageNamed:@"icon-dingdan-1"]];
    self.rotatingView.image = array[arc4random()%2];
    [UIView commitAnimations];
    
}
//
- (IBAction)animation_three:(id)sender {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = NO;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [self.rotatingView.layer addAnimation:rotationAnimation forKey:nil];
}
- (IBAction)stopRotationAnimation:(id)sender {
    [self.rotatingView.layer removeAllAnimations];
}
- (IBAction)animation_four:(id)sender {
    
    UIGraphicsBeginImageContext(self.rotatingView.frame.size);
    [self.rotatingView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    layer = [[CALayer alloc] initWithLayer:self.rotatingView.layer];
    layer.contents = (__bridge id)(image.CGImage);
    layer.frame = [[UIApplication sharedApplication].keyWindow convertRect:self.rotatingView.bounds fromView:self.rotatingView.superview];
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:layer];
    
    
    CGPoint fromPoint = self.rotatingView.center;
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint toPoint = CGPointMake(80, 400);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(fromPoint.x - 100,fromPoint.y -50)];
    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.duration = 0.6f;
    moveAnim.delegate = self;
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = YES;
    layer.position = CGPointMake(MAXFLOAT, MAXFLOAT);
    
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = @(0.1);
    scaleAnimation.duration  = 0.6f;
    scaleAnimation.autoreverses=NO;
    
    
    CAAnimationGroup *animaitionGroup = [CAAnimationGroup animation];
    animaitionGroup.animations = @[moveAnim,scaleAnimation];
    animaitionGroup.duration = 0.6f;
    animaitionGroup.tag = 100;
    animaitionGroup.delegate = self;
    animaitionGroup.removedOnCompletion = YES;
    animaitionGroup.layer = layer;
    [layer addAnimation:animaitionGroup forKey:@"animaitionGroup"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if([anim isKindOfClass:[CAAnimation class]] && anim.tag == 100)
    {
        [anim.layer removeFromSuperlayer];
    }
}
- (IBAction)animation_five:(id)sender {
    CAKeyframeAnimation *bounceAnimation  = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = @[@(1.3),@(0.8),@(1.2),@(0.9),@(1)];
    bounceAnimation.duration = 0.6;
    [self.rotatingView.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
