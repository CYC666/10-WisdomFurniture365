//
//  EquipViewController.m
//  WisdomFurniture365
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "EquipViewController.h"

@implementation EquipViewController

- (void)viewDidLoad {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"equip"];
    [self.view addSubview:imageView];
 
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(65, 500, 245, 40);
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (BOOL)prefersStatusBarHidden {

    return YES;
}

// 二维码扫描
- (void)buttonAction:(UIButton *)button {

    NSLog(@"ssdsdsd");

}


@end
