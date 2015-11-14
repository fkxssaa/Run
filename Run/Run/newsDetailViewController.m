//
//  newsDetailViewController.m
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import "newsDetailViewController.h"
#import <BmobSDK/BmobQuery.h>

@interface newsDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *detailData;
}

@end

@implementation newsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
    
    [self.tabBarController.tabBar removeFromSuperview];
    
    detailData = [[NSMutableArray alloc]init];
    
    UIImageView *userImageView;
    userImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2"]];
    userImageView.frame = CGRectMake(5, 80, 60, 60);
    [userImageView.layer setMasksToBounds:YES];
    [userImageView.layer setCornerRadius:30];
    [self.view addSubview:userImageView];
    
    UILabel *nameLabel,*containLabel,*timeLabel;
    
    nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 80, 150, 40)];
    [nameLabel setText:_detailContain.name];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [self.view addSubview:nameLabel];
    
    containLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 140, 280, 80)];
    containLabel.numberOfLines = 2;
    [containLabel setTextColor:[UIColor whiteColor]];
    [containLabel setText:_detailContain.contain];
    [containLabel setFont:[UIFont systemFontOfSize:16]];
    [self.view addSubview:containLabel];
    
    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(65, 120, 120, 20)];
    [timeLabel setTextColor:[UIColor whiteColor]];
    [timeLabel setText:(NSString *)_detailContain.createdAt];
    [timeLabel setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:timeLabel];
    
    talkeTf = [[UITextField alloc]initWithFrame:CGRectMake(20, 220, 220, 40)];
    [talkeTf setTintColor:[UIColor clearColor]];
    talkeTf.layer.borderColor = [[UIColor colorWithRed:0.86f green:0.81f blue:0.92f alpha:0.10f]CGColor];
    talkeTf.layer.borderWidth = 1.2f;
    [talkeTf.layer setMasksToBounds:YES];
    [talkeTf.layer setCornerRadius:4.0f];
    [talkeTf setTextColor:[UIColor whiteColor]];
    [self.view addSubview:talkeTf];
    
    submitTalk = [[UIButton alloc]initWithFrame:CGRectMake(235, 223, 80, 40)];
    [submitTalk setTitle:@"发表评论" forState:UIControlStateNormal];
    [submitTalk setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitTalk addTarget:self action:@selector(submitTalkAction) forControlEvents:UIControlEventTouchUpInside];
    [submitTalk setTintColor:[UIColor colorWithWhite:0.8 alpha:0.5]];
    [self.view addSubview:submitTalk];
    
    detailTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 270, 320, 260)];
    detailTabelView.dataSource = self;
    detailTabelView.delegate = self;
    detailTabelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    detailTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"contain"];
    //查找contain表的数据
    
    [bquery whereKey:@"pContainId" equalTo:_detailContain.containId];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            if ([obj objectForKey:@"name"]&&[obj objectForKey:@"contain"]) {
                contain *dcontainer = [[contain alloc]init];
                dcontainer.containId = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"objectId"]];
                dcontainer.name = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"name"]];
                dcontainer.contain = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"contain"]];
                dcontainer.pContainId = [[NSString alloc]initWithFormat:@"%@",[obj objectForKey:@"pContainId"]];
                [detailData addObject:dcontainer];
            }
        }
        if (detailData.count != 0) {
            [self.view addSubview:detailTabelView];
        }
        [detailTabelView reloadData];
    }];
    
    // Do any additional setup after loading the view.
}

-(void)submitTalkAction
{
    if (![talkeTf.text isEqualToString:@""]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        BmobObject *bobj = [BmobObject objectWithClassName:@"contain"];
        [bobj setObject:[userDefaults stringForKey:@"username"] forKey:@"name"];
        [bobj setObject:talkeTf.text forKey:@"contain"];
        [bobj setObject:_detailContain.containId forKey:@"pContainId"];
        [bobj saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                [detailTabelView reloadData];
            }
        }];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.tabBarController.view addSubview:self.tabBarController.tabBar];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [talkeTf resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (detailData.count != 0) {
        return detailData.count;
    }else{
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Indentifer = @"tableviewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indentifer];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifer];
    }
    
    if (detailData.count != 0) {
        contain *con = [detailData objectAtIndex:indexPath.row];
        UIImageView *userImageView;
        if (indexPath.row%2) {
            userImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1"]];
        }else {
            userImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2"]];
        }
        userImageView.frame = CGRectMake(5, 5, 20, 20);
        [userImageView.layer setMasksToBounds:YES];
        [userImageView.layer setCornerRadius:10];
        [cell.contentView addSubview:userImageView];
        
        UILabel *nameLabel,*containLabel,*timeLabel;
        
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
    }
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    return cell;
    
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
