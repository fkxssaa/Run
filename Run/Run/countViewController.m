//
//  countViewController.m
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import "countViewController.h"
#import "TableViewCell.h"

@interface countViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) NSIndexPath *type;
@property (nonatomic) NSArray *tabledata;

@end

@implementation countViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"backgournd_withoutlogo"]]];
    
    annotationLabel = [[UILabel alloc]init];
    [annotationLabel setNumberOfLines:2];
    [annotationLabel setFrame:CGRectMake(220, 360, 100, 40)];
    NSString *annotation = [[NSString alloc]initWithFormat:@"红色：学习"];
    [annotationLabel setTextColor:[UIColor grayColor]];
    [annotationLabel setText:annotation];
    [annotationLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:annotationLabel];
    
    annotationLabel1 = [[UILabel alloc]init];
    [annotationLabel1 setNumberOfLines:2];
    [annotationLabel1 setFrame:CGRectMake(220, 380, 100, 40)];
    NSString *annotation1 = [[NSString alloc]initWithFormat:@"绿色：运动"];
    [annotationLabel1 setTextColor:[UIColor grayColor]];
    [annotationLabel1 setText:annotation1];
    [annotationLabel1 setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:annotationLabel1];
    
    NSArray *segdata = [[NSArray alloc]initWithObjects:@"月",@"周", nil];
    _tabledata = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    seg = [[UISegmentedControl alloc]initWithItems:segdata];
    seg.frame = CGRectMake(30, 60, 260, 50);
    seg.selectedSegmentIndex = 1;
    _type = [NSIndexPath indexPathForRow:0 inSection:0];
    [seg addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:seg];
    
    table = [[UITableView alloc]init];
    if (seg.selectedSegmentIndex == 2) {
        table.frame = CGRectMake(0, 160, 320, 500);
    } else {
        table.frame = CGRectMake(0, 160, 320, 200);
    }
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return seg.selectedSegmentIndex == 2 ? [_tabledata count] : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (seg.selectedSegmentIndex != 2) {
        static NSString *cellIdentifier = @"TableViewCell";
        
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:nil options:nil]firstObject];
        }
        [cell configUI:_type];
        return cell;
    } else {
        static NSString *Indentifer = @"tableviewtest";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indentifer];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indentifer];
        }
        
        cell.textLabel.text = [_tabledata objectAtIndex:indexPath.row];
        return cell;
    }
    //    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return seg.selectedSegmentIndex == 2 ? 40 : 170;
}


-(void)segAction:(UISegmentedControl*)seg
{
    if (seg.selectedSegmentIndex == 1) {
        _type = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.view addSubview:annotationLabel];
    }else if (seg.selectedSegmentIndex == 2){
        [annotationLabel removeFromSuperview];
    }else {
        _type = [NSIndexPath indexPathForRow:1 inSection:0];
        [self.view addSubview:annotationLabel];
    }
    [table reloadData];
    //seg.selectedSegmentIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
