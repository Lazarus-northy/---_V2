//
//  AppDelegate.h
//  计算器_V2
//
//  Created by lanou3g on 14-5-24.
//  Copyright (c) 2014年 蓝鸥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITextFieldDelegate>
{
    UITextField * _firstTextField;
    UITextField * _secondTextField;
    UILabel * _resultLabel;
    UILabel * _operatorLabel;//运算符
}
@property (retain, nonatomic) UIWindow *window;

@end
