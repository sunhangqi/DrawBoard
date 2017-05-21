//
//  HQHandlerImageView.h
//  画板
//
//  Created by Macbook on 2017/5/21.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HQHandlerImageView;
@protocol HQHandlerImageViewDelegate <NSObject>

- (void)HQHandlerImageView:(HQHandlerImageView *)handlerImageView newImage:(UIImage*)image;

@end

@interface HQHandlerImageView : UIView
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, weak) id<HQHandlerImageViewDelegate> delegate;
@end
