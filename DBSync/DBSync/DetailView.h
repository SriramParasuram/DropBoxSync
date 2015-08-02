//
//  DetailView.h
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 30/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol  DetailViewDelegate <NSObject>

- (void)goBackToPrev;
- (void)doneClicked;

@end


@interface DetailView : UIView

@property (nonatomic, strong) UITextView *detailTextView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, weak) id<DetailViewDelegate>detailViewDelegate;
@property (nonatomic, strong) UIButton *doneButton;

- (void)createViews;

@end
