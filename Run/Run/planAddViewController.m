//
//  planAddViewController.m
//  Run
//
//  Created by fkx on 15/10/30.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import "planAddViewController.h"
#import "Record.h"

@interface planAddViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSMutableArray *source1;
    NSMutableArray *source2;
}

@end

@implementation planAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    [self.tabBarController.tabBar removeFromSuperview];
    
    source1 = [[NSMutableArray alloc]init];
    source2 = [[NSMutableArray alloc]init];
    for (int i = 0; i <= 23 ; i++) {
        [source1 addObject:[NSString stringWithFormat:@"%d",i]];
//        [source1 addObject:[NSNumber numberWithInt:i]];
    }
    for (int i = 0; i<=59; i++) {
        [source2 addObject:[NSString stringWithFormat:@"%d",i]];
//        [source2 addObject:[NSNumber numberWithInt:i]];
    }
    
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    [scrollView setContentSize:CGSizeMake(320, 800)];
    scrollView.delegate = (id)self;
    
    NSArray * arrWeek=[NSArray arrayWithObjects:@"?",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    int year=[comps year];
    int month = [comps month];
    int day = [comps day];
//    m_labDate.text=[NSString stringWithFormat:@"%d年%d月",year,month];
//    m_labToday.text=[NSString stringWithFormat:@"%d",day];
//    m_labWeek.text=[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week]];
    
    weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 20, 48, 13)];
    [weekLabel setText:[NSString stringWithFormat:@"%@",[arrWeek objectAtIndex:week]]];
    [weekLabel setFont:[UIFont systemFontOfSize:13]];
    [weekLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:weekLabel];
    
    dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 41, 99, 52)];
    [dayLabel setText:[NSString stringWithFormat:@"%d",day]];
    [dayLabel setTextAlignment:NSTextAlignmentCenter];
    [dayLabel setFont:[UIFont systemFontOfSize:54]];
    [dayLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:dayLabel];
    
    monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 95, 48, 17)];
    [monthLabel setText:[NSString stringWithFormat:@"%d月",month]];
    [monthLabel setTextAlignment:NSTextAlignmentCenter];
    [monthLabel setFont:[UIFont systemFontOfSize:13]];
    [monthLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:monthLabel];
    
    typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 139, 34, 21)];
    [typeLabel setText:@"类型"];
    [typeLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:typeLabel];
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(28, 189, 34, 21)];
    [nameLabel setText:@"名称"];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:nameLabel];
    
    planTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 245, 68, 21)];
    [planTimeLabel setTextAlignment:NSTextAlignmentRight];
    UIImageView *planTimeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    planTimeImageView.image = [UIImage imageNamed:@"plantime"];
    [planTimeLabel addSubview:planTimeImageView];
    [planTimeLabel setText:@"时长"];
    [planTimeLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:planTimeLabel];
    
    planStartTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 345, 34, 21)];
    [planStartTimeLabel setText:@"开始"];
    [planStartTimeLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:planStartTimeLabel];
    
    planStopTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 345, 34, 21)];
    [planStopTimeLabel setText:@"结束"];
    [planStopTimeLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:planStopTimeLabel];
    
    addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 450, 60, 21)];
    [addressLabel setTextAlignment:NSTextAlignmentRight];
    UIImageView *addressImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    addressImageView.image = [UIImage imageNamed:@"address"];
    [addressLabel addSubview:addressImageView];
    [addressLabel setText:@"  地点"];
    [addressLabel setTextColor:[UIColor whiteColor]];
    [scrollView addSubview:addressLabel];
    
    typeSeg = [[UISegmentedControl alloc]initWithItems:@[@"学习",@"运动"]];
    [typeSeg setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    typeSeg.selectedSegmentIndex = 0;
    typeSeg.frame = CGRectMake(121, 139, 100, 30);
    [scrollView addSubview:typeSeg];
    
    nameTf = [[UITextField alloc]initWithFrame:CGRectMake(124, 185, 145, 30)];
    [nameTf setBorderStyle:UITextBorderStyleRoundedRect];
    [scrollView addSubview:nameTf];
    
    planTimeHourTf = [[UITextField alloc]initWithFrame:CGRectMake(124, 241, 44, 30)];
    [planTimeHourTf setBorderStyle:UITextBorderStyleRoundedRect];
    [planTimeHourTf setKeyboardType:UIKeyboardTypeNumberPad];
    [scrollView addSubview:planTimeHourTf];
    
    planTimeHourLabel = [[UILabel alloc]initWithFrame:CGRectMake(170, 241, 30, 30)];
    planTimeHourLabel.text = @"时";
    [planTimeHourLabel setTextColor:[UIColor whiteColor]];
    [planTimeHourLabel setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:planTimeHourLabel];
    
    planTimeMinTf = [[UITextField alloc]initWithFrame:CGRectMake(201, 242, 44, 30)];
    [planTimeMinTf setBorderStyle:UITextBorderStyleRoundedRect];
    [planTimeMinTf setKeyboardType:UIKeyboardTypeNumberPad];
    [scrollView addSubview:planTimeMinTf];
    
    planTimeMinLabel = [[UILabel alloc]initWithFrame:CGRectMake(247, 242, 30, 30)];
    planTimeMinLabel.text = @"分";
    [planTimeMinLabel setTextColor:[UIColor whiteColor]];
    [planTimeMinLabel setTextAlignment:NSTextAlignmentCenter];
    [scrollView addSubview:planTimeMinLabel];
    
    planStartTimePv = [[UIPickerView alloc]initWithFrame:CGRectMake(62, 273, 100, 167)];
    planStartTimePv.delegate = (id)self;
    planStartTimePv.dataSource = (id)self;
    [scrollView addSubview:planStartTimePv];
    
    planStopTimePv = [[UIPickerView alloc]initWithFrame:CGRectMake(201, 273, 100, 167)];
    planStopTimePv.delegate = (id)self;
    planStopTimePv.dataSource = (id)self;
    [scrollView addSubview:planStopTimePv];
    
    addressTf = [[UITextField alloc]initWithFrame:CGRectMake(105, 446, 175, 30)];
    [addressTf setBorderStyle:UITextBorderStyleRoundedRect];
    [scrollView addSubview:addressTf];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide:)];
    [scrollView addGestureRecognizer:tap];
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveAction)];
    [self.navigationItem setRightBarButtonItem:saveButton];
    
    [self.view addSubview:scrollView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.view addSubview:self.tabBarController.tabBar];
}

