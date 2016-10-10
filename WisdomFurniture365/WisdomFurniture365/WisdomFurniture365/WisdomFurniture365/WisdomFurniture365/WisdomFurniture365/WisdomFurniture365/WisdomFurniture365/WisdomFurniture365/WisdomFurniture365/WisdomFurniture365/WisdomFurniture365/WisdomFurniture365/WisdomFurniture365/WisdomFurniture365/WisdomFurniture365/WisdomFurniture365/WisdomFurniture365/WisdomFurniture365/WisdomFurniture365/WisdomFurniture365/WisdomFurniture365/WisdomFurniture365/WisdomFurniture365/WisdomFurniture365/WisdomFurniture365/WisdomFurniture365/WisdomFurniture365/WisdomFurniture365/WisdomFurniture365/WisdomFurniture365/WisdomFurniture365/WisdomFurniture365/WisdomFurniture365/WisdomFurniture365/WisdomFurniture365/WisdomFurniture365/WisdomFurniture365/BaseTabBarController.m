//
//  BaseTabBarController.m
//  WisdomFurniture365
//
//  Created by mac on 16/10/9.
//  Copyright © 2016年 CYC. All rights reserved.
//


// 创建标签控制器


#import "BaseTabBarController.h"
#import "Header.h"
#import "EquipViewController.h"
#import "SafeViewController.h"
#import "SceneViewController.h"
#import "MineViewController.h"


@interface BaseTabBarController () {

    NSArray *_buttonTitles;
    NSArray *_buttonImagesName;
    NSArray *_buttonImagesNamePress;

}

@property (strong, nonatomic) UIButton *selectBtn;  // 选中的按钮

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //给标签栏创建按钮
    [self _creatTabBarButton];
    
    EquipViewController *a = [[EquipViewController alloc] init];
    SceneViewController *b = [[SceneViewController alloc] init];
    SafeViewController *c = [[SafeViewController alloc] init];
    MineViewController *d = [[MineViewController alloc] init];
    
    
    self.viewControllers = @[a,b,c,d];
    
    self.tabBar.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    //在视图将要显示的时候移除原有的标签按钮
    [self _removeTabBarButton];
    
}


//----------------------------------------------------------------------------------------------------------
//移除标签栏原有的按钮
- (void)_removeTabBarButton {
   
    //自己定义一个要删除的类
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *view in self.tabBar.subviews) {
        
        //容错
        if ([view isKindOfClass:class]) {   //当view是我定义的那个类，那么就把它从它的父视图中移除
            [view removeFromSuperview];
        }
        
    }
    
}



//给标签栏自定义按钮
- (void)_creatTabBarButton {
    
    
    float buttonWidth = kScreenWidth / 4;
    
    
    
    
    //创建数组存标题的名称
    _buttonTitles = @[@"设备",@"场景",@"安防",@"我的"];
    //创建数组存按钮图片的名字
    _buttonImagesName = @[@"1",@"2",@"3",@"4"];
    //已经选中的按钮的图片的名字
    _buttonImagesNamePress = @[@"1p",@"2p",@"3p",@"4p"];
    
    // 创建按钮
    for (int i = 0; i < 4; i ++) {
    
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonWidth*i, 0, buttonWidth, 30);
        button.tag = 666 + i;
        [button setImage:[UIImage imageNamed:_buttonImagesName[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_buttonImagesNamePress[i]] forState:UIControlStateSelected];
        if (i == 0) {
            button.selected = YES;
            self.selectBtn = button;
        }
        button.adjustsImageWhenHighlighted = NO;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
        // 添加长按情况
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
        longPress.minimumPressDuration = 1;
        [button addGestureRecognizer:longPress];
        
        //创建UIControl对象上的标题
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(buttonWidth*i, 30, buttonWidth, 21)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:12];
        label.text = _buttonTitles[i];
        [self.tabBar addSubview:label];
    
    }
    

}

// 标签栏按钮点击响应
- (void)buttonAction:(UIButton *)button {
    
    if (button.selected == NO) {

    // 取消之前选中的，选中现在的
    self.selectBtn.selected = NO;
    //选中后不能再选
    self.selectBtn.userInteractionEnabled = YES;
    button.selected = YES;
    // 切换子视图
    NSInteger index = button.tag - 666;
    self.selectedIndex = index;
    // 记录当前选中的按钮
    self.selectBtn = button;
    self.selectBtn.userInteractionEnabled = NO;

    }
    
    
}


- (void)longPressAction:(UILongPressGestureRecognizer *)press {

    UIButton *button = (UIButton *)press.view;
    if (button.selected == NO) {
        
        // 取消之前选中的，选中现在的
        self.selectBtn.selected = NO;
        //选中后不能再选
        self.selectBtn.userInteractionEnabled = YES;
        button.selected = YES;
        // 切换子视图
        NSInteger index = button.tag - 666;
        self.selectedIndex = index;
        // 记录当前选中的按钮
        self.selectBtn = button;
        self.selectBtn.userInteractionEnabled = NO;
        
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
