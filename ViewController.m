//
//  ViewController.m
//  YHAlterView
//
//  Created by 我叫MT on 17/4/13.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <JKCategories/JKCategories.h>
#define  kWidth [UIScreen mainScreen].bounds.size.width
#define  kHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic, strong)UIView *BgView;
@property(nonatomic, strong)NSMutableArray *btnArray;
@property(nonatomic, strong)NSMutableArray *bottonArray;
@property(nonatomic, strong)UIView *topView;
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIView *bottomView;
@property(nonatomic, strong)UIVisualEffectView *effectView;
@property(nonatomic, strong)UIButton *cancelBtn;
@property(nonatomic, strong)UIButton *enterBtn;


@property(nonatomic, strong)UIPickerView *pickView;
@property(nonatomic, assign) lineCount line;
@property(nonatomic, assign)int LCount;


@property(nonatomic, strong)UITableView *tableView;

@property(nonatomic, strong)UIButton *tagBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // }
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(200, 200, 100, 50)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(touchButton) forControlEvents:UIControlEventTouchUpInside];
    for (int i = 0; i < 3; i++) {
        UIButton *button = [[UIButton alloc]init];
        [self.btnArray addObject:button];//根据数组元素个数
      //  [button  setTitle:[self btnTile:i] forState:UIControlStateNormal];
    }
    
    
}

-(NSString *)btnTile:(int)k
{
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8" ,nil];
    return (NSString *)array[k];
}
-(void)creatView
{
     _BgView = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x - 150, self.view.center.y-120, 300, 240)];
     [[[UIApplication sharedApplication]windows][0] addSubview:_BgView];
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _BgView.frame.size.width, 40)];
    [_BgView addSubview:self.topView];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.topView.frame.size.width, self.topView.frame.size.height)];
    [self.topView addSubview:self.titleLabel];
    self.titleLabel.numberOfLines = 1;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"弹窗";
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.topView.backgroundColor = [UIColor cyanColor];
    self.type = scrollType;//样式表
    self.line = twoLine;//列数
    
    
    switch ( self.type) {
        case scrollType:
        {
            self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake( 0 , CGRectGetMaxY(self.topView.frame), self.topView.frame.size.width, _BgView.frame.size.height - self.topView.frame.size.height - 40)];
            self.scrollView.backgroundColor = [UIColor magentaColor];
            [self.BgView addSubview:self.scrollView];
            self.cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scrollView.frame), self.BgView.frame.size.width *0.5, 40)];
            self.cancelBtn.backgroundColor = [UIColor redColor];
            [self.BgView addSubview:self.cancelBtn];
            [self.cancelBtn addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchDown];
            
            
            self.enterBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.BgView.frame.size.width *0.5, CGRectGetMaxY(self.scrollView.frame), self.BgView.frame.size.width *0.5, 40)];
            self.enterBtn.backgroundColor = [UIColor blueColor];
            [self.BgView addSubview:self.enterBtn];
            
            
            CGFloat buttonH  = 40;
            switch (self.line) {
                    
                case oneLine:
                {
                    CGFloat buttonW = (self.scrollView.frame.size.width - 20) *0.5;
                    for (int i =0; i<self.btnArray.count; i++) {
                        UIButton *button = [[UIButton alloc]init];
                        button = self.btnArray[i];
                        button.layer.cornerRadius = 20;
                        button.clipsToBounds  = YES;
                        button.frame = CGRectMake(self.scrollView.center.x - buttonW *0.5, 20 *i + buttonH * i +20, buttonW, buttonH);
                        [self.scrollView addSubview:button];
                        button.tag = 100+i;
                        [self setBtn:button];
                        if (i == self.btnArray.count -1) {
                            self.scrollView.contentSize = CGSizeMake(self.scrollView.center.x - buttonW *0.5, 20 *i + buttonH * (i+1) +20 +20);
                        }
                    }
                    

                }
                    break;
                case twoLine://两行Button
                {
                    self.LCount = 2;
                  CGFloat buttonW = (self.scrollView.frame.size.width - 60) *0.5;
                    CGFloat buttonStarY = 10;
                    CGFloat buttonStarX = 20;
                    CGFloat xMargin = (self.scrollView.frame.size.width - self.LCount * 20 - self.LCount *buttonW)/1;
                    
                    for (int i = 0; i<self.btnArray.count; i++) {
                        UIButton *button = [[UIButton alloc]init];
                        button = self.btnArray[i];
                        button.layer.cornerRadius = 20;
                        button.clipsToBounds  = YES;
                        
                        int col = i % self.LCount;//列数
                        int row =  i / self.LCount;//行数
                        button.frame = CGRectMake(buttonStarX + col * (xMargin +buttonW) ,  buttonStarY * row +row *buttonH+10 , buttonW, buttonH);
                        [self.scrollView addSubview:button];
                        button.tag = 100+i;
                        [self setBtn:button];
                        if (i == self.btnArray.count -1) {
                            self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, buttonStarY * row +(row +1) *buttonH +10+10);
                        }
                    }

                }
                    break;
                    
                default:
                    break;
            }
                  }
            break;
        case tableType://tableView样式
        {
            
            
            
            
            
        }
            break;
        case pickType://pickView样式
        {
            
            self.pickView = [[UIPickerView alloc]initWithFrame:CGRectMake( 0 , CGRectGetMaxY(self.topView.frame), self.topView.frame.size.width, _BgView.frame.size.height - self.topView.frame.size.height - 40)];
            [_BgView addSubview:self.pickView];
            
            self.pickView.backgroundColor = [UIColor brownColor];
            self.pickView.delegate = self;
            self.pickView.dataSource = self;
            
            NSArray *oneArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
            NSArray *secArray = [[NSArray alloc]initWithObjects:@"q",@"w",@"e",@"r",@"t", nil];
            
            
            
            
        }
            break;
            
            
            
        default:
            break;
    }


    
    
    
    _BgView.layer.cornerRadius = 20;
    _BgView.clipsToBounds = YES;
     _BgView.backgroundColor = [UIColor yellowColor];
    CGPoint point = CGPointMake(self.view.center.x, 0);
    CGPoint toPoint = CGPointMake(self.view.center.x , self.view.center.y);
    [self moveAnimation:point withZoom:toPoint];

}

