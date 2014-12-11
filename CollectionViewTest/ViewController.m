//
//  ViewController.m
//  CollectionViewTest
//
//  Created by Stephen on 2014-11-14.
//  Copyright (c) 2014 Stephen Ceresia. All rights reserved.
//

#import "ViewController.h"
#import "SaveDataManager.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // register for notification of popover selectionchanged
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotificationForPopOverSelectionChanged:) name:@"PopOverSelectionChanged" object:nil];
    
    // prepare the collectionview
    _myCollectionView = self.myCollectionView;
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    _myCollectionView.allowsMultipleSelection = YES;
    
    // load the collectionview with any previously saved images
    _imagesArray = [[NSMutableArray alloc]init];
    _imagesArray = [SaveDataManager loadSavedImages];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_imagesArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.isSelected = NO;
    cell.myImageView.image = [_imagesArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == nil)
    {
        NSLog(@"error: no indexPath");
    }
    else
    {
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[_myCollectionView cellForItemAtIndexPath:indexPath];
        if (!cell.isSelected)
        {
            cell.isSelected = YES;
            cell.myImageView.alpha = 0.5f;
            [_myCollectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            
        }
        else
        {
            //[self selectCellAtIndexPath:indexPath isSelected:NO];
            
            cell.isSelected = NO;
            cell.myImageView.alpha = 1.0f;
            [_myCollectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
        
        NSLog(@"selected count %i",[_myCollectionView indexPathsForSelectedItems].count);

    }
}

- (IBAction)tapMeTapped:(id)sender
{
    int maxPhotos = 16 - [_imagesArray count];
    
    // Create the image picker
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = maxPhotos; //4; //Set the maximum number of images to select, defaults to 4
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return selected order of images
    elcPicker.imagePickerDelegate = self;
    
    //Present modally
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (IBAction)deleteButtonTapped:(id)sender
{
    NSMutableArray *selectedItems = [[NSMutableArray alloc]init];
    
    // Loop through all the cells and grab the selected ones
    for (MyCollectionViewCell *cell in _myCollectionView.visibleCells)
    {
        if (cell.isSelected)
        {
            [selectedItems addObject:cell];
        }
    }
    
    if (selectedItems.count == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remove images"
                                                        message:@"No images select. Please select at least one first to delete."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Remove images"
                                                        message:@"Remve the selected images?"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Delete", nil];
        [alert show];
    }

}

- (IBAction)popOverTapped:(UIBarButtonItem *)sender
{
    NSLog(@"popover tapped");
    
    PopOverViewController *newView = [[PopOverViewController alloc]initWithNibName:@"PopOverViewController" bundle:nil];
    
    self.popOver = [[UIPopoverController alloc] initWithContentViewController:newView];
    
    [self.popOver setPopoverContentSize:CGSizeMake(200, 250)];
    
    [self.popOver presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    //[self.popOver presentPopoverFromRect:sender.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

// VIDEO
- (IBAction)playVideoTapped:(id)sender
{
    NSURL *url = [NSURL URLWithString:
                  @"http://www.ebookfrenzy.com/ios_book/movie/movie.mov"];
    
    _moviePlayer =  [[MPMoviePlayerController alloc]
                     initWithContentURL:url];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:_moviePlayer];
    
    _moviePlayer.controlStyle = MPMovieControlStyleDefault;
    _moviePlayer.shouldAutoplay = YES;
    [self.view addSubview:_moviePlayer.view];
    [_moviePlayer setFullscreen:YES animated:YES];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
}
// VIDEO

// Alert view delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    // the user clicked OK
    if (buttonIndex == 1)
    {
        NSLog(@"delete the images");
        
        // DELETE IMAGES
        
        // remove the image from our imagesArray (table will reload with this count)
        NSMutableArray *imagesToRemove = [[NSMutableArray alloc]init];
        for (MyCollectionViewCell *cell in _myCollectionView.visibleCells)
        {
            if (cell.isSelected)
            {
                //[_imagesArray removeObject:cell.myImageView.image];
                [imagesToRemove addObject:cell.myImageView.image];
            }
        }
        
        NSArray *selectedItemsIndexPaths = [_myCollectionView indexPathsForSelectedItems];

        // remove them from the collection
        [_myCollectionView performBatchUpdates:^{
            [_imagesArray removeObjectsInArray:imagesToRemove];
            [_myCollectionView deleteItemsAtIndexPaths:selectedItemsIndexPaths];
        } completion:^(BOOL finished) {
        }];
        
        [SaveDataManager saveImages:_imagesArray];
    }
}


// Image picker delegates
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    NSLog(@"array contains %li images", (unsigned long)[info count]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    for (id item in info)
    {
        NSLog(@"path is %@", [item objectForKey:@"UIImagePickerControllerReferenceURL"]);
        
        NSURL* aURL = [item objectForKey:@"UIImagePickerControllerReferenceURL"];
        
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:aURL resultBlock:^(ALAsset *asset)
         {
             UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage] scale:0.5 orientation:UIImageOrientationUp];
             
             if (copyOfOriginalImage != nil)
             {
                 if (_imagesArray.count < 16)
                 {
                     // add the newly selected images to the array
                     [_imagesArray addObject:copyOfOriginalImage];
                 }
                 else
                 {
                     NSLog(@"page is full - not adding any more images");
                 }
             }
             else
             {
                 NSLog(@"ERROR: ALAssetsLibray image is nil");
             }
             
             // save new images
             // TODO: we're saving twice here... optimize
             [SaveDataManager saveImages:_imagesArray];

         }
                    failureBlock:^(NSError *error)
         {
             // error handling
             NSLog(@"failure-----");
         }];
        
        // update collectionview with the new images
        [_myCollectionView reloadData];

    }
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// notification
- (void)didReceiveNotificationForPopOverSelectionChanged:(NSNotification *)notification
{
    // Reload data here
    // TODO: only reload if a different selection
    NSLog(@"popoverselection changed");
}



//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
