//
//  ViewController.m
//  bluetooth111
//
//  Created by SLB on 2018/1/23.
//  Copyright © 2018年 SLB. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "UIView+YSTransform.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConstract;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) UIView *iimageview11;
@property (nonatomic, strong) dispatch_source_t timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _iimageview11 = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    _iimageview11.backgroundColor = [UIColor redColor];
//    [self.view addSubview:_iimageview11];
    
    
//    CALayer *myLayer = [CALayer layer];
//    // 设置层的宽度和高度（100x100）
//    myLayer.bounds = CGRectMake(0, 0, 100, 100);
//    // 设置层的位置
//    myLayer.position = CGPointMake(100, 100);
//    myLayer.anchorPoint = CGPointMake(1, 1);
//    // 设置层的背景颜色：红色
//    myLayer.backgroundColor = [UIColor redColor].CGColor;
//
//    // 添加myLayer到控制器的view的layer中
//    [self.view.layer addSublayer:myLayer];
    
    //anchorPoint中：X越大view越靠左，Y越大月靠上
//    self.iimageview11.layer.anchorPoint = CGPointMake(1, 1);

    self.view.backgroundColor = [UIColor lightGrayColor];
//    [self checkFillRule];
    
    [self makePaoPao];
}

-(void)makePaoPao {
    CAShapeLayer* dashLineShapeLayer = [CAShapeLayer layer];
    //创建贝塞尔曲线
    UIBezierPath* dashLinePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 200, 100) cornerRadius:20];
    dashLineShapeLayer.path = dashLinePath.CGPath;
    dashLineShapeLayer.position = CGPointMake(100, 100);
    dashLineShapeLayer.fillColor = [UIColor clearColor].CGColor;
    dashLineShapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    dashLineShapeLayer.lineWidth = 3;
    dashLineShapeLayer.lineDashPattern = @[@(6),@(6)];
    dashLineShapeLayer.strokeStart = 0;
    dashLineShapeLayer.strokeEnd = 1;
    dashLineShapeLayer.zPosition = 999;
    [self.view.layer addSublayer:dashLineShapeLayer];

    //
    NSTimeInterval delayTime = 0.3f;
    //定时器间隔时间
    NSTimeInterval timeInterval = 0.1f;
    //创建子线程队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //使用之前创建的队列来创建计时器
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //设置延时执行时间，delayTime为要延时的秒数
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
    //设置计时器
    dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        //执行事件
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            CGFloat _add = 3;
            dashLineShapeLayer.lineDashPhase -= _add;
        });
    });
    // 启动计时器
    dispatch_resume(_timer);

    
}

-(void)checkFillRule{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint circleCenter = self.view.center;
    [path moveToPoint:CGPointMake(circleCenter.x + 40, circleCenter.y)];
    [path addArcWithCenter:circleCenter radius:40 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(circleCenter.x + 80, circleCenter.y)];
    [path addArcWithCenter:circleCenter radius:80 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(circleCenter.x + 120, circleCenter.y)];
//    [path addArcWithCenter:circleCenter radius:120 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(circleCenter.x + 160, circleCenter.y)];
//    [path addArcWithCenter:circleCenter radius:160 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor greenColor].CGColor;
    shapeLayer.fillRule = kCAFillRuleNonZero;
//    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinBevel;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    
    //add it to our view
    [self.view.layer addSublayer:shapeLayer];
    
    
    UIBezierPath* bezierPath_rect = [UIBezierPath bezierPathWithRect:CGRectMake(30, 50, 50, 50)];
    bezierPath_rect.lineWidth = 10;
    
    CAShapeLayer* shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.path = bezierPath_rect.CGPath;
    shapeLayer1.fillColor = [UIColor redColor].CGColor;
    shapeLayer1.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer1.lineWidth = 10;
    shapeLayer1.strokeStart = 0.1;
    shapeLayer1.strokeEnd = 0.4;
//    shapeLayer1.lineJoin = kCALineJoinMiter;
//    shapeLayer1.miterLimit = 0.5;
    [self.view.layer addSublayer:shapeLayer1];
    
    
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [UIView animateWithDuration:3.0 animations:^{
//
//        self.iimageview11.transform = CGAffineTransformMakeRotation(M_PI);
//    } completion:^(BOOL finished) {
//
//    }];
    
    

    
//    UITouch *tuch = touches.anyObject;
//    CGPoint point = [tuch locationInView:self.view];
//
//    [UIView beginAnimations:@"testAnimation" context:nil];
//    [UIView setAnimationDuration:3.0];
//    [UIView setAnimationDelegate:self];
//    //设置动画将开始时代理对象执行的SEL
//    [UIView setAnimationWillStartSelector:@selector(animationDoing)];
//
//    //设置动画延迟执行的时间
//    [UIView setAnimationDelay:0];
//
//    [UIView setAnimationRepeatCount:MAXFLOAT];
//    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//    //设置动画是否继续执行相反的动画
//    [UIView setAnimationRepeatAutoreverses:NO];
//    self.iimageview11.center = point;
    
    //
//    self.iimageview11.transform = CGAffineTransformMakeScale(1.5, 1.5);
//    self.iimageview11.transform = CGAffineTransformMakeRotation(M_PI);
    
    //设置视图的过渡效果
    /* 第一个参数：UIViewAnimationTransition的枚举值如下
     UIViewAnimationTransitionNone,              //不使用动画
     UIViewAnimationTransitionFlipFromLeft,      //从左向右旋转翻页
     UIViewAnimationTransitionFlipFromRight,     //从右向左旋转翻页
     UIViewAnimationTransitionCurlUp,            //从下往上卷曲翻页
     UIViewAnimationTransitionCurlDown,          //从上往下卷曲翻页
     第二个参数：需要过渡效果的View
     第三个参数：是否使用视图缓存，YES：视图在开始和结束时渲染一次；NO：视图在每一帧都渲染*/
    
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.iimageview11 cache:YES];
//    [UIView commitAnimations];
    
    
    
    
    
    
//    if (_leadingConstract.constant >= self.view.frame.size.width-self.label1.frame.size.width) {
//        _leadingConstract.constant = 0;
//    }else {
//        _leadingConstract.constant += 100;
//    }
//
//    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
//        [self.view layoutIfNeeded]; //立即实现布局
//    } completion:^(BOOL finished) {
//
//    }];
    

    
//    // 1.判断平台是否可用
//    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
//        NSLog(@"查看您是否设置了新浪微博帐号,设置界面-->新浪微博-->配置帐号");
//    }
//
//    // 2.创建SLComposeViewController
//    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
//
//    // 2.1.添加分享文字
//    [composeVc setInitialText:@"做人如果没有梦想,跟咸鱼有什么区别"];
//
//    // 2.2.添加分享图片
//    [composeVc addImage:[UIImage imageNamed:@"xingxing"]];
//
//    // 3.弹出分享界面
//    [self presentViewController:composeVc animated:YES completion:nil];
//
//
//    // 4.设置block属性
//    composeVc.completionHandler = ^ (SLComposeViewControllerResult result) {
//        if (result == SLComposeViewControllerResultCancelled) {
//            NSLog(@"用户点击了取消");
//        } else {
//            NSLog(@"用户点击了发送");
//        }
//    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
