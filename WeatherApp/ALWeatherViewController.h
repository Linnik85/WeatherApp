//
//  WeatherViewController.h
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALWeatherViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *cityAndCountryLabelOutlet;

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabelOutlet;

@property (weak, nonatomic) IBOutlet UILabel *weatherDescriptionLabelOutlet;

@property (weak, nonatomic) IBOutlet UILabel *humidityLabelOutlet;

@property (weak, nonatomic) IBOutlet UILabel *windLabelOutlet;

@property (weak, nonatomic) IBOutlet UILabel *pressureLabelOutlet;

@property (weak, nonatomic) IBOutlet UIView *weatherView;

@property (weak, nonatomic) IBOutlet UIImageView *weatherImageOutlet;

@property (weak, nonatomic) IBOutlet UILabel *currentDateOutlet;


- (IBAction)refreshDataAction:(id)sender;


@end
