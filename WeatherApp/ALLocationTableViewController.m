//
//  ALLocationTableViewController.m
//  WeatherApp
//
//  Created by Линник Александр on 05.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALLocationTableViewController.h"
#import "ALLocationListDataSource.h"
#import "ALLocationTableViewCell.h"

@interface ALLocationTableViewController () <UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *dataRows;

@property (strong, nonatomic) NSMutableArray* filterTempArray;

@property (strong, nonatomic) NSOperation* currenTOperation;

@property (assign, nonatomic) BOOL isSectionLocation;

@end


@implementation ALLocationTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self settingNavigationBar];
    
    self.searchBar.delegate = self;

    self.filterTempArray = [NSMutableArray new];
    
    ALLocationListDataSource *dataSource = [[ALLocationListDataSource alloc] init];
    
    _dataRows = [[dataSource locations] mutableCopy];
    
    NSSortDescriptor* sortDescriptorName =[[NSSortDescriptor alloc]initWithKey:@"country" ascending:YES];
    
    [self.dataRows sortUsingDescriptors:@[sortDescriptorName]];
    
    [self filterArrayInBackground:self.dataRows withFilter:nil];


}


#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:YES];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    
    [self filterArrayInBackground:self.dataRows withFilter:searchBar.text];
    
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    [self filterArrayInBackground:self.dataRows withFilter:searchBar.text];
    
}


#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _filterTempArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"locationCell";
    
    ALLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSDictionary* location = [_filterTempArray objectAtIndex:indexPath.row];
    
    NSString* locatinName = [NSString new];

    if ([[location valueForKey:kCountryCallingCode]length]>0) {
        
        locatinName = [NSString stringWithFormat:@"(%@) ",[location valueForKey:kCountryCallingCode]];

    }
    
    cell.textLabel.text = [locatinName stringByAppendingString:[location valueForKey:kCountryName]];
    
    return cell;
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _isSectionLocation = YES;
    
}


#pragma mark - Initialization methods


- (void)settingNavigationBar {
    
    UIImage *backButtonImage = [UIImage imageNamed:@"backBtn"];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backButton setImage:backButtonImage forState:UIControlStateNormal];
    
    backButton.frame = CGRectMake(0.0, 0.0, backButtonImage.size.width, backButtonImage.size.height);
    
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
}


#pragma mark - Privet Methods

-(NSMutableArray*) filterArray:(NSMutableArray*) array withFilter:(NSString*) filterString {
    
    NSMutableArray* filtrArray = [[NSMutableArray alloc]init];
    
    for (NSDictionary* location in array) {
        
        if ([filterString length] > 0 && [[location objectForKey:@"name"] rangeOfString:filterString options:NSCaseInsensitiveSearch].location== NSNotFound) {
            
            continue;
        }
        
        [filtrArray addObject:location];
        
    }
    
    return filtrArray;
    
}


-(void) filterArrayInBackground : (NSMutableArray*) array withFilter:(NSString*) filterString {
    
    [self.currenTOperation cancel];
    
    __weak ALLocationTableViewController* weakSelf = self;
    
    self. currenTOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSMutableArray* filterTempArray = [weakSelf filterArray:array withFilter:filterString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            weakSelf.filterTempArray = filterTempArray;
            
            [self.tableView reloadData];
            
            self.currenTOperation = nil;
        });
    }];
    
    [self.currenTOperation start];
    
}


- (void)backAction {
    
    if (_isSectionLocation) {
        
        NSDictionary* location = [_filterTempArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        NSString* selectLocation = [location valueForKey:kCountryName];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"udateWeather" object:selectLocation];
        
        [[NSUserDefaults standardUserDefaults] setObject: selectLocation forKey:@"location"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
