//
//  AwTagsView.m
//  XBXMOASystem
//
//  Created by 裴波波 on 2018/9/29.
//  Copyright © 2018年 北京新博新美. All rights reserved.
//

#import "AwTagsView.h"

@interface AwTagsView ()
@property (nonatomic, strong) UILabel * lblSelected;
@property (nonatomic, strong) NSMutableArray *arrTags;
@end

@implementation AwTagsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.topMargin = 15;
    }
    return self;
}

- (void)setArrTitles:(NSArray *)arrTitles {
    _arrTitles = arrTitles;
    _arrTags = @[].mutableCopy;
    [self initUI];
}

- (void)initUI {
    
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat leftRightMargin = self.cusLeftRightMargin ? self.cusLeftRightMargin : 15;// 左右两侧距离边
    CGFloat x = leftRightMargin; // x初始值
    CGFloat margin = self.cusMargin ? self.cusMargin : 15; // item左右间距
    CGFloat height = self.cusItemHeight ? self.cusItemHeight : 24; // item 高度
    CGFloat y = self.topMargin; // y初始值
    for (int i = 0; i < _arrTitles.count; i++) {
        UILabel * lbl = [UILabel new];
        lbl.textAlignment = NSTextAlignmentNatural;
        [self addSubview:lbl];
        [_arrTags addObject:lbl];
        lbl.tag = i;
        lbl.backgroundColor = self.colorBgNormal ? self.colorBgNormal : [UIColor yellowColor];
        
        lbl.font = [UIFont systemFontOfSize:self.cusFont ? self.cusFont : 12];
        // 两边添加俩空格 不至于字都挨着边框
        lbl.text = [NSString stringWithFormat:@"  %@  ",_arrTitles[i]];
        lbl.textColor = self.colorNormal ? self.colorNormal : [UIColor blackColor];
        
        lbl.layer.cornerRadius = self.cornerRadius;
        lbl.layer.masksToBounds = YES;
        lbl.layer.borderColor = self.colorBorderNormal ? self.colorBorderNormal.CGColor : [UIColor blackColor].CGColor;
        lbl.layer.borderWidth = self.cusBorderWidth;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTagItem:)];
        lbl.userInteractionEnabled = YES;
        [lbl addGestureRecognizer:tap];
        
        CGFloat w = [self getLabelWidthtWithHeight:24 andLabelFont:12 withText:lbl.text];
        // 判断剩余宽度是否可以放下label
        if (screenWith - leftRightMargin - x - w >= 0) {
            // 不换行
            lbl.frame = CGRectMake(x, y, w, height);
            // 计算出下一个lable的x坐标
            x = x + w + margin;
        }else{
            // 换行
            x = leftRightMargin;
            y = y + height + margin;
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
        self.awClickItemCallback(lbl.text, lbl.tag);
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
@end
