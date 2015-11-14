//
//  contain.h
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface contain : NSObject{
//    NSString *containId;
//    NSString *name;
//    NSString *contain;
//    NSString *pContainId;
}

@property (nonatomic,  retain) NSString *containId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *contain;
@property (nonatomic, retain) NSString *pContainId;
@property (nonatomic, retain) NSDate *createdAt;

@end
