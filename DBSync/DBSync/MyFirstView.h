//
//  MyFirstView.h
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MyFirstViewDelegate <NSObject>

- (void)linkerButtonClicked;
- (void)justNavigate;


@end


@interface MyFirstView : UIView

@property (nonatomic, strong) UIButton *linkButton;
@property (nonatomic, strong) UIButton *navButton;

@property (nonatomic, weak)id<MyFirstViewDelegate>firstViewDelegate;

//Functions

- (void)createViews;

@end
