//
//  TestController.m
//  YDrawerController
//
//  Created by guojunyi on 12/20/14.
//  Copyright (c) 2014 ___guojunyi___. All rights reserved.
//

#import "TestController.h"
#import "TopBar.h"
#import "YDrawerController.h"
@interface TestController ()

@end

@implementation TestController

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
    self.view.backgroundColor = [UIColor grayColor];
    
    TopBar *topBar = self.drawerController.topBar;
    topBar.title = @"Containner";
    [topBar setLeftButtonActionWithTarget:self andAction:@selector(onLeftPress)];
    
    [topBar setRightButton1ActionWithTarget:self andAction:@selector(onRight1Press)];
    [topBar setRightButton2ActionWithTarget:self andAction:@selector(onRight2Press)];
    // Do any additional setup after loading the view.
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
