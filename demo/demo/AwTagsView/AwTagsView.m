//
//  AwTagsView.m
//  XBXMOASystem
//
//  Created by 裴波波 on 2018/9/29.
//  Copyright © 2018年 北京新博新美. All rights reserved.
//

#import "AwTagsView.h"

@interface AwTagsView ()

/// 当前选中的
@property (nonatomic, strong) UILabel * lblSelected;
/// lable数组
@property (nonatomic, strong) NSMutableArray *arrTags;
/// 图片数组
@property (nonatomic, strong) NSMutableArray * arrIcons;

@end

@implementation AwTagsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.topMargin = 15;
        /// 默认是有空格的
        self.isBlank = YES;
    }
    return self;
}

/// 开始创建
-(void)x_Start {
    [self initUI];
}

- (void)initUI {
    
    if (self.arrImgs.count != 0 && self.arrImgs.count != self.arrTitles.count) {
        NSAssert(0, @"图片数组与内容数组对不上");
        return;
    }
    
    if (self.arrImgs.count == 0) {
        /// 无icon的初始化方式
        [self initWithNoIconIsAvailabel:NO];
    } else {
        /// 带有icon的初始化方式
        [self initWithIconIsAvaiable:NO];
    }
    
}

/// 有icon的初始化方式
- (void)initWithIconIsAvaiable:(BOOL) isAvailabel{
    
    CGFloat screenWith = self.bounds.size.width;
    CGFloat leftRightMargin = self.cusLeftRightMargin ? self.cusLeftRightMargin : 15;// 左右两侧距离边
    CGFloat xIcon = leftRightMargin; // x初始值
    CGFloat margin = self.cusMargin ? self.cusMargin : 15; // item左右间距默认15
    // item上下距离
    CGFloat marginLineSpacin = self.lineSpacing ? self.lineSpacing : 5;
    CGFloat heightLbl = self.cusItemHeight ? self.cusItemHeight : 24; // item 高度
    CGFloat yIcon = self.topMargin; // y初始值
    
    // icon 与 label间距
    CGFloat spacing = self.cusInterSpacingOfIconContent ? self.cusInterSpacingOfIconContent : 5;
    
    // icon的宽高
    CGFloat iconH = self.cusIconHeight ? self.cusIconHeight : heightLbl;
    
    for (int i = 0; i < _arrTitles.count; i++) {
        
        /// 初始化icon
        
        UIImageView *imgView = nil;
        if (isAvailabel) {
            imgView = self.arrIcons[i];
        } else {
            imgView = [self x_CreateImageViewIconWithImageName:self.arrImgs[i]];
        }
        imgView.bounds = CGRectMake(0, 0, iconH, iconH);
        [self.arrIcons addObject:imgView];
        
        // 初始化label
        UILabel * lbl = nil;
        if (isAvailabel) {
            lbl = self.arrTags[i];
        } else {
            lbl = [self x_CreateLabelWithIndex:i];
        }
        // 计算lable宽度
        CGFloat wLabel = [self getLabelWidthtWithHeight:heightLbl andLabelFont:[self x_GetFont] withText:lbl.text];
        // 判断剩余宽度是否可以放下label
        if (screenWith - leftRightMargin - xIcon - (wLabel + iconH + spacing) >= 0) {
            // 不换行
            imgView.frame = CGRectMake(xIcon, yIcon + (heightLbl - iconH)*0.5, iconH, iconH);
            lbl.frame = CGRectMake(CGRectGetMaxX(imgView.frame)+spacing, yIcon, wLabel, heightLbl);
            
            // 计算出下一个icon的x坐标
            xIcon = xIcon + wLabel + margin + iconH + spacing;
        }else{
            // 换行
            xIcon = leftRightMargin;
            yIcon = yIcon + heightLbl + marginLineSpacin;
            if (wLabel > screenWith - 2 * leftRightMargin){
                // 如果很宽很宽很宽则展示一行
                wLabel = screenWith - 2 * leftRightMargin;
            }
            imgView.frame = CGRectMake(xIcon, yIcon + (heightLbl - iconH)*0.5, iconH, iconH);
            lbl.frame = CGRectMake(CGRectGetMaxX(imgView.frame)+spacing, yIcon, wLabel, heightLbl);
            xIcon = xIcon + wLabel + margin + spacing + iconH;
        }
    }
    if (self.awHeightCallback) {
        self.awHeightCallback(yIcon + self.topMargin + heightLbl);
    }
}

