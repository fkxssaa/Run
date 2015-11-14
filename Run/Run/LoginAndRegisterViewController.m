//
//  LoginAndRegisterViewController.m
//  Run
//
//  Created by fkx on 15/10/29.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import "LoginAndRegisterViewController.h"
#import "User.h"
#import <BmobSDK/Bmob.h>
#import "planViewController.h"
#import "runViewController.h"
#import "countViewController.h"
#import "newsViewController.h"
#import "meViewController.h"
#import "LoginPageTableViewCell.h"

@interface LoginAndRegisterViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation LoginAndRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.navigationController.navigationBarHidden = YES;
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    [headView setTintColor:[UIColor clearColor]];
    
    headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 70, 80, 80)];
    [headImageView.layer setMasksToBounds:YES];
    [headImageView.layer setCornerRadius:40];
    headImageView.image = [UIImage imageNamed:@"5"];
    
    _changeSegData = @[@"登录",@"注册"];
    changeSeg = [[UISegmentedControl alloc]initWithItems:_changeSegData];
    [changeSeg setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"changeLeft"]]];
    [changeSeg setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
//    [changeSeg setTintColor:[UIColor clearColor]];
    changeSeg.selectedSegmentIndex = 0;
    changeSeg.frame = CGRectMake(0, 140, 320, 60);
    [changeSeg addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventValueChanged];
    
    [headView addSubview:headImageView];
    [headView addSubview:changeSeg];
    [self.view addSubview:headView];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(20, 200, 280, 120)];
    table.backgroundColor = [UIColor clearColor];
    [table.tableHeaderView removeFromSuperview];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 30, 30)];
    userImageView.image = [UIImage imageNamed:@"username"];
    
    pswdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 27, 30)];
    pswdImageView.image = [UIImage imageNamed:@"password"];
    
    userNameTf = [[UITextField alloc]initWithFrame:CGRectMake(65, 23, 230, 30)];
    userNameTf.borderStyle = UITextBorderStyleNone;
    userNameTf.placeholder = @"用户名";
    [userNameTf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [userNameTf setTextColor:[UIColor whiteColor]];
    
    
    pswdTf = [[UITextField alloc]initWithFrame:CGRectMake(65, 23, 230, 30)];
    [pswdTf setSecureTextEntry:YES];
    pswdTf.borderStyle = UITextBorderStyleNone;
    pswdTf.placeholder = @"密码";
    [pswdTf setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [pswdTf setTextColor:[UIColor whiteColor]];
    
    loginButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 380, 280, 50)];
    [loginButton.titleLabel setTextColor:[UIColor whiteColor]];
    [loginButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageNamed:@"button-background"] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginActioin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    registerButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 380, 280, 50)];
    [registerButton.titleLabel setTextColor:[UIColor whiteColor]];
    [registerButton.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage imageNamed:@"button-background"] forState:UIControlStateNormal];
