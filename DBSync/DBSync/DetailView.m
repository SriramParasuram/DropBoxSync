

//
//  DetailView.m
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 30/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import "DetailView.h"

@interface DetailView ()

@property (nonatomic, strong) NSMutableDictionary *views;

@end

@implementation DetailView

@synthesize detailTextView;
@synthesize doneButton;
@synthesize backButton;

- (id)init
{
    
    self = [super init];
    if(self)
    {
        
    }
    
    return self;
}

- (void)createViews
{
    
    self.detailTextView = [[UITextView alloc]init];
    self.detailTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailTextView.backgroundColor = [UIColor clearColor];
    self.detailTextView.returnKeyType = UIReturnKeyDefault;
    self.detailTextView.layer.cornerRadius = 10;
    self.detailTextView.layer.borderWidth = 2;
    self.detailTextView.layer.borderColor = [UIColor blackColor].CGColor;
    [self addSubview:self.detailTextView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
   // [self.backButton setFrame:CGRectMake(0,0, 50, 50)];
    //self.backButton.center = CGPointMake(60,60);
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.backButton.layer.cornerRadius = 10;
    self.backButton.layer.borderWidth = 2;
    self.backButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.backButton.backgroundColor = [UIColor clearColor];
    [self.backButton setTitle:@"back" forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(goBackToPrevPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    
    self.doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    //[self.doneButton setFrame:CGRectMake(0,0, 50, 50)];
    //self.doneButton.center = CGPointMake(260,60);
    self.doneButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.doneButton.layer.cornerRadius = 10;
    self.doneButton.layer.borderWidth = 2;
    self.doneButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.doneButton.backgroundColor = [UIColor clearColor];
    [self.doneButton setTitle:@"done" forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(doneAndSave) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.doneButton];
    
    
    self.views = [NSDictionaryOfVariableBindings(detailTextView,backButton,doneButton) mutableCopy];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[backButton]-20-[doneButton(==backButton)]-20-|" options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom metrics: 0 views:self.views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[detailTextView]-10-|" options:0 metrics: 0 views:self.views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[doneButton(==50)]-[detailTextView(==150)]" options:0 metrics: 0 views:self.views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[backButton(==50)]-[detailTextView(==150)]" options:0 metrics: 0 views:self.views]];
    
    
}

- (void)goBackToPrevPage
{
    
    [self.detailViewDelegate goBackToPrev];
}

- (void)doneAndSave
{
    
    [self.detailViewDelegate doneClicked];
    
}


@end

