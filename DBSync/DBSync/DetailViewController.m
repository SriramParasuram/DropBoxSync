

//
//  DetailViewController.m
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 30/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import "DetailViewController.h"
#import "DBModel.h"



@interface DetailViewController ()<UITextFieldDelegate,UITextViewDelegate,DetailViewDelegate,DBModelDelegate>

@property (nonatomic, strong) NSMutableDictionary *views;
@property (nonatomic, strong) DBModel *dbModel;

@end

@implementation DetailViewController

@synthesize detailView;




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailView = [[DetailView alloc]init];
    self.detailView.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailView.detailViewDelegate = self;
    [self.view addSubview:self.detailView];
    
    self.views = [NSDictionaryOfVariableBindings(detailView) mutableCopy];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[detailView]|" options:0 metrics: 0 views:self.views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[detailView]|" options:0 metrics: 0 views:self.views]];
    
    
    [self.detailView createViews];
    
    
    self.dbModel = [[DBModel alloc]init];
    self.dbModel.dbModelDelegate = self;
    
    self.detailView.detailTextView.delegate = self;
    self.detailView.detailTextView.text = self.displayContents;
}


- (void)viewDidAppear:(BOOL)animated
{
    
    [self readContents];
    self.view.hidden = NO;
    if(self.fileNameToBeRead.length>0)
    [self loadContentsForFileName:self.fileNameToBeRead];
    
    else
        self.detailView.detailTextView.text = @"";
    
    
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.displayContents = @"";
    
}



# pragma mark DetailViewDelegate Methods

- (void)goBackToPrev
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)doneClicked
{
    [self saveToDropBoxWithText:self.displayContents];
}

# pragma mark ViewController Local methods


- (void)loadContentsForFileName:(NSString *)fileName
{
    
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:fileName];
    [self.dbModel loadContentsOfFileForFileName:[NSString stringWithFormat:@"/%@",fileName] intoPath:localPath];
}


- (void)saveToDropBoxWithText:(NSString *)text
{
    
    NSLog(@"rev array is %@",self.revArray);
    NSLog(@"sss %@",[self.revArray objectAtIndex:self.indexPathToBeRead.row]);


    if(text.length>0)
    {
    NSString *fileName;
    if(text.length<5)
    {
        fileName = text;
    }
    
    else
    {
        fileName = [text substringToIndex:5];
    }
    
        
    //NSString *filename = [text substringToIndex:5];
    NSString *localDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *localPath = [localDir stringByAppendingPathComponent:fileName];
    [text writeToFile:localPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSString *destDir = @"/";
        NSLog(@"working?? %@",[self.revArray objectAtIndex:self.indexPathToBeRead.row]);
        
    [self.dbModel uploadFile:fileName FromPath:localPath toPath:destDir WithParentRev:[self.revArray objectAtIndex:self.indexPathToBeRead.row]];
    }
    
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"DropBox" message:@"Please enter a valid value." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self.detailView.detailTextView resignFirstResponder];
    }

}


#pragma mark TextView Delegate



- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}




- (void)textViewDidChange:(UITextView *)textView
{
    self.displayContents = textView.text;
}


- (void)readContents
{
    
    
    [self.dbModel readContentsInDropBoxForPath:@"/"];
    
}





#pragma mark DBModel protocols

- (void)fileUploadedSuccesfullyToPath:(NSString *)path
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)fileLoadedWithContent:(NSString *)content
{
    
    self.detailView.detailTextView.text = content;
}


- (void)metadataReturnedWithValues:(DBMetadata *)metadata withRevArray:(NSMutableArray *)revArray
{
    NSLog(@"rev array %@",revArray);
    self.revArray = revArray;
    
}




@end
