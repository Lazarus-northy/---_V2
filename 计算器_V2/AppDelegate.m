//
//  AppDelegate.m
//  计算器_V2
//
//  Created by lanou3g on 14-5-24.
//  Copyright (c) 2014年 蓝鸥. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)dealloc
{
    //释放实例变量
    [_firstTextField release];
    [_secondTextField release];
    [_resultLabel release];
    [_operatorLabel release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //键盘视图
    UIView * keyBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 400, 320, 260)];
    keyBoard.backgroundColor = [UIColor whiteColor];
    
    //键盘添加小键盘
    int count = 0;
    for (int i = 0 ; i < 4; i ++ ) {
        for (int j = 1 ; j < 5; j ++ ) {
            UIButton * keyBoardButton = [UIButton buttonWithType:UIButtonTypeSystem];
            keyBoardButton.frame = CGRectMake(4 * j+ 75 * (j - 1), 4 * (i + 1) + 60 * i, 75, 60);
            keyBoardButton.backgroundColor = [UIColor orangeColor];
            switch (i * 4 + j ) {
                    //11 + 22 - 33 * 44 / 55 <-
                case 4:
                    [keyBoardButton setTitle:@"+" forState:UIControlStateNormal];
                    keyBoardButton.tag = 11;
                    break;
                case 8:
                    [keyBoardButton setTitle:@"-" forState:UIControlStateNormal];
                    keyBoardButton.tag = 22;
                    break;
                case 12:
                    [keyBoardButton setTitle:@"*" forState:UIControlStateNormal];
                    keyBoardButton.tag = 33;
                    break;
                case 16:
                    [keyBoardButton setTitle:@"/" forState:UIControlStateNormal];
                    keyBoardButton.tag = 44;
                    break;
                case 13:
                    [keyBoardButton setTitle:@"." forState:UIControlStateNormal];
                    break;
                case 14:
                    [keyBoardButton setTitle:@"0" forState:UIControlStateNormal];
                    break;
                case 15:
                    [keyBoardButton setTitle:@"<-" forState:UIControlStateNormal];
                    keyBoardButton.tag = 55;
                    break;
                default:
                    [keyBoardButton setTitle:[NSString stringWithFormat:@"%d",++count] forState:UIControlStateNormal];
                    break;
            }
            [keyBoardButton addTarget:self action:@selector(didClickKeyBoardButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            //设置矩形四个圆角半径
            [keyBoardButton.layer setCornerRadius:15.0];
            //设置边框宽度
            [keyBoardButton.layer setBorderWidth:2.0];
            //设置边框颜色
            [keyBoardButton.layer setBorderColor:[[UIColor orangeColor] CGColor]];
            
            keyBoardButton.titleLabel.font= [UIFont systemFontOfSize: 30];
            [keyBoard addSubview:keyBoardButton];
        }
    }
    
    
    //小键盘
    UIView * acessoryView = [[UIView alloc] initWithFrame:CGRectMake(10, 320, 320, 30)];
    acessoryView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    //第一个输入框
    _firstTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 80, 60, 30)];
    _firstTextField.borderStyle = UITextBorderStyleRoundedRect;
    _firstTextField.inputView = keyBoard;
    _firstTextField.inputAccessoryView = acessoryView;
    [self.window addSubview:_firstTextField];
    
    //加号label
    _operatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 80, 20, 30)];
    _operatorLabel.text = @"+";
    [self.window addSubview:_operatorLabel];
    
    //第二个输入框
    _secondTextField = [[UITextField alloc] initWithFrame:CGRectMake(130, 80, 60, 30)];
    _secondTextField.borderStyle = UITextBorderStyleRoundedRect;
    _secondTextField.inputView = keyBoard;
    _secondTextField.inputAccessoryView = acessoryView;
    [self.window addSubview:_secondTextField];
    
    //等于
    UILabel * equalLabel = [[UILabel alloc] initWithFrame:CGRectMake(210, 80, 20, 30)];
    equalLabel.text = @"=";
    [self.window addSubview:equalLabel];
    [equalLabel release];
    
    //结果label
    _resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 80, 60, 30)];
    _resultLabel.backgroundColor = [UIColor orangeColor];
    [self.window addSubview:_resultLabel];
    
    //计算
    UIButton * caculatorButton = [UIButton buttonWithType:UIButtonTypeSystem];
    caculatorButton.frame = CGRectMake(250, 0, 50, 30);
    [caculatorButton setTitle:@"计算" forState:UIControlStateNormal];
    [caculatorButton addTarget:self action:@selector(didClickCaculatorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //[self.window addSubview:caculatorButton];
    [acessoryView addSubview:caculatorButton];
    
    
    //清除
    UIButton * clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clearButton.frame = CGRectMake(200, 0, 50, 30);
    [clearButton setTitle:@"清除" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(didClickClearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    //[self.window addSubview:clearButton];
    [acessoryView addSubview:clearButton];
    
    
    [acessoryView release];
    [keyBoard release];
    return YES;
}

//清除button的方法
- (void)didClickClearButtonAction:(UIButton *)button
{
    _firstTextField.text = nil;
    _secondTextField.text = nil;
    _resultLabel.text = nil;
    _operatorLabel.text = @"+";
}

//键盘button的方法
- (void)didClickKeyBoardButtonAction:(UIButton *)button
{
    UITextField * tf = [_firstTextField isEditing]?_firstTextField:_secondTextField;
    //11 + 22 - 33 * 44 / 55 <-
    switch (button.tag) {
        case 11:
            //+
            _operatorLabel.text = @"+";
            break;
        case 22:
            //-
            _operatorLabel.text = @"-";
            break;
        case 33:
            //*
            _operatorLabel.text = @"*";
            break;
        case 44:
            // /
            _operatorLabel.text = @"/";
            break;
        case 55:
            //清除最后一个
            if (tf.text.length > 0) {
                tf.text = [tf.text substringToIndex:tf.text.length-1];
            }
            break;
        default:
            //拼接起来
            tf.text = [tf.text stringByAppendingString:[button titleForState:UIControlStateNormal]];
            break;
    }
    
    
}

//计算caculatorButton方法
- (void)didClickCaculatorButtonAction:(UIButton *)button
{
    float num1 = [_firstTextField.text floatValue];
    float num2 = [_secondTextField.text floatValue];
    float result;
    switch ([_operatorLabel.text characterAtIndex:0]) {
        case '+':
            result = num1 + num2;
            break;
        case '-':
            result = num1 - num2;
            break;
        case '*':
            result = num1 * num2;
            break;
        case '/':
            if (num2 != 0) {
                result = num1 / num2;
            }else{
                result = 0;
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"除数不能为0" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [alert release];
            }
            
            break;
        default:
            break;
    }
    
    NSString * resultStr = [NSString stringWithFormat:@"%.2f",result];
    if ([resultStr rangeOfString:@".00"].length > 0) {
        _resultLabel.text = [resultStr substringToIndex:resultStr.length - 3];
    }else{
        if ([resultStr hasSuffix:@"0"]) {
            _resultLabel.text = [resultStr substringToIndex:resultStr.length - 1];
        }else{
            _resultLabel.text = resultStr;
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

