//
//  AwTagsView.h
//  XBXMOASystem
//
//  Created by 裴波波 on 2018/9/29.
//  Copyright © 2018年 北京新博新美. All rights reserved.
//  标签view

#import <UIKit/UIKit.h>

@interface AwTagsView : UIView

/** tag距离左侧边距默认15 */
@property (nonatomic, assign) CGFloat cusLeftRightMargin;
/** tag之间的间距默认15 */
@property (nonatomic, assign) CGFloat cusMargin;
/** 标签高度默认24 */
@property (nonatomic, assign) CGFloat cusItemHeight;
/** 字体大小 默认12 */
@property (nonatomic, assign) CGFloat cusFont;
/** 圆角大小默认是0 */
@property (nonatomic, assign) CGFloat cornerRadius;
/** 边框颜色正常 */
@property (nonatomic, strong) UIColor *colorBorderNormal;
/** 边框颜色选中 */
@property (nonatomic, strong) UIColor *colorBorderSelected;
/** 边框线条粗细 */
@property (nonatomic, assign) CGFloat cusBorderWidth;
/** 选中状态字体颜色 */
@property (nonatomic, strong) UIColor *colorSelected;
/** 未选中字体颜色 */
@property (nonatomic, strong) UIColor *colorNormal;
/** 未选中背景色 */
@property (nonatomic, strong) UIColor *colorBgNormal;
/** 选中状态背景色 */
@property (nonatomic, strong) UIColor *colorBgSelected;
/** 标题数组 */
@property (nonatomic, strong) NSArray *arrTitles;

/**
 选中item的回调
 */
@property (nonatomic, copy) void(^awClickItemCallback)(NSString *strSelectedItem, NSInteger index);
/** 高度回调 */
@property (nonatomic, copy) void(^awHeightCallback)(CGFloat height);

/**
 设置默认选中的tag

 @param index 角标
 */
- (void)awSetDefaultSelectedItemWithIndex:(NSInteger)index;

@end


