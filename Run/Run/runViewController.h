//
//  runViewController.h
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Record.h"

@interface runViewController : UIViewController{
    IBOutlet UIButton *startButton;
    IBOutlet UIButton *stopButton;
    IBOutlet UILabel *timeLabel;
    UILabel *detailLabel;
    NSTimer *mytimer;
}

@property (nonatomic) BOOL isOn;
@property (nonatomic) int myTimerecord,hour,min,scd,mscd,total;
@property (nonatomic) NSString *hourText,*minText,*scdText,*mscdText,*timeLabelText;
@property (nonatomic) Record *runnigRecord;
@end
