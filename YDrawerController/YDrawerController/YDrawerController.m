//
//  YDrawerController.m
//  YDrawerController
//
//  Created by guojunyi on 12/19/14.
//  Copyright (c) 2014 ___guojunyi___. All rights reserved.
//

#import "YDrawerController.h"
#import "LeftMenuController.h"
#import "ContainerController.h"
#import "TopBar.h"



@implementation UIViewController (JDSideMenu)
- (YDrawerController*)drawerController;
{
//    if ([self.parentViewController isKindOfClass:[YDrawerController class]]) {
//        return (YDrawerController*)self.parentViewController;
//    }
    UIViewController *controller = self;
    
    while(nil!=controller){
        if ([controller.parentViewController isKindOfClass:[YDrawerController class]]) {
            return (YDrawerController*)controller.parentViewController;
        }else{
            controller = controller.parentViewController;
        }
    }
    
    return nil;
}
@end





@interface YDrawerController ()


@property (strong,nonatomic) UIPanGestureRecognizer *panGesture;
@property (strong,nonatomic) UIView *leftContainer;

@property (nonatomic) CGFloat sliderFactor;

@property (nonatomic,strong) UIView *menuViewTask;
@property (nonatomic,strong) UIView *menuView;
@end

@implementation YDrawerController
@synthesize leftMenuController = _leftMenuController;
@synthesize containerController = _containerController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.isShowLeftMenu = NO;
        self.sliderEnable = YES;
        self.sliderFactor = 0.1f;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    TopBar *topBar = [[TopBar alloc] init];
    [self.view addSubview:topBar];
    self.topBar = topBar;
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panRecognized:)];
    [self.view addGestureRecognizer:self.panGesture];
    
    UIView *leftContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [leftContainer setHidden:YES];
    
    UIView *leftBlankSpace = [[UIView alloc] initWithFrame:CGRectMake(LEFT_MENU_WIDTH, 0, leftContainer.frame.size.width-LEFT_MENU_WIDTH, leftContainer.frame.size.height)];
    [leftContainer addSubview:leftBlankSpace];
    

    
    [self.view addSubview:leftContainer];
    self.leftContainer = leftContainer;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognized:)];
    [leftBlankSpace addGestureRecognizer:tapGesture];
}

-(void)setLeftMenuController:(UIViewController *)leftMenuController{
    [self.topBar setLeftButtonActionWithTarget:nil andAction:nil];
    [self.topBar setRightButton1ActionWithTarget:nil andAction:nil];
    [self.topBar setRightButton2ActionWithTarget:nil andAction:nil];
    if(_leftMenuController!=nil){
        [_leftMenuController willMoveToParentViewController:nil];
        [_leftMenuController removeFromParentViewController];
        [_leftMenuController.view removeFromSuperview];
    }
    
    _leftMenuController = leftMenuController;
    [self addChildViewController:_leftMenuController];
    [self didMoveToParentViewController:self];
    
    _leftMenuController.view.frame = CGRectMake(-LEFT_MENU_WIDTH, 0, LEFT_MENU_WIDTH, self.view.frame.size.height);
    
    _leftMenuController.view.layer.masksToBounds = NO;
    
    
    _leftMenuController.view.layer.cornerRadius = 2.0f;
    _leftMenuController.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    _leftMenuController.view.layer.shadowOffset = CGSizeMake(SHADOW_WIDTH,0.0);
    _leftMenuController.view.layer.shadowOpacity = 0.6;
    
    [self.leftContainer addSubview:_leftMenuController.view];
}

-(void)setContainerController:(UIViewController *)containerController{
    [self.topBar setLeftButtonActionWithTarget:nil andAction:nil];
    [self.topBar setRightButton1ActionWithTarget:nil andAction:nil];
    [self.topBar setRightButton2ActionWithTarget:nil andAction:nil];
    if(_containerController!=nil){
        [_containerController willMoveToParentViewController:nil];
        [_containerController removeFromParentViewController];
        [_containerController.view removeFromSuperview];
    }
    
    _containerController = containerController;
    [self addChildViewController:_containerController];
    [self didMoveToParentViewController:self];
    
    _containerController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _containerController.view.layer.masksToBounds = YES;
    [self.view insertSubview:_containerController.view atIndex:0];
}

