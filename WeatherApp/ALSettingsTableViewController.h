//
//  ALSettingsTableViewController.h
//  WeatherApp
//
//  Created by Линник Александр on 05.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALSettingsTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *locationName;

@property (weak, nonatomic) IBOutlet UISwitch *temparaturSwithOutlet;

- (IBAction)temperaturAction:(id)sender;

@end
