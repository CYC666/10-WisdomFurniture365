//
//  MineViewController.m
//  WisdomFurniture365
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "MineViewController.h"

@implementation MineViewController

- (void)viewDidLoad {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"mine"];
    [self.view addSubview:imageView];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 58, 375, 545)];
    scrollView.contentSize = CGSizeMake(375, 545);
    scrollView.alwaysBounceVertical = YES;
    scrollView.backgroundColor = [UIColor colorWithRed:239/255.5 green:239/255.5 blue:239/255.5 alpha:1];
    [self.view addSubview:scrollView];
    
    UIImageView *imageViewS = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 545)];
    imageViewS.image = [UIImage imageNamed:@"mine1"];
    [scrollView addSubview:imageViewS];
    
    
    
    
}

@end
