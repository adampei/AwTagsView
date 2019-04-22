//
//  ViewController.m
//  demo
//
//  Created by 裴波波 on 2018/9/29.
//  Copyright © 2018年 裴波波. All rights reserved.
//

#import "ViewController.h"
#import "AwTagsView/AwTagsView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AwTagsView * awView = [[AwTagsView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 0)];
    awView.cornerRadius = 5;
    awView.colorNormal = [UIColor whiteColor];
    awView.colorSelected = [UIColor whiteColor];
    
    awView.colorBgNormal = [UIColor redColor];
    awView.colorBgSelected = [UIColor redColor];
    
    awView.colorBorderNormal = [UIColor redColor];
    /// 标签顶部 底部距离父view的距离
    awView.topMargin = 0;
    awView.cusBorderWidth = 0;
    __weak __typeof(awView)weakView = awView;
    [awView setAwHeightCallback:^(CGFloat height) {
        weakView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, height);
    }];
    
    awView.arrTitles = @[@"你好", @"大师傅你好", @"你啊好", @"你阿道夫好", @"你打发爱得深沉好"];
    
    awView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:awView];}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