-(void)setContainerToController:(UIViewController *)containerController withAnim:(void (^)(UIViewController *))callback{
    if(_containerController!=nil){
        [_containerController willMoveToParentViewController:nil];
        [_containerController removeFromParentViewController];
        [_containerController.view removeFromSuperview];
        _containerController = nil;
    }
    
    
    
    
    _containerController = containerController;
    [self addChildViewController:_containerController];
    [self didMoveToParentViewController:self];
    
    
    _containerController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _containerController.view.layer.masksToBounds = YES;
    [self.view insertSubview:_containerController.view atIndex:0];
    
    callback(_containerController);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapRecognized:(UITapGestureRecognizer*)recognizer{
    
    CGPoint translation = [recognizer locationInView:self.leftContainer];
    if(translation.x>LEFT_MENU_WIDTH){
        [self hideLeftMenu];
    }
    
}

- (void)panRecognized:(UIPanGestureRecognizer*)recognizer
{
    
    if(nil==_leftMenuController||!self.sliderEnable||self.menuView!=nil){
        return;
    }
    
    static BOOL canSlider = NO;
    
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint location = [recognizer locationInView:self.view];
    
        switch (recognizer.state) {
        
        case UIGestureRecognizerStateBegan: {
            
            if(!self.isShowLeftMenu&&location.x>self.sliderFactor*self.view.frame.size.width){
                canSlider = NO;
            }else{
                canSlider = YES;
            }
            
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            NSLog(@"--%f",location.x);
            if(canSlider){
                [self.leftContainer setHidden:NO];
                if(self.isShowLeftMenu){
                    
                    [self.leftMenuController.view setTransform:CGAffineTransformMakeTranslation(MIN(LEFT_MENU_WIDTH,MAX(0,LEFT_MENU_WIDTH+translation.x)), 0)];
                    
                }else{
                    [self.leftMenuController.view setTransform:CGAffineTransformMakeTranslation(MIN(LEFT_MENU_WIDTH,translation.x), 0)];
                    
                }
            }
            
            
            
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            NSLog(@"%f",self.leftMenuController.view.frame.origin.x);
            canSlider = NO;
            if(!self.isShowLeftMenu&&((self.leftMenuController.view.frame.origin.x+LEFT_MENU_WIDTH)>LEFT_MENU_WIDTH/3)){
                [self showLeftMenu];
            }else if(self.isShowLeftMenu&&((self.leftMenuController.view.frame.origin.x+LEFT_MENU_WIDTH)>LEFT_MENU_WIDTH/3*2)){
                [self showLeftMenu];
            }else{
                [self hideLeftMenu];
            }
        }
        default:
            break;
    }
}

-(void)showLeftMenu{
    self.isShowLeftMenu = YES;
    [self.leftContainer setHidden:NO];
    [UIView transitionWithView:self.leftMenuController.view duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
        [self.leftMenuController.view setTransform:CGAffineTransformMakeTranslation(LEFT_MENU_WIDTH, 0)];
        
        self.leftContainer.backgroundColor = UIColorFromRGBA(0x00000000);
    } completion:^(BOOL finished) {
        
    }];

}

-(void)hideLeftMenu{
    self.isShowLeftMenu = NO;
    [UIView transitionWithView:self.leftMenuController.view duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
        [self.leftMenuController.view setTransform:CGAffineTransformMakeTranslation(0, 0)];
        self.leftContainer.backgroundColor = UIColorFromRGBA(0x00000000);
    } completion:^(BOOL finished) {
        [self.leftContainer setHidden:YES];
    }];
}


-(void)showTopBar{
    [UIView transitionWithView:self.leftMenuController.view duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
        self.topBar.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideTopBar{
    [UIView transitionWithView:self.leftMenuController.view duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
        self.topBar.transform = CGAffineTransformMakeTranslation(0, -self.topBar.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}


-(void)showMenuView1WithView:(UIView *)view{
    if(nil==self.menuView&&nil==self.menuViewTask){
        CGFloat x = self.topBar.rightButton1.frame.origin.x-view.frame.size.width+self.topBar.rightButton1.frame.size.width/2;
        CGFloat y = self.topBar.rightButton1.frame.origin.y+self.topBar.rightButton1.frame.size.height/2;
        
        view.frame = CGRectMake(x+view.frame.size.width/2, y-view.frame.size.height/2, view.frame.size.width, view.frame.size.height);
        
        
        
        UIButton *menuViewTask = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        menuViewTask.userInteractionEnabled = YES;
        [self.view addSubview:menuViewTask];
        [self.view addSubview:view];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMenuViewMaskPress:)];
        [menuViewTask addGestureRecognizer:tapGesture];
        
        self.menuView = view;
        self.menuViewTask = menuViewTask;
        
        self.menuView.layer.anchorPoint = CGPointMake(1.0,0.0);
        
        self.menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView transitionWithView:self.menuView duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
            self.menuView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            
        } completion:^(BOOL finished) {
            
        }];
    }
}


-(void)showMenuView2WithView:(UIView *)view{
    if(nil==self.menuView&&nil==self.menuViewTask){
        CGFloat x = self.topBar.rightButton2.frame.origin.x-view.frame.size.width+self.topBar.rightButton2.frame.size.width/2;
        CGFloat y = self.topBar.rightButton2.frame.origin.y+self.topBar.rightButton2.frame.size.height/2;
        
        view.frame = CGRectMake(x+view.frame.size.width/2, y-view.frame.size.height/2, view.frame.size.width, view.frame.size.height);
        

        
        UIView *menuViewTask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        menuViewTask.userInteractionEnabled = YES;
        [self.view addSubview:menuViewTask];
        [self.view addSubview:view];
        
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMenuViewMaskPress:)];
        [menuViewTask addGestureRecognizer:tapGesture];

        self.menuView = view;
        self.menuViewTask = menuViewTask;
        
        self.menuView.layer.anchorPoint = CGPointMake(1.0,0.0);
        
        self.menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        [UIView transitionWithView:self.menuView duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
            self.menuView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            

        } completion:^(BOOL finished) {
            
        }];
    }
}

-(void)onMenuViewMaskPress:(UITapGestureRecognizer*)recognizer{
    
    CGPoint localtion = [recognizer locationInView:self.menuView];
    NSLog(@"%f %f",localtion.x,localtion.y);
    
    if(localtion.x>=0&&localtion.x<self.menuView.frame.size.width&&localtion.y>0&&localtion.y<self.menuView.frame.size.height){
        
    }else{
        [self hideMenuView];
    }
    
    
}

-(void)hideMenuView{
    
    [UIView transitionWithView:self.menuView duration:0.3 options:UIViewAnimationCurveEaseInOut animations:^{
        self.menuView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.menuView removeFromSuperview];
        [self.menuViewTask removeFromSuperview];
        self.menuViewTask = nil;
        self.menuView = nil;
    }];
    
    
   
}
@end
