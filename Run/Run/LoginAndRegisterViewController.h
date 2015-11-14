//
//  LoginAndRegisterViewController.h
//  Run
//
//  Created by fkx on 15/10/29.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginAndRegisterViewController : UIViewController{
    UILabel *logoLabel;
    UIImageView *userImageView;
    UIImageView *pswdImageView;
    UITextField *userNameTf;
    UITextField *pswdTf;
    UIButton *loginButton;
    UIButton *registerButton;
    UIButton *changeButton;
    UISegmentedControl *changeSeg;
    UITableView *table;
    UIView *headView;
    UIImageView *headImageView;
}

@property (nonatomic) NSArray *changeSegData;

@end
