//
//  ContainerController.h
//  YDrawerController
//
//  Created by guojunyi on 12/19/14.
//  Copyright (c) 2014 ___guojunyi___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView *menuTableView;
@end
