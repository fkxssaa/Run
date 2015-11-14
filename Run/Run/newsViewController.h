//
//  newsViewController.h
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "contain.h"

@interface newsViewController : UIViewController{
    IBOutlet UITableView *table;
    UIView *headView;
    UITextField *talkeTf;
    UIButton *submitTalk;
    NSMutableArray *Data;
    contain *con;
}

@property(retain,nonatomic)NSMutableArray *Data;
@property(retain,nonatomic)contain *con;

@end
