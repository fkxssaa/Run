//
//  meViewController.m
//  Run
//
//  Created by fkx on 15/11/2.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import "meViewController.h"

@interface meViewController ()

@end

@implementation meViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人资料";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(120, 65, 80, 80)];
    [headImageView.layer setMasksToBounds:YES];
    [headImageView.layer setCornerRadius:40];
    headImageView.image = [UIImage imageNamed:@"5"];
    
    usernameLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 170, 280, 150)];
    usernameLabel.numberOfLines = 4;
    usernameLabel.textColor = [UIColor whiteColor];
    
    [usernameLabel setTextAlignment:NSTextAlignmentCenter];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    usernameLabel.text = [NSString stringWithFormat:@"用户名：%@ \n\n\n关注度50",[userDefaults stringForKey:@"username"]];
    
    friends = [[UILabel alloc]init];
    
    looked = [[UILabel alloc]init];
    
    logout = [[UIButton alloc]initWithFrame:CGRectMake(0, 350, 320, 60)];
    [logout setBackgroundColor:[UIColor redColor]];
    [logout setTitle:@"退出" forState:UIControlStateNormal];
    [logout addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:logout];
    [self.view addSubview:headImageView];
    [self.view addSubview:usernameLabel];
    [self.view addSubview:friends];
    [self.view addSubview:looked];
    // Do any additional setup after loading the view.
}

-(void)logoutAction
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"username"];
    [userDefaults setObject:nil forKey:@"objectId"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
