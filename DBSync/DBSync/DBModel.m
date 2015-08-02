//
//  DBModel.m
//  DropBoxSyncApp
//
//  Created by Sriram Parasuram on 01/08/15.
//  Copyright (c) 2015 Sriram Parasuram. All rights reserved.
//

#import "DBModel.h"
#import <DropboxSDK/DropboxSDK.h>

@interface DBModel ()<DBRestClientDelegate>

@end

@implementation DBModel


- (id)init
{
    self = [super init];
    if(self)
    {
        self.restClient = [[DBRestClient alloc] initWithSession:[DBSession sharedSession]];
        self.restClient.delegate = self;
        self.modelMetaDataFileArray = [NSMutableArray array];
        self.metaDataRevArray = [NSMutableArray array];
    }
    
    return self;
    
}


#pragma mark API CALLS

- (void)readContentsInDropBoxForPath:(NSString *)path
{
    
    
    [self.restClient loadMetadata:@"/"];
    
}


- (void)deleteFileInDropBoxAtIndexInTable:(NSIndexPath *)indexPath
{
    [self.restClient deletePath:[NSString stringWithFormat:@"/%@",[self.modelMetaDataFileArray objectAtIndex:indexPath.row]]];
    
}

- (void)uploadFile:(NSString *)fileName FromPath:(NSString *)fPath toPath:(NSString *)tPath WithParentRev:(NSString *)parentRev
{
    
    [self.restClient uploadFile:fileName toPath:tPath withParentRev:parentRev fromPath:fPath];
    
}

- (void)loadContentsOfFileForFileName:(NSString *)fileName intoPath:(NSString *)localPath
{
    
    [self.restClient loadFile:[NSString stringWithFormat:@"/%@",fileName] intoPath:localPath];
    
}


#pragma mark restclient protocol functions



- (void)restClient:(DBRestClient *)client loadedMetadata:(DBMetadata *)metadata
{
    
    [self.metaDataRevArray removeAllObjects];
    if (metadata.isDirectory)
    {
        for (DBMetadata *file in metadata.contents)
        {
            [self.modelMetaDataFileArray addObject:file.filename];
            [self.metaDataRevArray addObject:file.rev];
        }
    }
    
    NSLog(@"parent rev array %@",self.metaDataRevArray);
    [self.dbModelDelegate metadataReturnedWithValues:metadata withRevArray:self.metaDataRevArray];

    

    
}

- (void)restClient:(DBRestClient *)client loadMetadataFailedWithError:(NSError *)error
{
    
    NSLog(@"Error loading metadata: %@", error);
}


- (void)restClient:(DBRestClient *)client deletedPath:(NSString *)path
{
    
    NSLog(@"reached model delete");
    [self.dbModelDelegate fileDeletedAtPath:path];
}


- (void)restClient:(DBRestClient *)client deletePathFailedWithError:(NSError *)error
{
    
}


- (void)restClient:(DBRestClient *)client uploadedFile:(NSString *)destPath from:(NSString *)srcPath metadata:(DBMetadata *)metadata
{
    //NSLog(@"File uploaded successfully to path: %@", metadata.path);
    
    [self.dbModelDelegate fileUploadedSuccesfullyToPath:metadata.path];
    
}

- (void)restClient:(DBRestClient *)client uploadFileFailedWithError:(NSError *)error
{
    NSLog(@"File upload failed with error: %@", error);
}




- (void)restClient:(DBRestClient*)client loadedFile:(NSString*)destPath
{
    NSString *content = [NSString stringWithContentsOfFile:destPath encoding:NSUTF8StringEncoding error:NULL];
    [self.dbModelDelegate fileLoadedWithContent:content];
}




@end