/// 无icon的初始化方式
- (void)initWithNoIconIsAvailabel:(BOOL)isAvailable {
    CGFloat screenWith = self.bounds.size.width;
    CGFloat leftRightMargin = self.cusLeftRightMargin ? self.cusLeftRightMargin : 15;// 左右两侧距离边
    CGFloat x = leftRightMargin; // x初始值
    CGFloat margin = self.cusMargin ? self.cusMargin : 15; // item左右间距
    // item上下距离
    CGFloat marginLineSpacin = self.lineSpacing ? self.lineSpacing : 5;
    CGFloat height = self.cusItemHeight ? self.cusItemHeight : 24; // item 高度
    CGFloat y = self.topMargin; // y初始值
    for (int i = 0; i < _arrTitles.count; i++) {
        
        // 初始化label
        UILabel * lbl = nil;
        if (isAvailable) {
            lbl = self.arrTags[i];
        } else {
            lbl = [self x_CreateLabelWithIndex:i];
        }
        // 计算lable宽度
        CGFloat w = [self getLabelWidthtWithHeight:height andLabelFont:[self x_GetFont] withText:lbl.text];
        // 判断剩余宽度是否可以放下label
        if (screenWith - leftRightMargin - x - w >= 0) {
            // 不换行
            lbl.frame = CGRectMake(x, y, w, height);
            // 计算出下一个lable的x坐标
            x = x + w + margin;
        }else{
            // 换行
            x = leftRightMargin;
            y = y + height + marginLineSpacin;
            if (w > screenWith - 2 * leftRightMargin){
                // 如果很宽很宽很宽则展示一行得了
                w = screenWith - 2 * leftRightMargin;
            }
            lbl.frame = CGRectMake(x, y, w, height);
            x = x + w + margin;
        }
    }
    if (self.awHeightCallback) {
        self.awHeightCallback(y + self.topMargin + height);
    }
}

/// 初始化image
- (UIImageView *)x_CreateImageViewIconWithImageName:(NSString *)imageName {
    
    UIImageView *imgView = [UIImageView new];
    imgView.image = [UIImage imageNamed:imageName];
    [self addSubview:imgView];
    return imgView;
}

/// 初始化label
- (UILabel *)x_CreateLabelWithIndex:(NSInteger)idx {
    
    UILabel * lbl = [UILabel new];
    lbl.textAlignment = NSTextAlignmentNatural;
    [self addSubview:lbl];
    [self.arrTags addObject:lbl];
    lbl.tag = idx;
    lbl.backgroundColor = self.colorBgNormal ? self.colorBgNormal : [UIColor yellowColor];
    
    lbl.font = [UIFont systemFontOfSize:[self x_GetFont]];
    // 两边添加俩空格 不至于字都挨着边框
    lbl.text = self.isBlank ? [NSString stringWithFormat:@"  %@  ",_arrTitles[idx]] : _arrTitles[idx];
    lbl.textColor = self.colorNormal ? self.colorNormal : [UIColor blackColor];
    
    lbl.layer.cornerRadius = self.cornerRadius;
    lbl.layer.masksToBounds = YES;
    lbl.layer.borderColor = self.colorBorderNormal ? self.colorBorderNormal.CGColor : [UIColor blackColor].CGColor;
    lbl.layer.borderWidth = self.cusBorderWidth;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTagItem:)];
    lbl.userInteractionEnabled = YES;
    [lbl addGestureRecognizer:tap];
    return lbl;
}

// 获取font
- (CGFloat)x_GetFont {
    
    return self.cusFont ? self.cusFont : 12;
}

- (void)layoutSubviews {
    
    NSLog(@"重新布局");
    if (self.arrImgs && self.arrImgs.count >0 && self.arrImgs.count == self.arrTitles.count) {
        [self initWithIconIsAvaiable:YES];
    } else {
        [self initWithNoIconIsAvailabel:YES];
    }
}

#pragma mark - events
- (void)awSetDefaultSelectedItemWithIndex:(NSInteger)index {
    
    UILabel * lbl = (UILabel *)self.arrTags[index];
    self.lblSelected = lbl;
    lbl.layer.borderColor = self.colorBorderSelected ? self.colorBorderSelected.CGColor : [UIColor cyanColor].CGColor;
    lbl.backgroundColor = self.colorBgSelected ? self.colorBgSelected : [UIColor redColor];
    lbl.textColor = self.colorSelected ? self.colorSelected : [UIColor blackColor];
}

- (void)clickTagItem:(UITapGestureRecognizer *)res {
    
    UILabel *lbl = (UILabel *)res.view;
    if (self.lblSelected != lbl && self.lblSelected != nil) {
        
        [self _updateUIWithLbl:lbl];
    }else if (self.lblSelected == nil) {
        
        [self awSetDefaultSelectedItemWithIndex:lbl.tag];
    }
    
    if (self.awClickItemCallback) {
        NSString * s = [lbl.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.awClickItemCallback(s, lbl.tag);
    }
}

- (void)_updateUIWithLbl:(UILabel *)lbl {
    
    self.lblSelected.layer.borderColor = self.colorBorderNormal ? self.colorBorderNormal.CGColor : [UIColor blackColor].CGColor;
    self.lblSelected.backgroundColor = self.colorBgNormal ? self.colorBgNormal : [UIColor yellowColor];
    self.lblSelected.textColor = self.colorNormal ? self.colorNormal : [UIColor blackColor];
    
    lbl.layer.borderColor = self.colorBorderSelected ? self.colorBorderSelected.CGColor : [UIColor cyanColor].CGColor;
    lbl.backgroundColor = self.colorBgSelected ? self.colorBgSelected : [UIColor redColor];
    lbl.textColor = self.colorSelected ? self.colorSelected : [UIColor blackColor];
    self.lblSelected = lbl;
}

- (CGFloat)getLabelWidthtWithHeight:(CGFloat)height andLabelFont:(CGFloat)font withText:(NSString *)text{
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return size.width;
}

- (NSMutableArray *)arrTags {
    
    if (!_arrTags) {
        _arrTags = @[].mutableCopy;
    }
    return _arrTags;
}

- (NSMutableArray *)arrIcons {
    
    if (!_arrIcons) {
        _arrIcons = @[].mutableCopy;
    }
    return _arrIcons;
}

@end
