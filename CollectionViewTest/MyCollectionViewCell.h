//
//  MyCollectionViewCell.h
//  CollectionViewTest
//
//  Created by Stephen on 2014-11-14.
//  Copyright (c) 2014 Stephen Ceresia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;

@property (nonatomic) BOOL isSelected;

@end
