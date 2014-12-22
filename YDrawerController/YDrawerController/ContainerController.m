//
//  ContainerController.m
//  YDrawerController
//
//  Created by guojunyi on 12/19/14.
//  Copyright (c) 2014 ___guojunyi___. All rights reserved.
//

#import "ContainerController.h"
#import "TopBar.h"
#import "YDrawerController.h"
#import "UIImage+Color.h"
#import "TestController.h"
@interface ContainerController ()

@end

@implementation ContainerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    TopBar *topBar = self.drawerController.topBar;
    topBar.title = @"Containner";
    [topBar setLeftButtonActionWithTarget:self andAction:@selector(onLeftPress)];
    
    [topBar setRightButton1ActionWithTarget:self andAction:@selector(onRight1Press)];
    [topBar setRightButton2ActionWithTarget:self andAction:@selector(onRight2Press)];
    
    NSLog(@"%f",self.view.frame.size.height);

    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(90, 100, 140, 44);
    [button1 addTarget:self action:@selector(onButton1Press) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"HideTopBar" forState:UIControlStateNormal];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(90, 184, 140, 44);
    [button2 addTarget:self action:@selector(onButton2Press) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"ShowTopBar" forState:UIControlStateNormal];
    
    
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];

    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onLeftPress{
    [self.drawerController showLeftMenu];
}

-(void)onRight1Press{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 120,44*3) style:UITableViewStylePlain];
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    
    tableView.layer.cornerRadius = 5.0;
    tableView.layer.shadowColor = [[UIColor blackColor] CGColor];
    tableView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    tableView.layer.shadowOpacity = 0.6;
    tableView.scrollEnabled = NO;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height)];
    
    view.layer.cornerRadius = 5.0;
    view.layer.shadowOpacity = 0.9;
    view.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    [view addSubview:tableView];
    
    [self.drawerController showMenuView1WithView:view];
}

-(void)onRight2Press{
    UIImageView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    view.backgroundColor = UIColorFromRGBA(0xeeeeeeff);
    view.layer.cornerRadius = 60.0;
    view.layer.shadowOpacity = 0.9;
    view.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-120)/2, (view.frame.size.height-120)/2, 120, 120)];
    imageView.layer.cornerRadius = 60.0;
    imageView.layer.masksToBounds = YES;
    
    
    
    imageView.image = [UIImage imageNamed:@"BG.png"];
    [view addSubview:imageView];
    
    [self.drawerController showMenuView2WithView:view];
}

-(void)onButton1Press{
    [self.drawerController hideTopBar];
    
}

-(void)onButton2Press{
    [self.drawerController showTopBar];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.textColor = UIColorFromRGBA(0x303030ff);
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    
    if(indexPath.row==0){
        
        cell.imageView.image = [[UIImage imageNamed:@"ic_settings_applications_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x303030ff)];
        cell.textLabel.text = @"KGL";
    }else if(indexPath.row==1){
        
        cell.imageView.image = [[UIImage imageNamed:@"ic_camera_alt_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x303030ff)];
        cell.textLabel.text = @"Camera";
    }else if(indexPath.row==2){
        
        cell.imageView.image = [[UIImage imageNamed:@"ic_room_black_18dp.png"] imageTintedWithColor:UIColorFromRGBA(0x303030ff)];
        cell.textLabel.text = @"...";
    }
    //cell.backgroundColor = [UIColor blackColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
