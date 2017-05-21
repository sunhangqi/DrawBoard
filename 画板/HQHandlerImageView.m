//
//  HQHandlerImageView.m
//  画板
//
//  Created by Macbook on 2017/5/21.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import "HQHandlerImageView.h"

@interface HQHandlerImageView()<UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIImageView *imageV;


@end
@implementation HQHandlerImageView
- (UIImageView *)imageV {
    if (_imageV == nil) {
        UIImageView *imageV = [[UIImageView alloc]init];
        imageV.frame = self.bounds;
       
        imageV.userInteractionEnabled = YES;
        [self addSubview:imageV];
         _imageV = imageV;
        [self addGes];
    }
    return _imageV;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageV.image = image;
}


- (void)addGes {
    
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.imageV addGestureRecognizer:pan];
    
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self.imageV addGestureRecognizer:pinch];
    
        UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [self.imageV addGestureRecognizer:longP];
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    CGPoint tranS = [pan translationInView:self];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, tranS.x, tranS.y);
    [pan setTranslation:CGPointZero inView:pan.view];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
    [pinch setScale:1];
}

- (void)longPress:(UILongPressGestureRecognizer *)longP {
    if (longP.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.5 animations:^{
            self.imageV.alpha = 0.0;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                self.imageV.alpha = 1.0;
            }completion:^(BOOL finished) {
                //把图片绘制到画板当中
                UIGraphicsBeginImageContextWithOptions(longP.view.bounds.size
                                                       , NO, 0);
                CGContextRef ctx = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:ctx];
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
                if([self.delegate respondsToSelector:@selector(HQHandlerImageView:newImage:)]) {
                    [self.delegate HQHandlerImageView:self newImage:image];
                }
                [self removeFromSuperview];
            }];
        }];
    }
}

@end
