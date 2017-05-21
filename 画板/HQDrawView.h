//
//  HQDrawView.h
//  画板
//
//  Created by Macbook on 2017/5/19.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQDrawView : UIView

- (void)clear;

- (void)undo;

- (void)erase;

- (void)setLineWidth:(CGFloat)lineWidth;

- (void)setLineColor:(UIColor *)color;

@property (nonatomic, strong) UIImage *image;

@end