-(void)setBtn:(UIButton *)btn
{
    btn.backgroundColor = [UIColor whiteColor];
    [btn addTarget:self action:@selector(touchForButton:) forControlEvents:UIControlEventTouchDown];
    if (btn.tag == 100) {
        _tagBtn = btn;
        btn.selected = YES;
    }
    [btn setBackgroundImage: [UIImage jk_imageWithColor:[UIColor yellowColor] ]forState:UIControlStateSelected];
}

#pragma mark --保证只有一个被选中
-(void)touchForButton:(UIButton *)button
{
    NSLog(@"点击%ld",button.tag - 100);
    if (button == _tagBtn) {
        return;
    }
    [self selectButton:button];
}
- (void)selectButton:(UIButton *)button
{
    //保证同时只有一个按钮被选中
    if (_tagBtn == nil){
        button.selected = YES;
        _tagBtn = button;
    }
    else if (_tagBtn !=nil && _tagBtn == button){
        button.selected = YES;
    }
    else if (_tagBtn!= button && _tagBtn!=nil){
        _tagBtn.selected = NO;
        button.selected = YES;
       
        _tagBtn = button;
    }
}
-(NSMutableArray *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return  _btnArray;
}
//取消
-(void)removeView
{
//    [UIView animateWithDuration:1 animations:^{
//             }];
    
    [UIView animateWithDuration:1 animations:^{
        _BgView.frame = CGRectMake(self.BgView.center.x, self.BgView.center.y, 0, 0);

    } completion:^(BOOL finished) {
        [_BgView removeFromSuperview];
    }];

}

-(void)moveAnimation:(CGPoint)point withZoom:(CGPoint)toPoint
{
    CABasicAnimation *basicAnimate = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAnimate.fromValue = [NSValue valueWithCGPoint:point];
    basicAnimate.toValue = [NSValue valueWithCGPoint:toPoint];
    basicAnimate.duration = 1;
    basicAnimate.repeatCount = 1;
    CABasicAnimation *zoomAnimation  = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    zoomAnimation.toValue = [NSNumber numberWithFloat:1.0];
    zoomAnimation.duration = 1;
    zoomAnimation.repeatCount  = 1;
    zoomAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2;
    group.repeatCount = 1;
    group.animations = [NSArray arrayWithObjects:zoomAnimation,basicAnimate, nil];
    
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [_BgView.layer addAnimation:group forKey:@"scale-move- layer"];

}


-(void)touchButton
{
   [_BgView removeFromSuperview];
    [self creatView];
}



-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 60;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"返回";
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    return [[UIView alloc]init];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
