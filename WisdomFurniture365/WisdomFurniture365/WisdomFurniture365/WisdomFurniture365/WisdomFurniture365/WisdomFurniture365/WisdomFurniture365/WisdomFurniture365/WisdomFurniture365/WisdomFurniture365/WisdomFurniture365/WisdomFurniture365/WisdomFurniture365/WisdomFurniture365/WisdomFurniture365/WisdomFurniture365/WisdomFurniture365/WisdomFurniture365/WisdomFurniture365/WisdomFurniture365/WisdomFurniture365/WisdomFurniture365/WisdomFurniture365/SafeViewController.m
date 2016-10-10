//
//  SafeViewController.m
//  WisdomFurniture365
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "SafeViewController.h"

@interface SafeViewController () {

    UIImageView *_imageView3;
    UIImageView *_imageView4;
    UIImageView *_imageView5;

    
}

@end

@implementation SafeViewController

- (void)viewDidLoad {
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView1.image = [UIImage imageNamed:@"safe1"];
    [self.view addSubview:imageView1];
    
    
    _imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 168, 375, 375)];
    _imageView3.image = [UIImage imageNamed:@"safe3"];
    [self.view addSubview:_imageView3];
    
    _imageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 168, 375, 375)];
    _imageView4.image = [UIImage imageNamed:@"safe4"];
    [self.view addSubview:_imageView4];
    

    
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView2.image = [UIImage imageNamed:@"safe2"];
    imageView2.userInteractionEnabled = YES;
    [self.view addSubview:imageView2];
    // 添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [imageView2 addGestureRecognizer:tap];
    
    CABasicAnimation *animationA =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animationA.fromValue = [NSNumber numberWithFloat:0.f];
    animationA.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animationA.duration  = 6;
    animationA.autoreverses = NO;
    animationA.fillMode =kCAFillModeForwards;
    animationA.repeatCount = 0;
    [_imageView3.layer addAnimation:animationA forKey:nil];
    
    CABasicAnimation *animationB =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animationB.fromValue = [NSNumber numberWithFloat: M_PI *2];
    animationB.toValue = [NSNumber numberWithFloat:0.f];
    animationB.duration  = 6;
    animationB.autoreverses = NO;
    animationB.fillMode =kCAFillModeForwards;
    animationB.repeatCount = 0;
    [_imageView4.layer addAnimation:animationB forKey:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:6
                                     target:self
                                   selector:@selector(timerAction:)
                                   userInfo:nil
                                    repeats:YES];
    
    
   
    
    
}


- (void)timerAction:(NSTimer *)timer {

    
    CABasicAnimation *animationA =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animationA.fromValue = [NSNumber numberWithFloat:0.f];
    animationA.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animationA.duration  = 6;
    animationA.autoreverses = NO;
    animationA.fillMode =kCAFillModeForwards;
    animationA.repeatCount = 0;
    [_imageView3.layer addAnimation:animationA forKey:nil];
    
    CABasicAnimation *animationB =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animationB.fromValue = [NSNumber numberWithFloat: M_PI *2];
    animationB.toValue = [NSNumber numberWithFloat:0.f];
    animationB.duration  = 6;
    animationB.autoreverses = NO;
    animationB.fillMode =kCAFillModeForwards;
    animationB.repeatCount = 0;
    [_imageView4.layer addAnimation:animationB forKey:nil];
    

}


- (void)tapAction:(UITapGestureRecognizer *)tap {

    _imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"safe5"]];
    _imageView5.frame = CGRectMake(0, 0, 375, 667);
    _imageView5.transform = CGAffineTransformMakeScale(.5, .5);
    _imageView5.alpha = 0;
    _imageView5.userInteractionEnabled = YES;
    [self.view addSubview:_imageView5];
    
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(20, 480, 335, 50);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_imageView5 addSubview:button];

    
    // 添加进场动画
    [UIView transitionWithView:_imageView5
                      duration:.1
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        
                        _imageView5.alpha = 1;
                        _imageView5.transform = CGAffineTransformMakeScale(1.1, 1.1);
                        
                    } completion:^(BOOL finished) {
                        [UIView transitionWithView:_imageView5
                                          duration:.1
                                           options:UIViewAnimationOptionTransitionNone
                                        animations:^{
                                            _imageView5.transform = CGAffineTransformMakeScale(.9, .9);
                                        } completion:^(BOOL finished) {
                                            [UIView animateWithDuration:.15
                                                             animations:^{
                                                                 _imageView5.transform = CGAffineTransformMakeScale(1, 1);
                                                             }];
                                        }];
                    }];
    
    
}


- (void)buttonAction:(UIButton *)button {

    [UIView transitionWithView:_imageView5
                      duration:.35
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        _imageView5.alpha = 0;
                    } completion:^(BOOL finished) {
                        _imageView5 = nil;
                    }];
    

}


- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
    
}




@end
