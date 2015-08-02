//
//  MySecondView.h
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MySecondViewDelegate <NSObject>

- (void)addItemInDB;
- (void)goBackToPrevPage;

@end

@interface MySecondView : UIView

@property (nonatomic, strong) UITableView *detailTableView;
@property (nonatomic, strong) UIButton *addNewItemButton;
@property (nonatomic, strong) UIButton *backButton;

@property (nonatomic, weak) id<MySecondViewDelegate>mySecondViewDelegate;

- (void)createViews;




@end
