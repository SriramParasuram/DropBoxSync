//
//  DetailViewController.h
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 30/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) DetailView *detailView;
@property (nonatomic, strong) NSString *displayContents;
@property (nonatomic, strong) NSString *fileNameToBeRead;
@property  NSIndexPath *indexPathToBeRead;
@property (nonatomic, strong) NSMutableArray *metaDataFileNameArray;
@property (nonatomic, strong) NSMutableArray *revArray;




@end
