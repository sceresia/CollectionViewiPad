//
//  SaveDataManager.m
//  CollectionViewTest
//
//  Created by Stephen on 2014-11-15.
//  Copyright (c) 2014 Stephen Ceresia. All rights reserved.
//

#import "SaveDataManager.h"

@implementation SaveDataManager

+ (void) saveImages:(NSMutableArray *) array
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [ [paths objectAtIndex:0] stringByAppendingPathComponent:@"archive.dat"];
    
    // Archive Array
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
    
    NSLog(@"Saving %i images to local storage", [array count]);

}

+ (NSMutableArray *) loadSavedImages
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [ [paths objectAtIndex:0] stringByAppendingPathComponent:@"archive.dat"];
    
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"Loading %i images from local storage", [array count]);
    
    return array;
}

/////
+ (void) saveImages:(NSMutableArray *) array forPage:(int) page
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *pathComponent = [NSString stringWithFormat:@"archive%i.dat", page];

    NSString *path = [ [paths objectAtIndex:0] stringByAppendingPathComponent:pathComponent];
    
    // Archive Array
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:array];
    [data writeToFile:path options:NSDataWritingAtomic error:nil];
    
    NSLog(@"Saving %i images for page %i to local storage", [array count], page);
}


+ (NSMutableArray *) loadSavedImagesForPage:(int) page
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *pathComponent = [NSString stringWithFormat:@"archive%i.dat", page];
    NSString *path = [ [paths objectAtIndex:0] stringByAppendingPathComponent:pathComponent];
    
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"Loading %i images for page %i from local storage", [array count], page);
    
    return array;
}

@end
