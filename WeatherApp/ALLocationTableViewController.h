//
//  ALLocationTableViewController.h
//  WeatherApp
//
//  Created by Линник Александр on 05.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LocationListViewDelegate <NSObject>

- (void)didSelectCountry:(NSDictionary *)country;

@end

@interface ALLocationTableViewController : UITableViewController


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic, assign) id<LocationListViewDelegate>delegate;



@end
