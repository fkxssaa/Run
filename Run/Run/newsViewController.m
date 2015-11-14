//
//  newsViewController.m
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import "newsViewController.h"
#import <BmobSDK/BmobQuery.h>
#import "contain.h"
#import "newsDetailViewController.h"

@interface newsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation newsViewController{
    NSMutableArray *container;
}

@synthesize Data;
@synthesize con;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    self.title = @"动态";
    Data = [[NSMutableArray alloc]init];
    con = [[contain alloc]init];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"contain"];
    //查找contain表的数据
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([obj objectForKey:@"name"]&&[obj objectForKey:@"contain"]) {
                contain *container = [[contain alloc]init];
                container.containId = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"objectId"]];
                container.name = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"name"]];
                container.contain = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"contain"]];
                container.pContainId = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"pContainId"]];
                container.createdAt = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"createdAt"]];
                if ([container.pContainId isEqualToString:@"(null)"]) {
                    [Data addObject:container];
                }
            }
        }
        [table reloadData];
    }];
    
    headView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, 320, 100)];
    [headView setBackgroundColor:[UIColor colorWithRed:0.86f green:0.81f blue:0.92f alpha:0.10f]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"5"]];
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setCornerRadius:35];
    imageView.frame = CGRectMake(0, 15, 70, 70);
    
    UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 55, 60, 40)];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userLabel setTextColor:[UIColor whiteColor]];
    userLabel.text = [userDefaults stringForKey:@"username"];
    
    UILabel *lookedLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 55, 100, 40)];
    lookedLabel.text = @"关注度：50";
    [lookedLabel setTextColor:[UIColor whiteColor]];
    [lookedLabel setTextAlignment:NSTextAlignmentRight];
    [headView addSubview:userLabel];
    [headView addSubview:lookedLabel];
    [headView addSubview:imageView];
    [self.view addSubview:headView];
    
    talkeTf = [[UITextField alloc]initWithFrame:CGRectMake(20, 165, 190, 40)];
    [talkeTf setTintColor:[UIColor clearColor]];
    //    [talkeTf setBorderStyle:UITextBorderStyleRoundedRect];
    talkeTf.layer.borderColor = [[UIColor colorWithRed:0.86f green:0.81f blue:0.92f alpha:0.10f]CGColor];
    talkeTf.layer.borderWidth = 1.2f;
    [talkeTf.layer setMasksToBounds:YES];
    [talkeTf.layer setCornerRadius:4.0f];
    [talkeTf setTextColor:[UIColor whiteColor]];
    [self.view addSubview:talkeTf];
    
    submitTalk = [[UIButton alloc]initWithFrame:CGRectMake(220, 170, 80, 40)];
    [submitTalk setTitle:@"发表动态" forState:UIControlStateNormal];
    [submitTalk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitTalk addTarget:self action:@selector(submitTalkAction) forControlEvents:UIControlEventTouchUpInside];
    [submitTalk setTintColor:[UIColor colorWithWhite:0.8 alpha:0.5]];
    [self.view addSubview:submitTalk];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 210, 320, 240)];
    [table setDataSource:self];
    [table setDelegate:self];
    table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table];
    
    
    // Do any additional setup after loading the view.
}

-(void)submitTalkAction
{
    [talkeTf resignFirstResponder];
    if (![talkeTf.text isEqualToString:@""]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BmobObject *bobj = [BmobObject objectWithClassName:@"contain"];
        [bobj setObject:[userDefaults stringForKey:@"username"] forKey:@"name"];
        [bobj setObject:talkeTf.text forKey:@"contain"];
        [bobj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                
            }
        }];
    }
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 100;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
//    
//    [headView setBackgroundColor:[UIColor colorWithRed:0.86f green:0.81f blue:0.92f alpha:0.10f]];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2"]];
//    [imageView.layer setMasksToBounds:YES];
//    [imageView.layer setCornerRadius:35];
//    imageView.frame = CGRectMake(0, 15, 70, 70);
//    [headView addSubview:imageView];
//    return headView;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([Data count] != 0) {
        return [Data count];
        
    }else{
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *Indentifer = @"tableviewtest";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifer];
    }
    
    if ([Data count] != 0) {
        con = (contain*)[Data objectAtIndex:indexPath.row];
        UIImageView *userImageView;
        UILabel *nameLabel,*containLabel,*timeLabel;
        NSArray *mysubviews = cell.contentView.subviews;
        if (mysubviews.count == 0){
            userImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]]];
            userImageView.frame = CGRectMake(5, 5, 20, 20);
            [userImageView.layer setMasksToBounds:YES];
            [userImageView.layer setCornerRadius:10];
            [cell.contentView addSubview:userImageView];
            
            nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 150, 20)];
            [nameLabel setFont:[UIFont systemFontOfSize:12]];
            [nameLabel setText:con.name];
            [nameLabel setTextColor:[UIColor whiteColor]];
            [cell.contentView addSubview:nameLabel];
            
            containLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 280, 40)];
            [containLabel setTextColor:[UIColor whiteColor]];
            [containLabel setText:con.contain];
            [containLabel setFont:[UIFont systemFontOfSize:16]];
            [cell.contentView addSubview:containLabel];
            
            timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 5, 120, 20)];
            [timeLabel setTextColor:[UIColor whiteColor]];
            [timeLabel setText:(NSString *)con.createdAt];
            [timeLabel setFont:[UIFont systemFontOfSize:12]];
            [cell.contentView addSubview:timeLabel];
        }else{
            userImageView = [mysubviews objectAtIndex:0];
            userImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",indexPath.row+1]]];
            nameLabel = [mysubviews objectAtIndex:1];
            [nameLabel setText:con.name];
            containLabel = [mysubviews objectAtIndex:2];
            [containLabel setText:con.contain];
            timeLabel = [mysubviews objectAtIndex:3];
            [timeLabel setText:(NSString *)con.createdAt];
        }
        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    newsDetailViewController *newsdetailView = [[newsDetailViewController alloc]init];
    con = (contain*)[Data objectAtIndex:indexPath.row];
    newsdetailView.detailContain = con;
    [self.navigationController pushViewController:newsdetailView animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    Data = [[NSMutableArray alloc]init];
    con = [[contain alloc]init];
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"contain"];
    //查找contain表的数据
    
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([obj objectForKey:@"name"]&&[obj objectForKey:@"contain"]) {
                contain *container = [[contain alloc]init];
                container.containId = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"objectId"]];
                container.name = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"name"]];
                container.contain = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"contain"]];
                container.pContainId = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"pContainId"]];
                container.createdAt = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"createdAt"]];
                if ([container.pContainId isEqualToString:@"(null)"]) {
                    [Data addObject:container];
                }
            }
        }
        [table reloadData];
    }];
    
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
