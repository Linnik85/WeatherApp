//
//  ALSettingsTableViewController.m
//  WeatherApp
//
//  Created by Линник Александр on 05.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALSettingsTableViewController.h"


@interface ALSettingsTableViewController ()

@end


@implementation ALSettingsTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self settingNavigationBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateWeather:)
                                                 name:@"udateWeather"
                                               object:nil];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (![userDefaults boolForKey:@"isCelsius"]){
        
        self.temparaturSwithOutlet.on = YES;
        
    } else {
        
        self.temparaturSwithOutlet.on = NO;
        
    }
    
    if ([userDefaults objectForKey:@"location"]) {
        
        self.locationName.text =[userDefaults objectForKey:@"location"];
    }
    
}


#pragma mark - Notification


-(void) updateWeather: (NSNotification*) notification{
    
    if ([[notification object] isKindOfClass:[NSString class]]) {
        
        self.locationName.text = [notification object];
        
    }
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


- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - Actions


- (IBAction)temperaturAction:(id)sender {
    
    if (self.temparaturSwithOutlet.on) {
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isCelsius"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];

        
    } else {
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isCelsius"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"udateUINotitfication" object:nil];
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"udateWeather" object:nil];

}





@end
