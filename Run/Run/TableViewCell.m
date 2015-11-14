//
//  TableViewCell.m
//  UUChartView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "TableViewCell.h"
#import "UUChart.h"
#import "Record.h"

@interface TableViewCell ()<UUChartDataSource>
{
    NSIndexPath *path;
    UUChart *chartView;
}
@end

@implementation TableViewCell

- (void)configUI:(NSIndexPath *)indexPath
{
    if (chartView) {
        [chartView removeFromSuperview];
        chartView = nil;
    }
    
    path = indexPath;
    
    chartView = [[UUChart alloc]initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                              withSource:self
                                               withStyle:indexPath.row==1?UUChartBarStyle:UUChartLineStyle];
    [chartView showInView:self.contentView];
}

- (NSArray *)getXTitles:(int)num
{
    NSMutableArray *xTitles = [NSMutableArray array];
    for (int i=1; i<=num; i++) {
        NSString * str = [NSString stringWithFormat:@"R-%d",i];
        [xTitles addObject:str];
    }
    return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{

    
        switch (path.row) {
            case 0:
                return [self getXTitles:7];
            case 1:
                return [self getXTitles:4];
                break;
        }
    
    return [self getXTitles:20];
}
//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{



//    NSArray *ary1 = @[@"35",@"55",@"25",@"66",@"55",@"25",@"66",@"55",@"25",@"66",@"55",@"25",@"66",@"55",@"25",@"66",@"55",@"25",@"66",@"55",@"25",@"66",@"55",@"25",@"66",@"55",@"25",@"66",@"55",@"25"];
//
//    NSArray *ary2 = @[@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75",@"75"];

    NSArray *ary1 = @[@"30",@"30",@"25",@"20"];
    NSArray *ary2 = @[@"14",@"10",@"12",@"8"];
    
    NSDate *now = [NSDate date];
    NSTimeInterval interval = 24*3600;//一天
    NSDate *aWeekAgo = [now initWithTimeIntervalSinceNow:-interval*7];
    NSDate *aMonthAgo = [now initWithTimeIntervalSinceNow:-interval*30];
    NSString *test = @"大雾";
    NSString *weekConditions = [NSString stringWithFormat:@"startTime <= %@ AND startTime >= %@",now,aWeekAgo];
//    NSString *testConditions = [NSString stringWithFormat:@"activity = '大雾'"];
    NSString *monthConditions = [NSString stringWithFormat:@"startTime <= '%@' AND startTime >= '%@'",now,aMonthAgo];
//    NSString *testConditions = [NSString stringWithFormat:@"activity = '%@'",test];
    NSString *testConditions = [NSString stringWithFormat:@"startTime BEGINSWITH 2015"];
//    RLMResults *records = [Record objectsWhere:testConditions];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"startTime <= %@ AND startTime >= %@",now,aWeekAgo];
    RLMResults *records = [Record objectsWithPredicate:pred];
    
    CGFloat count[7][2] = {0};
    for (Record *tRecord in records) {
        if (tRecord.startTime == now) {
            if ([tRecord.type  isEqual: @"学习"]) {
                count[6][1] = count[6][1] + tRecord.hour + (CGFloat)tRecord.min/60;
            }else if ([tRecord.type  isEqual: @"运动"]){
                count[6][0] = count[6][0] + tRecord.hour + (CGFloat)tRecord.min/60;
            }
            break;
        }
        if (tRecord.startTime == [now initWithTimeIntervalSinceNow:-interval*1]) {
            if ([tRecord.type  isEqual: @"学习"]) {
                count[5][1] = count[5][1] + tRecord.hour + (CGFloat)tRecord.min/60;
            }else if ([tRecord.type  isEqual: @"运动"]){
                count[5][0] = count[5][0] + tRecord.hour + (CGFloat)tRecord.min/60;
            }
            break;
        }
        if (tRecord.startTime == [now initWithTimeIntervalSinceNow:-interval*2]) {
            if ([tRecord.type  isEqual: @"学习"]) {
                count[4][1] = count[4][1] + tRecord.hour + (CGFloat)tRecord.min/60;
            }else if ([tRecord.type  isEqual: @"运动"]){
                count[4][0] = count[4][0] + tRecord.hour + (CGFloat)tRecord.min/60;
            }
            break;
        }
        if (tRecord.startTime == [now initWithTimeIntervalSinceNow:-interval*3]) {
            if ([tRecord.type  isEqual: @"学习"]) {
                count[3][1] = count[3][1] + tRecord.hour + (CGFloat)tRecord.min/60;
            }else if ([tRecord.type  isEqual: @"运动"]){
                count[3][0] = count[3][0] + tRecord.hour + (CGFloat)tRecord.min/60;
            }
            break;
        }
        if (tRecord.startTime == [now initWithTimeIntervalSinceNow:-interval*4]) {
            if ([tRecord.type  isEqual: @"学习"]) {
                count[2][1] = count[2][1] + tRecord.hour + (CGFloat)tRecord.min/60;
            }else if ([tRecord.type  isEqual: @"运动"]){
                count[2][0] = count[2][0] + tRecord.hour + (CGFloat)tRecord.min/60;
            }
            break;
        }
        if (tRecord.startTime == [now initWithTimeIntervalSinceNow:-interval*5]) {
            if ([tRecord.type  isEqual: @"学习"]) {
                count[1][1] = count[1][1] + tRecord.hour + (CGFloat)tRecord.min/60;
            }else if ([tRecord.type  isEqual: @"运动"]){
                count[1][0] = count[1][0] + tRecord.hour + (CGFloat)tRecord.min/60;
            }
            break;
        }
        if (tRecord.startTime == [now initWithTimeIntervalSinceNow:-interval*6]) {
            if ([tRecord.type  isEqual: @"学习"]) {
                count[0][1] = count[0][1] + tRecord.hour + (CGFloat)tRecord.min/60;
            }else if ([tRecord.type  isEqual: @"运动"]){
                count[0][0] = count[0][0] + tRecord.hour + (CGFloat)tRecord.min/60;
            }
            break;
        }
    }
    NSMutableArray *ary3_1 = [[NSMutableArray alloc]init];
    NSMutableArray *ary4_1 = [[NSMutableArray alloc]init];
    for (int i = 0; i < 6; i++) {
        
        NSNumber *number = [[NSNumber alloc] initWithFloat:count[i][1]];
        
        [ary3_1 addObject:number];
        
        number = [NSNumber numberWithFloat:count[i][0]];
        
        [ary4_1 addObject:number];
    }
    
    NSArray *ary3 = @[@"2",@"6",@"2",@"7",@"3",@"7",@"8"];
    NSArray *ary4 = @[@"3",@"2",@"5",@"3",@"1",@"4",@"6"];
    
    
        switch (path.row) {
            case 0:
                return @[ary3,ary4];
            case 1:
                return @[ary1,ary2];
            default:
                return @[ary1];
        }
    
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
    return @[UUGreen,UURed,UUBrown];
}
//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
    
    if (path.section==0 && (path.row==0)) {
        return CGRangeMake(8, 0);
    }
    if (path.section==0 && (path.row==1)) {
        return CGRangeMake(50, 0);
    }
    
    return CGRangeZero;
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
    if (path.row==1) {
        return CGRangeMake(25, 75);
    }
    return CGRangeZero;
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
    return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
    return path.row==2;
}
@end
