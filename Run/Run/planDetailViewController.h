//
//  planDetailViewController.h
//  Run
//
//  Created by fkx on 15/11/3.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"

@interface planDetailViewController : UIViewController{
    UIButton *doItButton;
}

@property (nonatomic) Record *lookingRecord;

@end
