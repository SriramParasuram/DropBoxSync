//
//  MyFirstViewController.h
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFirstView.h"
#import "MySecondViewController.h"

@interface MyFirstViewController : UIViewController

@property (nonatomic, strong) MyFirstView *myFirstView;
@property (nonatomic, strong) MySecondViewController *mySecondVC;

@end
