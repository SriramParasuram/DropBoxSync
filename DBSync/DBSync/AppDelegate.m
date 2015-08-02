//
//  AppDelegate.m
//  MyDropBoxApp
//
//  Created by Sriram Parasuram on 29/07/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import "AppDelegate.h"

#import <DropboxSDK/DropboxSDK.h>

#import "MySecondViewController.h"

@interface AppDelegate ()<DBSessionDelegate,DBNetworkRequestDelegate>

@property(nonatomic, strong) MySecondViewController *mySecVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Set these variables before launching the app
    
    

    
    
    NSString* appKey = @"h7x2hhsxm0vb51p";
    NSString* appSecret = @"f6e286619avhnut";
    NSString *root = kDBRootAppFolder; //nil; // Should be set to either kDBRootAppFolder or kDBRootDropbox
    // You can determine if you have App folder access or Full Dropbox along with your consumer key/secret
    // from https://dropbox.com/developers/apps
    
    // Look below where the DBSession is created to understand how to use DBSession in your app
    
    NSString* errorMsg = nil;
    if ([appKey rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
        errorMsg = @"Make sure you set the app key correctly in DBRouletteAppDelegate.m";
    } else if ([appSecret rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
        errorMsg = @"Make sure you set the app secret correctly in DBRouletteAppDelegate.m";
    } else if ([root length] == 0) {
        errorMsg = @"Set your root to use either App Folder of full Dropbox";
    } else {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        NSData *plistData = [NSData dataWithContentsOfFile:plistPath];
        NSDictionary *loadedPlist =
        [NSPropertyListSerialization
         propertyListFromData:plistData mutabilityOption:0 format:NULL errorDescription:NULL];
        NSString *scheme = [[[[loadedPlist objectForKey:@"CFBundleURLTypes"] objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"] objectAtIndex:0];
        if ([scheme isEqual:@"h7x2hhsxm0vb51p"]) {
            errorMsg = @"Set your URL scheme correctly in DBRoulette-Info.plist";
        }
    }
    
    //self.navigationController.navigationBarHidden
    
    DBSession* session =
    [[DBSession alloc] initWithAppKey:appKey appSecret:appSecret root:root];
    session.delegate = self; // DBSessionDelegate methods allow you to handle re-authenticating
    [DBSession setSharedSession:session];
    
//    DBAccountManager *accountManager =
//    [[DBAccountManager alloc] initWithAppKey:@"h7x2hhsxm0vb51p" secret:@"f6e286619avhnut"];
//    [DBAccountManager setSharedManager:accountManager];
    
    
    
    
    [DBRequest setNetworkRequestDelegate:self];
    
    
    if ([[DBSession sharedSession] isLinked])
    {
        
        self.navigationController.viewControllers = [NSArray arrayWithObjects:self.myFirstVC,self.myFirstVC.mySecondVC ,nil];
    }
    
    
//    if (errorMsg != nil) {
//        [[[[UIAlertView alloc]
//           initWithTitle:@"Error Configuring Session" message:errorMsg
//           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show]];
//    }
//    
//    rootViewController.photoViewController = [[PhotoViewController new] autorelease];
//    if ([[DBSession sharedSession] isLinked]) {
//        navigationController.viewControllers =
//        [NSArray arrayWithObjects:rootViewController, rootViewController.photoViewController, nil];
//    }
    
    // Add the navigation controller's view to the window and display.
//    [self.window addSubview:self.navigationController.view];
//    [self.window makeKeyAndVisible];
    
    NSURL *launchURL = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    NSInteger majorVersion =
    [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
    if (launchURL && majorVersion < 4)
    {
        [self application:application handleOpenURL:launchURL];
        return NO;
    }
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.myFirstVC = [[MyFirstViewController alloc]init];
    self.myFirstVC.mySecondVC = [MySecondViewController new];
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.myFirstVC];
    self.navigationController.navigationBarHidden = YES;
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            
            NSLog(@"myfirstVC %@",self.myFirstVC);
            NSLog(@"aaa %@",self.myFirstVC.mySecondVC);
            NSLog(@"please!! %@",self.navigationController);
            
            [self.navigationController pushViewController:self.myFirstVC.mySecondVC animated:YES];

        }
        return YES;
    }
    
    
    
    return NO;
}


#pragma mark DBNetworkRequestDelegate methods

static int outstandingRequests;

- (void)networkRequestStarted {
    outstandingRequests++;
    if (outstandingRequests == 1) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}

- (void)networkRequestStopped {
    outstandingRequests--;
    if (outstandingRequests == 0) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
