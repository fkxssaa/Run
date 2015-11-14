//
//  planViewController.m
//  Run
//
//  Created by fkx on 15/10/29.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import "planViewController.h"
#import "planAddViewController.h"
#import "Record.h"
#import "runViewController.h"
#import "runViewController.h"
#import "planDetailViewController.h"

@interface planViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate>{
    RLMResults *records;
    Record *tempRecord;
}
@end

@implementation planViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    self.title = @"今日计划";
    // Do any additional setup after loading the view.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *conditions = [NSString stringWithFormat:@"username = '%@'",[userDefaults stringForKey:@"username"]];
    records = [Record objectsWhere:conditions];
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 340, 450)];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table];
    
    UIBarButtonItem *jumpToAdd = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(jumpToAddAction)];
    [self.navigationItem setRightBarButtonItem:jumpToAdd];
}

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    navigationController.navigationBar.alpha = 0.2;
    navigationController.navigationBar.translucent = YES;
}

-(void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers
{
    tabBarController.tabBar.alpha = 0.2;
    tabBarController.tabBar.translucent = YES;
}

-(void)jumpToAddAction
{
    planAddViewController *planAddView = [[planAddViewController alloc]init];
    [self.navigationController pushViewController:planAddView animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([records count] != 0) {
        return records.count;
    } else {
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Indetifier = @"tableview";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indetifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
    }
    
    if (records.count != 0) {
        tempRecord = (Record *)[records objectAtIndex:indexPath.row];
        UILabel *nameLabel,*timeLabel;
        nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 15, 120, 40)];
        nameLabel.text = [NSString stringWithFormat:@"%@",tempRecord.activity];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [cell.contentView addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 15, 100, 65)];
        timeLabel.numberOfLines = 2;
        NSDate *senddate=[NSDate date];
        [timeLabel setFont:[UIFont systemFontOfSize:10]];
        [timeLabel setTextAlignment:NSTextAlignmentCenter];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY - MM - dd"];
        NSString *locationString=[dateformatter stringFromDate:senddate];
        timeLabel.text = [NSString stringWithFormat:@"%dmin\n%@",tempRecord.planHour*60 + tempRecord.planMin,locationString];
        [timeLabel setTextColor:[UIColor whiteColor]];
        [cell.contentView addSubview:timeLabel];
        
        UIImageView *isFinishiImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 40, 40)];
        [isFinishiImageView.layer setMasksToBounds:YES];
        [isFinishiImageView.layer setCornerRadius:20];
        if (tempRecord.isFinished) {
            isFinishiImageView.image = [UIImage imageNamed:@"isFinished"];
            
        }else {
            isFinishiImageView.image = [UIImage imageNamed:@"isNotFinished"];
        }
        [cell.contentView addSubview:isFinishiImageView];
        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    tempRecord = (Record *)[records objectAtIndex:indexPath.row];
    planDetailViewController *planDetailView = [[planDetailViewController alloc]init];
    planDetailView.lookingRecord = tempRecord;
    [self.navigationController pushViewController:planDetailView animated:YES];
//    runViewController *runView = [self.tabBarController.viewControllers objectAtIndex:1];
//    runView.runnigRecord = tempRecord;
//    self.tabBarController.selectedIndex = 1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [table reloadData];
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