//    registerButton.backgroundColor = [UIColor brownColor];
//    [registerButton setBackgroundImage:[UIImage imageNamed:@"register"] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [userNameTf resignFirstResponder];
    [pswdTf resignFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MyCell";
    LoginPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[LoginPageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    if (indexPath.row == 0) {
        [cell.contentView addSubview:userImageView];
        [cell.contentView addSubview:userNameTf];
    } else {
        [cell.contentView addSubview:pswdImageView];
        [cell.contentView addSubview:pswdTf];
    }
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)loginActioin
{
    User *mUser = [[User alloc]init];
    mUser.username = userNameTf.text;
    mUser.pswd = pswdTf.text;
    if ((nil == mUser.username )|| (nil == mUser.pswd)) {
        UIAlertView *emptyAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码未填写!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [emptyAlert show];
    } else {
        __block BOOL isUser = 0;
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"User"];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {	
            for (BmobObject *obj in array) {
                if ([mUser.username isEqualToString:[[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"username"]]] && [mUser.pswd isEqualToString:[[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"password"]]]) {
                    isUser = 1;
                    planViewController *planView = [[planViewController alloc]init];
                    UINavigationController *planNav = [[UINavigationController alloc]initWithRootViewController:planView];
                    [planNav.navigationBar setBarTintColor:[UIColor colorWithWhite:0 alpha:0.8]];
                    [planNav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
                    runViewController *runView = [[runViewController alloc]init];
                    countViewController *countView = [[countViewController alloc]init];
                    newsViewController *newsView = [[newsViewController alloc]init];
                    UINavigationController *newsNav = [[UINavigationController alloc]initWithRootViewController:newsView];
                    [newsNav.navigationBar setBarTintColor:[UIColor colorWithWhite:0 alpha:0.8]];
                    [newsNav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
                    meViewController *meView = [[meViewController alloc]init];
                    
                    
                    NSArray *array = @[planNav,runView,countView,newsNav,meView];
                    UITabBarController *tabar = [[UITabBarController alloc]init];
                    tabar.viewControllers = array;
                    UITabBar *tabBar = tabar.tabBar;
                    [tabBar setBarTintColor:[UIColor colorWithWhite:0.3 alpha:0.3]];
                    
                    UITabBarItem *tabBarItem0 = [tabBar.items objectAtIndex:0];
                    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:1];
                    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:2];
                    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:3];
                    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:4];
                    
                    tabBarItem0.image = [UIImage imageNamed:@"item0"];
                    tabBarItem0.title = @"计划";
                    tabBarItem1.image = [UIImage imageNamed:@"item1"];
                    tabBarItem1.title = @"计时";
                    tabBarItem2.image = [UIImage imageNamed:@"item2"];
                    tabBarItem2.title = @"统计";
                    tabBarItem3.image = [UIImage imageNamed:@"item3"];
                    tabBarItem3.title = @"动态";
                    tabBarItem4.image = [UIImage imageNamed:@"item4"];
                    tabBarItem4.title = @"我";
                    
                    [self.navigationController.navigationBar removeFromSuperview];
                    [self.navigationController pushViewController:tabar animated:YES];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:[obj objectForKey:@"username"] forKey:@"username"];
                    [userDefaults setObject:[obj objectForKey:@"Id"] forKey:@"objectId"];
                    
                    [userNameTf setText:nil];
                    [pswdTf setText:nil];
                    
                    break;
                }
            }
            if (isUser == 0) {
                UIAlertView *loginErroeAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码错误，\n请重新输入。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                userNameTf.text = nil;
                pswdTf.text = nil;
                [loginErroeAlert show];
            }
        }];
    }
}

-(BOOL)isUser:(User *)user
{
    __block BOOL isUser = 0;
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"Username"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([user.username isEqualToString:[[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"username"]]] && [user.pswd isEqualToString:[[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"password"]]]) {
                isUser = 1;
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:[obj objectForKey:@"username"] forKey:@"username"];
                [userDefaults setObject:[obj objectForKey:@"Id"] forKey:@"objectId"];
                break;
            }
        }
    }];
    return isUser;
}

-(void)registerAction
{
    User *mUser = [[User alloc]init];
    mUser.username = userNameTf.text;
    mUser.pswd = pswdTf.text;
    if ([mUser.username isEqualToString:@""] || [mUser.pswd isEqualToString:@""]) {
        UIAlertView *emptyAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"用户名或密码未填写!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [emptyAlert show];
    } else {
        __block BOOL isExist = 0;
        BmobQuery *bquery = [BmobQuery queryWithClassName:@"User"];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (BmobObject *obj in array) {
                if ([mUser.username isEqualToString:[[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"username"]]]) {
                    isExist = 1;
                    UIAlertView *isExistAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"该用户名已存在，请重新输入!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    userNameTf.text = nil;
                    pswdTf.text = nil;
                    [isExistAlert show];
                    break;
                }
            }
            if (isExist == 0) {
                BmobObject *bobj = [BmobObject objectWithClassName:@"User"];
                [bobj setObject:mUser.username forKey:@"username"];
                [bobj setObject:mUser.pswd forKey:@"password"];
                [bobj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    if (isSuccessful) {
                        changeSeg.selectedSegmentIndex = 0;
                        [self changeAction:changeSeg];
                        userNameTf.text =nil;
                        pswdTf.text = nil;
                    }
                }];
            }
        }];
    }
}

-(void)changeAction:(UISegmentedControl *)seg
{
    [seg setBackgroundColor:!seg.selectedSegmentIndex ? [UIColor colorWithPatternImage:[UIImage imageNamed:@"changeLeft"]] : [UIColor colorWithPatternImage:[UIImage imageNamed:@"changeRight"]]];
    [seg.selectedSegmentIndex ? loginButton : registerButton removeFromSuperview];
    [self.view addSubview:seg.selectedSegmentIndex ? registerButton : loginButton];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [userNameTf resignFirstResponder];
    [pswdTf resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.view addSubview:self.navigationController.navigationBar];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
