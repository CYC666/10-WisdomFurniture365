//
//  PHCProductionCode.h
//  二维码的集成
//
//  Created by phc on 16/8/8.
//  Copyright © 2016年 phc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PHCProductionCode : NSObject

//生成图片
//- (UIImage *)imageWithSize:(CGFloat)size andColorWithRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue andQRString:(NSString *)qrString;

- (UIImage *)creactCodeWithString:(NSString *)string;
@end
