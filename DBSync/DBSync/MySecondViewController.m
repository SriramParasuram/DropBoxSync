//
//  MySecondViewController.m
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import "MySecondViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import "DetailViewController.h"
#import "DBModel.h"

#define iOS7orAbove ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS8orAbove ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MySecondViewController ()<DBRestClientDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,MySecondViewDelegate,DBModelDelegate,DBRestClientDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *views;
@property (nonatomic, strong) DBRestClient *restClient;
@property (nonatomic, strong) DetailViewController *detailVC;
@property (nonatomic, strong) UILabel *warningLabel;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) DBModel *dbModel;


@end

@implementation MySecondViewController

@synthesize mySecondView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mySecondView = [[MySecondView alloc]init];
    self.mySecondView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mySecondView.mySecondViewDelegate = self;
    [self.view addSubview:self.mySecondView];
    
    self.views = [NSDictionaryOfVariableBindings(mySecondView) mutableCopy];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mySecondView]|" options:0 metrics: 0 views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[mySecondView]|" options:0 metrics: 0 views:self.views]];
    
    [self.mySecondView createViews];
    
    self.mySecondView.detailTableView.delegate = self;
    self.mySecondView.detailTableView.dataSource = self;
    
    self.metaDataFileNameArray = [NSMutableArray array];
    
    
    self.detailVC = [[DetailViewController alloc]init];
    
    
    self.dbModel = [[DBModel alloc]init];
    self.dbModel.dbModelDelegate = self;

    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    self.view.hidden = NO;
    if ([[DBSession sharedSession] isLinked])
    {
        
        self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.restClient.delegate = self;

        [self readContents];

    }
    
}



# pragma mark MySecondView Delegates

- (void)addItemInDB
{
    
    self.detailVC.fileNameToBeRead = @"";
    self.detailVC.view.hidden = YES;
    [self tapped];
    
}

- (void)goBackToPrevPage
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


# pragma mark Gestures


- (void)tapped
{
    self.detailVC.displayContents = @"";
    [self.navigationController pushViewController:self.detailVC animated:YES];
    
    
}


# pragma mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.metaDataFileNameArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.mySecondView.detailTableView dequeueReusableCellWithIdentifier:@"myRow"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myRow"];
    }
    
    if (iOS7orAbove)
    {
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    if (iOS8orAbove)
    {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    cell.textLabel.text = [self.metaDataFileNameArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
    
    
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailVC.fileNameToBeRead = [self.metaDataFileNameArray objectAtIndex:indexPath.row];
    self.detailVC.indexPathToBeRead = indexPath;
    self.detailVC.metaDataFileNameArray= self.metaDataFileNameArray;
    self.detailVC.view.hidden = YES;
    [self.navigationController pushViewController:self.detailVC animated:YES];
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIAlertView *confirmationAlertView = [[UIAlertView alloc]initWithTitle:@"DropBox" message:@"Are you sure that you want to delete this entry?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    confirmationAlertView.delegate = self;
    [confirmationAlertView show];
    self.indexPathToBeDeleted = indexPath;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
    
}

# pragma mark ViewController Methods



- (void)readContents
{

    
    [self.dbModel readContentsInDropBoxForPath:@"/"];
    
}



#pragma mark DBModel methods

- (void)metadataReturnedWithValues:(DBMetadata *)metadata withRevArray:(NSMutableArray *)revArray
{
    
    [self.detailVC.revArray removeAllObjects];
    self.detailVC.revArray = revArray;
    
    if (metadata.isDirectory) {
        [self.metaDataFileNameArray removeAllObjects];
        
        
        
        
        for (DBMetadata *file in metadata.contents)
        {
            [self.metaDataFileNameArray addObject:file.filename];
            
        }
    }
    
    if(self.metaDataFileNameArray.count == 0)
    {
        
        self.mySecondView.detailTableView.hidden = YES;
        self.warningLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 100)];
        self.warningLabel.center = CGPointMake(160, 100);
        self.warningLabel.text = @"Folder is empty. Tap anywhere on the screen to create a file.";
        self.warningLabel.numberOfLines = 0;
        self.warningLabel.textColor = [UIColor blackColor];
        [self.mySecondView addSubview:self.warningLabel];
        
        self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
        self.tapGestureRecognizer.delegate = self;
        self.tapGestureRecognizer.numberOfTapsRequired = 1;
        [self.mySecondView addGestureRecognizer:self.tapGestureRecognizer];
        
    }
    
    
    else
    {
        self.mySecondView.detailTableView.hidden = NO;
        self.warningLabel.hidden = YES;
        [self.mySecondView removeGestureRecognizer:self.tapGestureRecognizer];
        
        
    }
    [self.mySecondView.detailTableView reloadData];
    
    
}



- (void)fileDeletedAtPath:(NSString *)path
{
    
    [self readContents];
    
    
}

- (void)sendErrorMessageWithString:(NSString *)errorString
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"DropBox" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];

    
}


#pragma mark AlertView delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSLog(@"index is %d",buttonIndex);
    if(buttonIndex == 1)
    {
        [self.dbModel deleteFileInDropBoxAtIndexInTable:self.indexPathToBeDeleted];
        
    }
    
    else
        
    {
        self.indexPathToBeDeleted = nil;
        [self.mySecondView.detailTableView reloadData];
        
        

    }
    

    
    
    
}



@end
