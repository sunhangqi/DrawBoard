
//
//  HQDrawView.m
//  画板
//
//  Created by Macbook on 2017/5/19.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import "HQDrawView.h"
#import "HQBezierPath.h"

@interface HQDrawView()

@property (nonatomic, strong)UIBezierPath *path;


//保存绘制的所有路径
@property (nonatomic, strong)NSMutableArray *allPathArray;

@property (nonatomic, assign)CGFloat width;
@property (nonatomic, strong)UIColor *color;

@end

@implementation HQDrawView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)clear{
    //清空所有的路径
    [self.allPathArray removeAllObjects];
    
    [self setNeedsDisplay];
}

- (void)undo {
    [self.allPathArray removeLastObject];
    [self setNeedsDisplay];
}

- (void)erase {
    [self setLineColor:[UIColor whiteColor]];
    
}

- (void)setLineWidth:(CGFloat)lineWidth {
    self.width = lineWidth;
}

- (void)setLineColor:(UIColor *)color {
    self.color = color;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.allPathArray addObject:image];
    //重绘
    [self setNeedsDisplay];
}

- (NSMutableArray *)allPathArray {
    if(_allPathArray == nil) {
        _allPathArray = [NSMutableArray array];
    }
    return _allPathArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    self.width = 1;
    self.color = [UIColor blackColor];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    
    CGPoint curP = [pan locationInView:self];
    //判断手势状态
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        //创建路径
//        UIBezierPath *path = [UIBezierPath bezierPath];
        HQBezierPath *path = [[HQBezierPath alloc] init];
        self.path = path;
        
        //设置起点
        [path setLineWidth:self.width];
        path.color = self.color;
        [path moveToPoint:curP];
        [self.allPathArray addObject:path];
        
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        //绘制一根线到当前手指所在的点
        [self.path addLineToPoint:curP];
        
        //重绘画
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    
    //绘制保存的所有路径
    for (HQBezierPath *path in self.allPathArray) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            [path.color set];
            [path stroke];
        }
    }
    
}

@end
