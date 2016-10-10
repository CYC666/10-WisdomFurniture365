//
//  EquipViewController.m
//  WisdomFurniture365
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "EquipViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanCodeViewController.h"
#import "PHCProductionCode.h"

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

    //1.AVAuthorizationStatus返回支持给定媒体类型的底层硬件的访问权限状态。
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    //如果用户关闭了权限
    /**
     AVAuthorizationStatusNotDetermined, 用户尚未做出选择
     AVAuthorizationStatusRestricted,    未授权
     AVAuthorizationStatusDenied,        用户拒绝App使用
     AVAuthorizationStatusAuthorized     已授权
     */
    if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
        //获取用户授权的位置
        NSBundle *bundle =[NSBundle mainBundle];
        NSDictionary *info =[bundle infoDictionary];
        NSString *prodName =[info objectForKey:@"CFBundleDisplayName"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法打开相机" message:[NSString stringWithFormat:@"请在用户设置->隐私->相机->%@ 开启相机使用权限",prodName] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    } else {
        //跳转控制器进行扫描
        ScanCodeViewController *scanCtr = [[ScanCodeViewController alloc] init];
        
        [self presentViewController:scanCtr animated:YES completion:nil];
    }

}


@end
