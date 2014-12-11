//
//  PopOverViewController.m
//  CollectionViewTest
//
//  Created by Stephen on 2014-11-16.
//  Copyright (c) 2014 Stephen Ceresia. All rights reserved.
//

#import "PopOverViewController.h"

@interface PopOverViewController ()

@end

@implementation PopOverViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _rowNames = [NSArray arrayWithObjects:@"Row 1", @"Row 2", @"Row 3", @"Row 4", nil];
}

//

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_rowNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [_rowNames objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // selection changed
    // TODO: save the new page/view whatever location
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PopOverSelectionChanged" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// uitableview delegates
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.text=@"Archives";
    label.backgroundColor=[UIColor whiteColor];
    label.textAlignment= NSTextAlignmentCenter;
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