-(void)hide:(UITapGestureRecognizer *)tap
{
    [nameTf resignFirstResponder];
    [planTimeHourTf resignFirstResponder];
    [planTimeMinTf resignFirstResponder];
    [addressTf resignFirstResponder];
}

// 是否支持滑动至顶部
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}


-(void)saveAction
{
    Record *record = [[Record alloc]init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    record.username = [userDefaults stringForKey:@"username"];
    record.activity = nameTf.text;
    record.address = addressTf.text;
    record.type = typeSeg.selectedSegmentIndex ? @"运动" : @"学习";
    record.planHour = [planTimeHourTf.text intValue];
    record.planMin = [planTimeMinTf.text intValue];
    record.isFinished = NO;
    
    //insert
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:record];
    [realm commitWriteTransaction];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [nameTf resignFirstResponder];
    [planTimeHourTf resignFirstResponder];
    [planTimeMinTf resignFirstResponder];
    [addressTf resignFirstResponder];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return source1.count;
    }else {
        return [source2 count];
    }
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    if (component == 0) {
        label.text = (NSString *)[source1 objectAtIndex:row];
    }else{
        label.text = (NSString *)[source2 objectAtIndex:row];
    }
    label.textColor = [UIColor whiteColor];
    [titleview addSubview:label];
    return titleview;
}

//-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
//    if (component == 0) {
//        return [numberFormatter stringFromNumber:[source1 objectAtIndex:row]];
//    }else{
//        return [numberFormatter stringFromNumber:[source2 objectAtIndex:row]];
//    }
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
