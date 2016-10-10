//
//  ScanCodeViewController.m
//  二维码的集成
//
//  Created by phc on 16/8/8.
//  Copyright © 2016年 phc. All rights reserved.
//

#import "ScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#define MAINSCREEN_BOUNDS [UIScreen mainScreen].bounds
#define SYSTEM_VERSION_FLOAT [[UIDevice currentDevice]systemVersion].floatValue
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface ScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureSession *avSession;
    AVCaptureDevice *avDevice;
    AVCaptureDeviceInput *avInput;
    AVCaptureMetadataOutput *avOutput;
    AVCaptureVideoPreviewLayer *preViewLayer;
    BOOL isQRCode;
    CGRect drawRect;
    UIImageView *blueImageView;
    NSString *tiaoxinmaString;
}
@property (strong, nonatomic) UILabel *descriptionLabel;//提示文字
@end

@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     1.导入AVFoundation,创建扫码器
     */
    [self createScanner];
    
    [self makeScanCameraShadowViewWithRect:[self makeScanReaderInterrestRect]];
    
//    self.view.backgroundColor = [UIColor ]
}
#pragma mark - 创建扫码器
- (void)createScanner {
    //AVCaptureDevice代表抽象的硬件设备
    avDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //AVCaptureDeviceInput代表输入设备
    avInput = [AVCaptureDeviceInput deviceInputWithDevice:avDevice error:nil];
    //它代表输出数据，管理着输出到一个movie或者图像
    avOutput = [[AVCaptureMetadataOutput alloc] init];
    [avOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //它是input和output的桥梁。它协调着intput到output的数据传输
    avSession = [[AVCaptureSession alloc] init];
    //指示接收器当前使用的会话预置。AVCaptureSessionPresetHigh对视频采集的设置
    [avSession setSessionPreset:AVCaptureSessionPresetHigh];
    if ([avSession canAddInput:avInput]) {
        [avSession addInput:avInput];
    }
    if ([avSession canAddOutput:avOutput]) {
        [avSession addOutput:avOutput];
    }
    
    if (SYSTEM_VERSION_FLOAT < 8.0) {
        
        //设置能够扫描的条形码类型
        avOutput.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,/*AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode*/];
    }
    else {
        avOutput.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
    }
    //视频的预览
    preViewLayer = [AVCaptureVideoPreviewLayer layerWithSession:avSession];
    preViewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    preViewLayer.frame = CGRectMake(0, 0, MAINSCREEN_BOUNDS.size.width, MAINSCREEN_BOUNDS.size.height );
    [self.view.layer insertSublayer:preViewLayer atIndex:0];
    [avSession startRunning];

}

#pragma mark - 创建扫码框
 //扫码框frame
- (CGRect)makeScanReaderInterrestRect {
    CGFloat size = MIN(MAINSCREEN_BOUNDS.size.width, MAINSCREEN_BOUNDS.size.height)*3/5;
    CGRect scanRect = CGRectMake(0, 0, size, size);
    scanRect.origin.x = MAINSCREEN_BOUNDS.size.width/2 - scanRect.size.width / 2;
    scanRect.origin.y = MAINSCREEN_BOUNDS.size.height / 3 - scanRect.size.height / 2;
    return scanRect;
}
 //生成扫码框
- (UIImageView *)makeScanCameraShadowViewWithRect:(CGRect)rect {
    //扫码框视图
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:MAINSCREEN_BOUNDS];
    //开启一个图片上下文
    UIGraphicsBeginImageContext(imgView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置填充颜色
    CGContextSetRGBFillColor(context, 0, 0, 0, 0.3);
    //设置绘图位置
    drawRect = MAINSCREEN_BOUNDS;
    CGContextFillRect(context, drawRect);
        //是二维码
        [self.descriptionLabel removeFromSuperview];
        drawRect = CGRectMake(rect.origin.x - imgView.frame.origin.x, rect.origin.y - imgView.frame.origin.y+20+50, rect.size.width, rect.size.height);
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(drawRect.origin.x, drawRect.origin.y+drawRect.size.height, drawRect.size.width, 60.0)];
        self.descriptionLabel.font = [UIFont systemFontOfSize:12];
        self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
        self.descriptionLabel.textColor= [UIColor whiteColor];
        self.descriptionLabel.text = @"将二维码放入框内，即可自动扫描";
        [self.view addSubview:self.descriptionLabel];

    CGContextClearRect(context, drawRect);
    //获取上下文上的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    imgView.image = image;
    return imgView;
}
/*
 扫码移动蓝条
 */
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self createMovingBlueViewWithFrame:drawRect];
    [self createCornerView:drawRect];
}
- (void)createMovingBlueViewWithFrame:(CGRect)frame {
    

    UIImage *image = [UIImage imageNamed:@"line@2x"];
    frame.size.height = 4.0f;
    
    blueImageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:blueImageView];
    
    blueImageView.image = image;
    

    [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse  animations:^{
            blueImageView.transform = CGAffineTransformMakeTranslation(0, drawRect.size.height-4);
        } completion:nil];
        

    
    
    
    
}
/*
 四边角
 */
- (void)createCornerView:(CGRect)frame {
    UIImage *upLeftImg = [UIImage imageNamed:@"leftCorner"];
    UIImageView *upleftimgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x , frame.origin.y, 20.0, 20.0)];
    upleftimgView.image = upLeftImg;
    UIImageView *downLeftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x , frame.origin.y + frame.size.height-20.0, 20.0, 20.0)];
    downLeftImgView.image = [UIImage imageNamed:@"downLeftCorner"];
    UIImageView *upRightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width-20.0, frame.origin.y, 20.0, 20.0)];
    upRightImgView.image = [UIImage imageNamed:@"rightCorner"];
    UIImageView *downRightImgView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.origin.x + frame.size.width-20.0, frame.origin.y + frame.size.height-20.0, 20.0, 20.0)];
    downRightImgView.image = [UIImage imageNamed:@"downRightCorner"];
    [self.view addSubview:upRightImgView];
    [self.view addSubview:downRightImgView];
    [self.view addSubview:downLeftImgView];
    [self.view addSubview:upleftimgView];
}

#pragma mark - 扫码成功后调用的代理方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    
    //扫描成功之后会返回检测一维或二维条码
    
    if ([metadataObjects count] >0)
    {
        
        //通过获取判断里面是否有值
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        //取出对应的链接地址
        stringValue = metadataObject.stringValue;
    }
    [avSession stopRunning];
    
    [blueImageView.layer removeAllAnimations];
    
    if (stringValue.length > 0) {
        tiaoxinmaString = stringValue;
        NSString *str = [NSString stringWithFormat:@"二维码信息为：\n二维码 %@",stringValue];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示:" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        alert.tag = 1001;
        [alert show];
       

//        UIWebView * webview = [[UIWebView alloc] initWithFrame:MAINSCREEN_BOUNDS];
//        
//        [self.view addSubview:webview];
//        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:stringValue]];
//        [webview loadRequest:request];
        
    }
}
@end
