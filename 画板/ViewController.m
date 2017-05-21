//
//  ViewController.m
//  画板
//
//  Created by Macbook on 2017/5/19.
//  Copyright © 2017年 Macbook. All rights reserved.
//

#import "ViewController.h"
#import "HQDrawView.h"
#import "HQHandlerImageView.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HQHandlerImageViewDelegate>
@property (weak, nonatomic) IBOutlet HQDrawView *drawView;

@end

@implementation ViewController
- (IBAction)clear:(id)sender {
    [self.drawView clear];
}
- (IBAction)undo:(id)sender {
    [self.drawView undo];
}
- (IBAction)erase:(id)sender {
    [self.drawView erase];
}
- (IBAction)setLineColor:(UISlider *)sender {
    [self.drawView setLineWidth:sender.value ];
}
- (IBAction)setColor:(UIButton *)sender {
    [self.drawView setLineColor:sender.backgroundColor];
}

//从系统相册中选择一张照片
- (IBAction)photo:(id)sender {
    //1.弹出系统相册
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    
    //2.设置照片来源
    pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
}

//把绘制的图片保存到系统相册
- (IBAction)save:(id)sender {
    //1.开启一个位图上下文
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size
                                           , NO, 0);
    
    //2.把画板上的内容渲染到上下文中
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    
    //3.从上下文中取出一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //4.关闭上下文
    UIGraphicsEndImageContext();
    
    //5.把图片保存到系统相册中
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//- (void)saveSuccess {
//    NSLog(@"保存成功");
//}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"保存成功");
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    HQHandlerImageView *handlerView = [[HQHandlerImageView alloc] initWithFrame:self.drawView.frame];
    handlerView.backgroundColor = [UIColor clearColor];
//    handlerView.alpha = 1;
    handlerView.image = image;
    handlerView.delegate = self;
    [self.view addSubview:handlerView];
//    NSData *data = UIImagePNGRepresentation(image);
//    self.drawView.image = image;
    
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.drawView.frame];
//    imageV.userInteractionEnabled = YES;
//    imageV.image = image;
//    [self.view addSubview:imageV];
//    //添加手势
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    [imageV addGestureRecognizer:pan];
//    
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
//    [imageV addGestureRecognizer:pinch];
//    
//    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
//    [imageV addGestureRecognizer:longP];
    
    
    
    
    
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (void)pan:(UIPanGestureRecognizer *)pan {
//    CGPoint tranS = [pan translationInView:self.view];
//    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, tranS.x, tranS.y);
//    [pan setTranslation:CGPointZero inView:pan.view];
//}
//
//- (void)pinch:(UIPinchGestureRecognizer *)pinch{
//    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, pinch.scale, pinch.scale);
//    [pinch setScale:1];
//}
//
//- (void)longPress:(UILongPressGestureRecognizer *)longP {
//    if (longP.state == UIGestureRecognizerStateBegan) {
//        [UIView animateWithDuration:0.5 animations:^{
//            longP.view.alpha = 0.0;
//        }completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.5 animations:^{
//                longP.view.alpha = 1.0;
//            }completion:^(BOOL finished) {
//                //把图片绘制到画板当中
//                UIGraphicsBeginImageContextWithOptions(longP.view.bounds.size
//                                                       , NO, 0);
//                CGContextRef ctx = UIGraphicsGetCurrentContext();
//                [longP.view.layer renderInContext:ctx];
//                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//                UIGraphicsEndImageContext();
//                
//                self.drawView.image = image;
//                [longP.view removeFromSuperview];
//            }];
//        }];
//    }
//}

-(void)HQHandlerImageView:(HQHandlerImageView *)handlerImageView newImage:(UIImage *)image {
    self.drawView.image = image;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}


@end
