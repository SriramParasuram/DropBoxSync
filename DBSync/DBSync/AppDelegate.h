//
//  AppDelegate.h
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFirstViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, strong) MyFirstViewController *myFirstVC;


@end

