//
//  Record.h
//  Run
//
//  Created by fkx on 15/10/30.
//  Copyright © 2015年 SImon‘s. All rights reserved.
//

#import <Realm/Realm.h>

@interface Record : RLMObject

@property (nonatomic) NSString *username;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *activity;
@property (nonatomic) NSDate *startTime;
@property (nonatomic) NSDate *stopTime;
@property (nonatomic) int planHour;
@property (nonatomic) int planMin;
@property (nonatomic) int hour;
@property (nonatomic) int min;
@property (nonatomic) NSString *address;
@property (nonatomic) BOOL isFinished;

@end
