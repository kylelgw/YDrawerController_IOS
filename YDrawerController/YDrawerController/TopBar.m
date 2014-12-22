//
//  TopBar.m
//  YDrawerController
//
//  Created by guojunyi on 12/20/14.
//  Copyright (c) 2014 ___guojunyi___. All rights reserved.
//

#import "TopBar.h"

@interface TopBar()


@property (assign, nonatomic) id leftTarget;
@property (nonatomic) SEL leftAction;

@property (assign, nonatomic) id right1Target;
@property (nonatomic) SEL right1Action;

@property (assign, nonatomic) id right2Target;
@property (nonatomic) SEL right2Action;
@end


@implementation TopBar
@synthesize title = _title;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

#define BUTTON_WIDTH 44
#define BUTTON_HEIGHT 44
-(id)init{
    self = [super init];
    if(self){
        
        self.backgroundColor = UIColorFromRGBA(0x9c27b0ff);
        CGRect rect = [UIScreen mainScreen].bounds;
        self.frame = CGRectMake(0, 0, rect.size.width, NAVIGATION_BAR_HEIGHT);
        
        
        UIImageView *leftButton = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
        leftButton.contentMode = UIViewContentModeCenter;
        leftButton.image = [UIImage imageNamed:@"ic_menu.png"];
        leftButton.userInteractionEnabled = YES;
        [self addSubview:leftButton];
        
        UITapGestureRecognizer *leftTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onLeftPress:)];
        
        [leftButton addGestureRecognizer:leftTapGesture];

        UIImageView *rightButton1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-BUTTON_WIDTH, self.frame.size.height-BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
        rightButton1.contentMode = UIViewContentModeCenter;
        rightButton1.image = [UIImage imageNamed:@"ic_apps_black_18dp.png"];
        rightButton1.userInteractionEnabled = YES;
        [self addSubview:rightButton1];
        self.rightButton1 = rightButton1;
        
        UITapGestureRecognizer *right1TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRight1Press:)];
        [rightButton1 addGestureRecognizer:right1TapGesture];
        
        UIImageView *rightButton2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-BUTTON_WIDTH*2, self.frame.size.height-BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT)];
        rightButton2.contentMode = UIViewContentModeCenter;
        rightButton2.image = [UIImage imageNamed:@"ic_bluetooth_black_18dp.png"];
        rightButton2.userInteractionEnabled = YES;
        [self addSubview:rightButton2];
        self.rightButton2 = rightButton2;
        
        UITapGestureRecognizer *right2TapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRight2Press:)];
        [rightButton2 addGestureRecognizer:right2TapGesture];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BUTTON_WIDTH, self.frame.size.height-BUTTON_HEIGHT, self.frame.size.width-BUTTON_WIDTH*3, BUTTON_HEIGHT)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
    }
    return self;
}

-(void)setLeftButtonActionWithTarget:(id)target andAction:(SEL)action{
    self.leftTarget = target;
    self.leftAction = action;
}

-(void)setRightButton1ActionWithTarget:(id)target andAction:(SEL)action{
    self.right1Target = target;
    self.right1Action = action;
}

-(void)setRightButton2ActionWithTarget:(id)target andAction:(SEL)action{
    self.right2Target = target;
    self.right2Action = action;
}

-(void)onLeftPress:(UITapGestureRecognizer*)recognizer{
    if ([self.leftTarget respondsToSelector:self.leftAction])
        [self.leftTarget performSelector:self.leftAction];
}

-(void)onRight1Press:(UITapGestureRecognizer*)recognizer{
    if ([self.right1Target respondsToSelector:self.right1Action])
        [self.right1Target performSelector:self.right1Action];
}

-(void)onRight2Press:(UITapGestureRecognizer*)recognizer{
    if ([self.right2Target respondsToSelector:self.right2Action])
        [self.right2Target performSelector:self.right2Action];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

@end
