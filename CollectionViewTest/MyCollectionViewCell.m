//
//  MyCollectionViewCell.m
//  CollectionViewTest
//
//  Created by Stephen on 2014-11-14.
//  Copyright (c) 2014 Stephen Ceresia. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.isSelected = NO;
    }
    return self;
}

@end
