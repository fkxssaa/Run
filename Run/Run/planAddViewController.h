//
//  planAddViewController.h
//  Run
//
//  Created by fkx on 15/10/30.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface planAddViewController : UIViewController{
    UIScrollView *scrollView;
    
    UILabel *weekLabel;
    UILabel *dayLabel;
    UILabel *monthLabel;
    UILabel *typeLabel;
    UILabel *nameLabel;
    UILabel *planTimeLabel;
    UILabel *planTimeHourLabel;
    UILabel *planTimeMinLabel;
    UILabel *planStartTimeLabel;
    UILabel *planStopTimeLabel;
    UILabel *addressLabel;
    
    UISegmentedControl *typeSeg;
    UITextField *nameTf;
    UITextField *planTimeHourTf;
    UITextField *planTimeMinTf;
    UIPickerView *planStartTimePv;
    UIPickerView *planStopTimePv;
    UITextField *addressTf;
    
    UIButton *submit;
}

@end
