//
//  main.m
//  Run
//
//  Created by libmooc on 15/10/6.
//  Copyright (c) 2015年 SImon‘s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSString *appKey = @"6e8d21bee149117e5dc467427ee5c4fe";
        [Bmob registerWithAppKey:appKey];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
