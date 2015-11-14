//
//  planDetailViewController.m
//  Run
//
//  Created by fkx on 15/11/3.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import "planDetailViewController.h"
#import "runViewController.h"

@interface planDetailViewController ()

@end

@implementation planDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 320, 340)];
    testLabel.numberOfLines = 9;
    [testLabel setText:[NSString stringWithFormat:@"活动名称： %@ \n\n计划时间： %d 小时 %d 分钟 \n\n实际执行时间： %d 小时 %d 分钟 \n\n地址： %@ \n\n状态： %@",self.lookingRecord.activity,self.lookingRecord.planHour,self.lookingRecord.planMin,self.lookingRecord.hour,self.lookingRecord.min,self.lookingRecord.address,self.lookingRecord.isFinished ? @"完成" : @"未完成"]];
    [testLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:testLabel];
    
    doItButton = [[UIButton alloc]initWithFrame:CGRectMake(120, 350, 60, 60)];
    [doItButton.layer setMasksToBounds:YES];
    [doItButton.layer setCornerRadius:30];
    [doItButton setBackgroundImage:[UIImage imageNamed:@"doIt"] forState:UIControlStateNormal];
    [doItButton addTarget:self action:@selector(doItAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doItButton];
    
    if (self.lookingRecord.isFinished) {
        doItButton.enabled = NO;
    }
    
    // Do any additional setup after loading the view.
}

-(void)doItAction
{
    runViewController *runView = [self.tabBarController.viewControllers objectAtIndex:1];
    runView.runnigRecord = self.lookingRecord;
    self.tabBarController.selectedIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
