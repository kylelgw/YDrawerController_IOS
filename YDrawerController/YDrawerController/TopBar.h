//
//  TopBar.h
//  YDrawerController
//
//  Created by guojunyi on 12/20/14.
//  Copyright (c) 2014 ___guojunyi___. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NAVIGATION_BAR_HEIGHT ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0 ? (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 64:44):(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 64:64))

@interface TopBar : UIView
@property (strong,nonatomic) UILabel *titleLabel;
@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) UIImageView *rightButton1;
@property (strong,nonatomic) UIImageView *rightButton2;
-(void)setLeftButtonActionWithTarget:(id)target andAction:(SEL)action;
-(void)setRightButton1ActionWithTarget:(id)target andAction:(SEL)action;
-(void)setRightButton2ActionWithTarget:(id)target andAction:(SEL)action;
@end
