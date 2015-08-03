//
//  MySecondViewController.h
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySecondView.h"

@interface MySecondViewController : UIViewController

@property (nonatomic, strong) MySecondView *mySecondView;

@property (nonatomic, strong) NSMutableArray *metaDataFileNameArray;

@property NSIndexPath *indexPathToBeDeleted;

@end
