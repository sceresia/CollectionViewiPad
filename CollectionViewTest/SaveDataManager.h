//
//  SaveDataManager.h
//  CollectionViewTest
//
//  Created by Stephen on 2014-11-15.
//  Copyright (c) 2014 Stephen Ceresia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveDataManager : NSObject

+ (void) saveImages:(NSMutableArray *) array;
+ (NSMutableArray *) loadSavedImages;

+ (void) saveImages:(NSMutableArray *) array forPage:(int) page;
+ (NSMutableArray *) loadSavedImagesForPage:(int) page;

@end
