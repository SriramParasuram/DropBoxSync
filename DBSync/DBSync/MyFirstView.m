//
//  MyFirstView.m
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import "MyFirstView.h"

@interface MyFirstView ()

@property (nonatomic, strong) NSMutableDictionary *views;

@end


@implementation MyFirstView

@synthesize linkButton;
@synthesize navButton;

- (id)init
{
    self = [super init];
    if(self)
    {
       // [self createViews];
    }
    
    return self;
    
}


- (void)createViews
{
    
    self.linkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.linkButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.linkButton.backgroundColor = [UIColor clearColor];
    self.linkButton.layer.cornerRadius = 10;
    self.linkButton.layer.borderWidth = 2;
    self.linkButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.linkButton setTitle:@"" forState:UIControlStateNormal];
    [self.linkButton addTarget:self action:@selector(linkerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.linkButton];
    
    

    
    self.navButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.navButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.navButton.backgroundColor = [UIColor clearColor];
    self.navButton.layer.cornerRadius = 10;
    self.navButton.layer.borderWidth = 2;
    self.navButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.navButton setTitle:@"View" forState:UIControlStateNormal];
    [self.navButton addTarget:self action:@selector(travel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.navButton];
    
    
    self.views = [NSDictionaryOfVariableBindings(navButton,linkButton) mutableCopy];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[linkButton]-100-|" options:0 metrics: 0 views:self.views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[navButton]-100-|" options:0 metrics: 0 views:self.views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[linkButton(==60)]-60-[navButton(==60)]" options:0 metrics: 0 views:self.views]];
    
    
    
}


#pragma mark View Methods

- (void)linkerAction
{
    [self.firstViewDelegate linkerButtonClicked];
    
}


- (void)travel
{
    
    [self.firstViewDelegate justNavigate];
}


@end
