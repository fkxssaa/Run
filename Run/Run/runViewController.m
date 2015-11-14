//
//  runViewController.m
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import "runViewController.h"
#import "Record.h"
#import "CircularProgressView.h"

@interface runViewController ()<UIAlertViewDelegate>{
    CircularProgressView *cpv;
}

@end

@implementation runViewController

_hour = 0;
_min = 0;
_scd = 0;
_mscd = 0;
_myTimerecord = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgournd_withoutlogo"]]];
    
    cpv = [[CircularProgressView alloc]initWithFrame:CGRectMake(39, 90, 240, 240)];
    cpv.animate=@YES;
    cpv.progress=0.00;
    // cpv.progressColor=[UIColor redColor];
    //cpv.progressBackgroundColor=[UIColor blackColor];
    cpv.showBackground=@YES;
    cpv.type=FlatStyle;
    
    
    detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 320, 60)];
    if (self.runnigRecord) {
        detailLabel.numberOfLines = 2;
        [detailLabel setTextColor:[UIColor whiteColor]];
        [detailLabel setTextAlignment:NSTextAlignmentCenter];
        [detailLabel setFont:[UIFont systemFontOfSize:18.0]];
        detailLabel.text = [[NSString alloc]initWithFormat:@"%@ ",self.runnigRecord.activity];
        _hour = self.runnigRecord.hour;
        _min = self.runnigRecord.min;
        _myTimerecord = _min*6000 + _hour*360000;
        _total = (self.runnigRecord.planHour * 360000 + self.runnigRecord.planMin * 6000);
        [self.view addSubview:cpv];
        [self updateUI];
    } else {
        [detailLabel setTextColor:[UIColor whiteColor]];
        [detailLabel setTextAlignment:NSTextAlignmentCenter];
        [detailLabel setFont:[UIFont systemFontOfSize:18.0]];
        detailLabel.text = @"计时器";
    }
    [detailLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:detailLabel];
    
    startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake(60, 340, 80, 80);
    [startButton.layer setMasksToBounds:YES];
    [startButton.layer setCornerRadius:40];
    [startButton setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
//    [startButton setTitle:@"开始" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    stopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stopButton.frame = CGRectMake(180, 340, 80, 80);
    [stopButton.layer setMasksToBounds:YES];
    [stopButton.layer setCornerRadius:40];
//    [stopButton setBackgroundColor:[UIColor blueColor]];
//    [stopButton setTitle:@"停止" forState:UIControlStateNormal];
    [stopButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [stopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [stopButton addTarget:self action:@selector(stopBtAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopButton];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(64, 170, 190, 80)];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeLabel setText:@"00  :  00  :  00  :  00"];
    [timeLabel setTextColor:[UIColor whiteColor]];
    timeLabel.font = [UIFont boldSystemFontOfSize:22.0];
    [timeLabel setTextColor:[UIColor blackColor]];
    [self.view addSubview:timeLabel];
    
    mytimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    cpv.progress = 0.00;
    [self realStop];
    self.runnigRecord = nil;
    [cpv removeFromSuperview];
    [self updateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (self.runnigRecord) {
        detailLabel.numberOfLines = 2;
        [detailLabel setTextAlignment:NSTextAlignmentCenter];
        detailLabel.text = [[NSString alloc]initWithFormat:@"%@ ",self.runnigRecord.activity];
        _hour = self.runnigRecord.hour;
        _min = self.runnigRecord.min;
        _myTimerecord = _min*6000 + _hour*360000;
        _total = (self.runnigRecord.planHour * 360000 + self.runnigRecord.planMin * 6000);
        [self.view addSubview:cpv];
    } else {
        detailLabel.text = @"计时器";
    }
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)timerFired
{
    if ((self.runnigRecord)&&(self.runnigRecord.planHour == _hour) && (self.runnigRecord.planMin == _min)) {
        //修改数据库isfinishied
        RLMRealm *runrealm = [RLMRealm defaultRealm];
        [runrealm beginWriteTransaction];
        self.runnigRecord.isFinished = YES;
        self.runnigRecord.hour = self.runnigRecord.planHour;
        self.runnigRecord.min = self.runnigRecord.planMin;
        [runrealm commitWriteTransaction];
        cpv.progress = 0.00;
        [self realStop];
        UIAlertView *finishAlert = [[UIAlertView alloc]initWithTitle:@"结束提示" message:@"此次活动已完成" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [finishAlert show];
    }
    if (_isOn) {
        _myTimerecord++;
        _hour = _myTimerecord / 360000;
        _min = (_myTimerecord%360000)/6000;
        _scd = (_myTimerecord%6000)/100;
        _mscd = _myTimerecord%100;
    }
    [self updateUI];
}

-(void)startBtAction
{
    if (_isOn) {
        _isOn = NO;
    } else {
        _isOn = YES;
        if ([[NSString stringWithFormat:@"%@",self.runnigRecord.startTime] isEqualToString:@"(null)"]) {
            RLMRealm *runrealm = [RLMRealm defaultRealm];
            [runrealm beginWriteTransaction];
            NSDate *now = [NSDate date];
            self.runnigRecord.startTime = now;
            [runrealm commitWriteTransaction];
        }
    }
}

-(void)stopBtAction
{
    _isOn = NO;//暂停
    UIAlertView *stopAlert = [[UIAlertView alloc]initWithTitle:@"中断提示" message:@"你确定要放弃吗？？？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"继续工作！！！", nil];
    [stopAlert show];
}

-(void)realStop
{
    _hour = 0;
    _min = 0;
    _scd = 0;
    _mscd = 0;
    _myTimerecord = 0;
    _isOn = NO;
}

-(void)updateUI
{
    if (_hour < 10) {
        _hourText = [[NSString alloc]initWithFormat:@"0%d",_hour];
    }else {
        _hourText = [[NSString alloc]initWithFormat:@"%d",_hour];
    }
    
    if (_min < 10) {
        _minText = [[NSString alloc]initWithFormat:@"0%d",_min];
    }else {
        _minText = [[NSString alloc]initWithFormat:@"%d",_min];
    }
    
    if (_scd < 10) {
        _scdText = [[NSString alloc]initWithFormat:@"0%d",_scd];
    }else {
        _scdText = [[NSString alloc]initWithFormat:@"%d",_scd];
    }
    
    if (_mscd < 10) {
        _mscdText = [[NSString alloc]initWithFormat:@"0%d",_mscd];
    } else {
        _mscdText = [[NSString alloc]initWithFormat:@"%d",_mscd];
    }
    
    _timeLabelText = [[NSString alloc]initWithFormat:@"%@  :  %@  :  %@  :  %@",_hourText,_minText,_scdText,_mscdText];
    [timeLabel setTextColor:[UIColor whiteColor]];
    [timeLabel setText:_timeLabelText];
    
    if (_isOn) {
        [startButton setBackgroundImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        if (self.runnigRecord) {
            int per =  (_myTimerecord - 1) * 100 / _total;
            int nowper = _myTimerecord *100 / _total;
            if (per != nowper) {
                cpv.progress = (CGFloat)nowper/100;
            }
        }
    }else {
        [startButton setBackgroundImage:[UIImage imageNamed:@"start"] forState:UIControlStateNormal];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (@"中断提示" == alertView.title) {
            RLMRealm *runrealm = [RLMRealm defaultRealm];
            [runrealm beginWriteTransaction];
            NSDate *now = [NSDate date];
            self.runnigRecord.stopTime = now;
            self.runnigRecord.hour = _hour;
            self.runnigRecord.min = _min;
            [runrealm commitWriteTransaction];
            cpv.progress = 0.00;
            [self realStop];
        }
        self.tabBarController.selectedIndex = 0;
    } else {
        [self startBtAction];//继续
    }
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
