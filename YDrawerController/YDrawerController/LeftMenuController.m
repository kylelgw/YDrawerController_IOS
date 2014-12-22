//
//  LeftMenuController.m
//  YDrawerController
//
//  Created by guojunyi on 12/19/14.
//  Copyright (c) 2014 ___guojunyi___. All rights reserved.
//

#import "LeftMenuController.h"
#import "YDrawerController.h"
#import "TestController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Color.h"
#import "ContainerController.h"
@interface LeftMenuController ()

@end

@implementation LeftMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define TOP_VIEW_HEIGHT 120
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, LEFT_MENU_WIDTH, TOP_VIEW_HEIGHT)];
    topView.backgroundColor = UIColorFromRGBA(0x9c27b0ff);
    [self.view addSubview:topView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, TOP_VIEW_HEIGHT, LEFT_MENU_WIDTH, self.view.frame.size.height-TOP_VIEW_HEIGHT) style:UITableViewStylePlain];
    
    if(CURRENT_VERSION>=7.0){
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
   
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    UIView *footerView = [[UIView alloc] init];
    tableView.tableFooterView = footerView;
    
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    // Do any additional setup after loading the view.
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 4;
    }else{
        return 2;
    }

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    switch(indexPath.section){
        case 0:
        {
            if(indexPath.row==0){
                
                if([indexPath isEqual:self.selectedIndexPath]){
                    cell.imageView.image = [[UIImage imageNamed:@"ic_room_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x9c27b0ff)];
                    cell.textLabel.textColor = UIColorFromRGBA(0x9c27b0ff);
                    
                }else{
                    cell.imageView.image = [[UIImage imageNamed:@"ic_room_black_18dp.png"] imageTintedWithColor:[UIColor blackColor]];
                    cell.textLabel.textColor = [UIColor blackColor];
                }
                
                cell.textLabel.text = @"KGL";
            }else if(indexPath.row==1){
                
                if([indexPath isEqual:self.selectedIndexPath]){
                    cell.imageView.image = [[UIImage imageNamed:@"ic_camera_alt_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x9c27b0ff)];
                    cell.textLabel.textColor = UIColorFromRGBA(0x9c27b0ff);
                    
                }else{
                    cell.imageView.image = [[UIImage imageNamed:@"ic_camera_alt_black_18dp.png"] imageTintedWithColor:[UIColor blackColor]];
                    cell.textLabel.textColor = [UIColor blackColor];
                }
                
                
                
                cell.textLabel.text = @"Camera";
            }else if(indexPath.row==2){
                
                if([indexPath isEqual:self.selectedIndexPath]){
                    cell.imageView.image = [[UIImage imageNamed:@"ic_mic_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x9c27b0ff)];
                    cell.textLabel.textColor = UIColorFromRGBA(0x9c27b0ff);
                    
                }else{
                    cell.imageView.image = [[UIImage imageNamed:@"ic_mic_black_18dp.png"] imageTintedWithColor:[UIColor blackColor]];
                    cell.textLabel.textColor = [UIColor blackColor];
                }
                
                
                cell.textLabel.text = @"Sound";
            }else if(indexPath.row==3){
                if([indexPath isEqual:self.selectedIndexPath]){
                    cell.imageView.image = [[UIImage imageNamed:@"ic_track_changes_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x9c27b0ff)];
                    cell.textLabel.textColor = UIColorFromRGBA(0x9c27b0ff);
                    
                }else{
                    cell.imageView.image = [[UIImage imageNamed:@"ic_track_changes_black_18dp.png"] imageTintedWithColor:[UIColor blackColor]];
                    cell.textLabel.textColor = [UIColor blackColor];
                }
                cell.textLabel.text = @"Radar";
            }
        }
            break;
        case 1:
        {
            if(indexPath.row==0){
                if([indexPath isEqual:self.selectedIndexPath]){
                    cell.imageView.image = [[UIImage imageNamed:@"ic_new_releases_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x9c27b0ff)];
                    cell.textLabel.textColor = UIColorFromRGBA(0x9c27b0ff);
                    
                }else{
                    cell.imageView.image = [[UIImage imageNamed:@"ic_new_releases_black_18dp.png"] imageTintedWithColor:[UIColor blackColor]];
                    cell.textLabel.textColor = [UIColor blackColor];
                }
                cell.textLabel.text = @"FAQ";
            }else if(indexPath.row==1){
                if([indexPath isEqual:self.selectedIndexPath]){
                    cell.imageView.image = [[UIImage imageNamed:@"ic_settings_applications_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x9c27b0ff)];
                    cell.textLabel.textColor = UIColorFromRGBA(0x9c27b0ff);
                    
                }else{
                    cell.imageView.image = [[UIImage imageNamed:@"ic_settings_applications_black_18dp.png"] imageTintedWithColor:[UIColor blackColor]];
                    cell.textLabel.textColor = [UIColor blackColor];
                }
                cell.textLabel.text = @"Settings";
            }
        }
            break;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
  
    
    self.selectedIndexPath = indexPath;
    [tableView reloadData];
    
    [self.drawerController hideLeftMenu];
    
    switch(indexPath.section){
        case 0:
        {
            if(indexPath.row==0){
                
                
                ContainerController *containerController = [[ContainerController alloc] init];
                
                [self.drawerController setContainerToController:containerController withAnim:^(UIViewController *controller) {
                    containerController.view.backgroundColor = UIColorFromRGBA(0xab47bcff);
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        containerController.view.layer.cornerRadius = containerController.view.frame.size.height;
                        while(containerController.view.layer.cornerRadius>0){
                            dispatch_async(dispatch_get_main_queue(), ^{
                                containerController.view.layer.cornerRadius -= containerController.view.frame.size.height/5;
                            });
                            
                            NSLog(@"%f",containerController.view.layer.cornerRadius);
                            usleep(100000);
                        }
                    });
                }];
            }else if(indexPath.row==1){
                ContainerController *containerController = [[ContainerController alloc] init];
                
                [self.drawerController setContainerToController:containerController withAnim:^(UIViewController *controller) {
                    containerController.view.backgroundColor = UIColorFromRGBA(0xe91e63ff);
                    [UIView transitionWithView:containerController.view duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
                        
                        containerController.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.5, 0.5), CGAffineTransformMakeRotation(3.14));
                        
                    } completion:^(BOOL finished) {
                        [UIView transitionWithView:containerController.view duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
                            
                            containerController.view.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(1.0, 1.0), CGAffineTransformMakeRotation(0));
                            
                        } completion:^(BOOL finished) {
                            
                        }];
                    }];
                }];
                
                
            }else if(indexPath.row==2){
                ContainerController *containerController = [[ContainerController alloc] init];
                
                [self.drawerController setContainerToController:containerController withAnim:^(UIViewController *controller) {
                    containerController.view.backgroundColor = UIColorFromRGBA(0x03a9f4ff);
                    
                }];
                
            }else if(indexPath.row==3){
                self.drawerController.containerController.view.backgroundColor = UIColorFromRGBA(0x795548ff);
            }
        }
            break;
        case 1:
        {
            if(indexPath.row==0){
                self.drawerController.containerController.view.backgroundColor = UIColorFromRGBA(0x212121ff);
                
            }else if(indexPath.row==1){
                self.drawerController.containerController.view.backgroundColor = UIColorFromRGBA(0xff5722ff);
            }
        }
            break;
    }
    
        
}




-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section==1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0)];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==1){
        return 50;
    }else{
        return 0;
    }
}



@end
