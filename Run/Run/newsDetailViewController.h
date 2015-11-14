//
//  newsDetailViewController.h
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "contain.h"

@interface newsDetailViewController : UIViewController{
    UILabel *detailLabel;
    UITableView *detailTabelView;
    UITextField *talkeTf;
    UIButton *submitTalk;
}

@property (nonatomic) contain *detailContain;

@end
