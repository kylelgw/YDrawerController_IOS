//
//  YDrawerController.h
//  YDrawerController
//
//  Created by guojunyi on 12/19/14.
//  Copyright (c) 2014 ___guojunyi___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YDrawerController;
@interface UIViewController (YDrawerController)

- (YDrawerController*)drawerController;

@end


#define LEFT_MENU_WIDTH 200
#define SHADOW_WIDTH 3

@class TopBar;
@interface YDrawerController : UIViewController
@property (strong,nonatomic) TopBar *topBar;
@property (strong,nonatomic) UIViewController *leftMenuController;
@property (strong,nonatomic) UIViewController *containerController;
@property (nonatomic) BOOL sliderEnable;
@property (nonatomic) BOOL isShowLeftMenu;

-(void)showLeftMenu;
-(void)hideLeftMenu;

-(void)showTopBar;
-(void)hideTopBar;

-(void)showMenuView1WithView:(UIView*)view;
-(void)showMenuView2WithView:(UIView*)view;

-(void)setContainerToController:(UIViewController *)containerController withAnim:(void(^)(UIViewController *controller))callback;
@end
