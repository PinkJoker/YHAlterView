//
//  ViewController.h
//  YHAlterView
//
//  Created by 我叫MT on 17/4/13.
//  Copyright © 2017年 Pinksnow. All rights reserved.
//

#import <UIKit/UIKit.h>

//内部样式
typedef enum  : NSUInteger {
    tableType,
    scrollType,
    pickType,
} ViewType;
//button样式下选择列数
typedef enum : NSUInteger {
    oneLine,
    twoLine,
} lineCount;
@interface ViewController : UIViewController

@property(nonatomic)ViewType type;
@end

