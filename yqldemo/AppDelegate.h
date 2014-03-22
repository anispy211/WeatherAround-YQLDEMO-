//
//  AppDelegate.h
//  YqlDemo
//
//  Created by Aniruddha  on 03/03/14.
//  Copyright (c) 2014 aniruddha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationVC;

@property (strong, nonatomic) MBProgressHUD * hudActivityIndicator;


- (void) showHUDActivityIndicator:(NSString *)message;
- (void) hideHUDActivityIndicator;


@end
