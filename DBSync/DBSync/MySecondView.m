//
//  MySecondView.m
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import "MySecondView.h"

@interface MySecondView ()

@property (nonatomic, strong) NSMutableDictionary *views;

@end

@implementation MySecondView

@synthesize detailTableView;
@synthesize addNewItemButton;
@synthesize backButton;

- (id)init
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
    
    }
    return  self;
    
}

- (void)createViews
{
    
    self.detailTableView = [[UITableView alloc]init];
    self.detailTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailTableView.separatorColor = [UIColor grayColor];
    self.detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.detailTableView.backgroundColor = [UIColor clearColor];
    self.detailTableView.layer.cornerRadius = 2;
    self.detailTableView.layer.borderWidth = 2;
    self.detailTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:self.detailTableView];
    
    
    
    self.addNewItemButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addNewItemButton.backgroundColor = [UIColor clearColor];
    self.addNewItemButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.addNewItemButton.layer.cornerRadius = 10;
    self.addNewItemButton.layer.borderWidth = 2;
    self.addNewItemButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.addNewItemButton setTitle:@"Add New" forState:UIControlStateNormal];
    [self.addNewItemButton addTarget:self action:@selector(addNewItemInDropBox) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addNewItemButton];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.backButton.layer.cornerRadius = 10;
    self.backButton.layer.borderWidth = 2;
    self.backButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.backButton.backgroundColor = [UIColor clearColor];
    [self.backButton setTitle:@"Back" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(goBackToPrevPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    //  @"H:|-50-[backButton(==100)]-20-[doneButton(==100)]"
    self.views = [NSDictionaryOfVariableBindings(detailTableView,addNewItemButton,backButton) mutableCopy];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[backButton]-20-[addNewItemButton(==backButton)]-20-|" options:0 metrics: 0 views:self.views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-1-[detailTableView]-1-|" options:0 metrics: 0 views:self.views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[addNewItemButton(==50)]-1-[detailTableView]|" options:0 metrics: 0 views:self.views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backButton(==50)]-1-[detailTableView]|" options:0 metrics: 0 views:self.views]];
    
}


- (void)addNewItemInDropBox
{
    [self.mySecondViewDelegate addItemInDB];
    
}


- (void)goBackToPrevPage
{
    
    [self.mySecondViewDelegate goBackToPrevPage];
}


@end
