//
//  ViewController.h
//  CollectionViewTest
//
//  Created by Stephen on 2014-11-14.
//  Copyright (c) 2014 Stephen Ceresia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MyCollectionViewCell.h"
#import "ELCImagePickerController.h"
#import "PopOverViewController.h"

@interface ViewController : UIViewController <ELCImagePickerControllerDelegate, UIAlertViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

//@property (strong, nonatomic) UIImage *myImage;

@property (nonatomic, strong) UIPopoverController *popOver;

@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;

@property (strong, nonatomic) UIImage *myImage;

@property (weak, nonatomic) IBOutlet UITextView *leftTextView;

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;

- (IBAction)tapMeTapped:(id)sender;
- (IBAction)deleteButtonTapped:(id)sender;
- (IBAction)popOverTapped:(id)sender;
- (IBAction)playVideoTapped:(id)sender;


// Image picker delegates
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker;

@end

