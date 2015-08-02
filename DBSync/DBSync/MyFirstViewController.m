//
//  MyFirstViewController.m
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import "MyFirstViewController.h"
#import <DropboxSDK/DropboxSDK.h>

@interface MyFirstViewController ()<MyFirstViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *views;


@end

@implementation MyFirstViewController

@synthesize myFirstView;
@synthesize mySecondVC;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myFirstView = [[MyFirstView alloc]init];
    self.myFirstView.translatesAutoresizingMaskIntoConstraints = NO;
    self.myFirstView.backgroundColor = [UIColor clearColor];
    self.myFirstView.firstViewDelegate = self;
    [self.view addSubview:self.myFirstView];
    
    self.views = [NSDictionaryOfVariableBindings(myFirstView) mutableCopy];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[myFirstView]|" options:0 metrics: 0 views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[myFirstView]|" options:0 metrics: 0 views:self.views]];
    
    [self.myFirstView createViews];
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{
    if (![[DBSession sharedSession] isLinked])
    {
        [self.myFirstView.linkButton setTitle:@"Link" forState:UIControlStateNormal];
        self.myFirstView.navButton.userInteractionEnabled = NO;
        self.myFirstView.navButton.alpha = 0.5;
        
 
    }
    else
    {
        
        [self.myFirstView.linkButton setTitle:@"UnLink" forState:UIControlStateNormal];
        self.myFirstView.navButton.userInteractionEnabled = YES;
        self.myFirstView.navButton.alpha = 1.0;

    }
    
    
    [super viewDidAppear:animated];
    
    
    
}

#pragma mark FirstView Delegate Methods

- (void)linkerButtonClicked
{
    
    if (![[DBSession sharedSession] isLinked])
    {
        [[DBSession sharedSession] linkFromController:self];
        [self.myFirstView.linkButton setTitle:@"UnLink" forState:UIControlStateNormal];
        self.myFirstView.navButton.userInteractionEnabled = YES;
        self.myFirstView.navButton.alpha = 1.0;
    }
    else
    {
        
        
        [[DBSession sharedSession] unlinkAll];
        [[[UIAlertView alloc]
          initWithTitle:@"Account Unlinked!" message:@"Your dropbox account has been unlinked"
          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        [self.myFirstView.linkButton setTitle:@"Link" forState:UIControlStateNormal];
        self.myFirstView.navButton.userInteractionEnabled = NO;
        self.myFirstView.navButton.alpha = 0.5;
        
    }
    
    
    
   
    
    
    
}



- (void)justNavigate
{
    self.mySecondVC.view.hidden = YES;
    [self.navigationController pushViewController:self.mySecondVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
