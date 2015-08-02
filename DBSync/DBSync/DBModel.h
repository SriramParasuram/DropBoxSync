//
//  DBModel.h
//  DropBoxSyncApp
//
//  Created by Sriram Parasuram on 01/08/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DropboxSDK/DropboxSDK.h>


static NSMutableArray *metaDataRevArray;

@protocol DBModelDelegate <NSObject>

- (void ) metadataReturnedWithValues:(DBMetadata *)metadata withRevArray:(NSMutableArray *)revArray;
- (void) fileDeletedAtPath:(NSString *)path;
- (void)fileUploadedSuccesfullyToPath:(NSString *)path;
- (void)fileLoadedWithContent:(NSString *)content;

@end

@interface DBModel : NSObject

@property (nonatomic, strong) DBRestClient *restClient;
@property (nonatomic, strong) NSMutableArray *modelMetaDataFileArray;
@property (nonatomic, strong) NSMutableArray *metaDataRevArray;
@property (nonatomic, weak) id<DBModelDelegate>dbModelDelegate;


- (void)loadContentsFromDropBox;

- (void)readContentsInDropBoxForPath:(NSString *)path;

- (void)deleteFileInDropBoxAtIndexInTable:(NSIndexPath *)indexPath;

- (void)deleteFileInDropBoxWithPath:(NSString *)pathString;

- (void)uploadFile:(NSString *)fileName FromPath:(NSString *)fPath toPath:(NSString *)tPath WithParentRev:(NSString *)parentRev;

- (void)loadContentsOfFileForFileName:(NSString *)fileName intoPath:(NSString *)localPath;

- (NSMutableArray *)getRevArray;



@end
