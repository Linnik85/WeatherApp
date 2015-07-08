//
//  WeatherViewController.m
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALWeatherViewController.h"
#import "ALWeatherModels.h"
#import "SVProgressHUD.h"
#import "ALWeatherItem.h"

#define ALERT(msg) {UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];[alert show];}

@interface ALWeatherViewController ()<ALWeatherModelsDelegate>

@property(strong, nonatomic) ALWeatherModels* weatherModel;

@property(strong, nonatomic) ALWeatherItem* weather;

@end

@implementation ALWeatherViewController


#pragma mark - Lifecycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.weatherModel = [[ALWeatherModels alloc]init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if ([userDefaults objectForKey:@"location"]) {
        
        [self.weatherModel getCurrentWeatherInCity:[userDefaults objectForKey:@"location"]];
        
    } else {
        
        [self.weatherModel getCurrentWeatherInCity:@"zaporozhye"];

    }
    
    
    [SVProgressHUD show];
    
    self.weatherModel.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateNotification)
                                                 name:@"udateUINotitfication"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateWeather:)
                                                 name:@"udateWeather"
                                               object:nil];
    
}


#pragma mark - ALWeatherModelsDelegate


-(void)getCurrentWeatherResponds:(ALWeatherItem *)weather{
    
    [SVProgressHUD dismiss];
    
    [self updateUI:weather];
    
    
}


-(void) getImageWeatherByIDResponds:(NSData*) weatherData{
    
    if (weatherData.length>0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.weatherImageOutlet.image = [UIImage imageWithData:weatherData];
        });
        
    }
}

-(void) errorRespondse:(NSString*) errorDescription{
    
    [SVProgressHUD dismiss];
    
    ALERT(errorDescription);

}


#pragma mark - Notification

-(void) updateNotification{
    
    [self updateUI:self.weather];
}


-(void) updateWeather: (NSNotification*) notification{
    
    if ([[notification object] isKindOfClass:[NSString class]]) {
        
        [self.weatherModel getCurrentWeatherInCity:[notification object]];

    }
}


#pragma mark - Privet Methods

-(void)updateUI:(ALWeatherItem*) weather {
    
    if (weather) {
        
        _weather = weather;
    }
    
    if (!self.weatherView.alpha == 0) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.weatherView.alpha = 0;
            
        } completion: ^(BOOL finished) {
            
            self.weatherView.hidden = finished;
            
        }];
        
    }
    
    NSString* tempCityAndCountryName = [NSString new];
    
    
    if (weather.cityName.length>0) {
        
        tempCityAndCountryName = [NSMutableString stringWithFormat:@"%@", weather.cityName];
    }
    
    if (weather.country.length>0) {
        
        tempCityAndCountryName = [tempCityAndCountryName stringByAppendingString:[NSMutableString stringWithFormat:@" (%@)", weather.country]];
    }
    
    if (tempCityAndCountryName.length>0) {
        
        self.cityAndCountryLabelOutlet.text = tempCityAndCountryName;
    }
    
    if (weather.temperature) {
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        NSNumber* currentFormatTemperture = nil;
                
        if (![userDefaults boolForKey:@"isCelsius"]){
            
            currentFormatTemperture =  @([weather.temperature floatValue] - 273.15);
            
        } else {
            
            currentFormatTemperture =  @([weather.temperature floatValue]);
            
        }
        
        
        self.temperatureLabelOutlet.text = [NSString stringWithFormat:@"%ld˚",(long)[currentFormatTemperture integerValue]];
    }
    
    if (weather.weatherDescription.length>0) {
        
        self.weatherDescriptionLabelOutlet.text = weather.weatherDescription;
        
    }
    
    if (weather.humidity) {
        
        self.humidityLabelOutlet.text = [NSString stringWithFormat:@"%@%%",weather.humidity];
    }
    
    if (weather.wind) {
        
        self.windLabelOutlet.text = [NSString stringWithFormat:@"%.1f m/s",[weather.wind floatValue]];
    }
    
    if (weather.pressure) {
        
        self.pressureLabelOutlet.text = [NSString stringWithFormat:@"%ld hPa",(long)[weather.pressure integerValue]];
    }
    
    if (weather.imagID.length>0) {
        
        [self.weatherModel getImageWeatherByID:weather.imagID];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = @"d MMM";
    
    self.currentDateOutlet.text = [formatter stringFromDate:[NSDate date]];
    
    self.weatherView.alpha = 0;
    
    self.weatherView.hidden = NO;
    
    [UIView animateWithDuration:0.6 animations:^{
        
        self.weatherView.alpha = 1;
        
    }];
    
}


#pragma mark - Actions


- (IBAction)refreshDataAction:(id)sender{
    
    [SVProgressHUD show];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if ([userDefaults objectForKey:@"location"]) {
        
        [self.weatherModel getCurrentWeatherInCity:[userDefaults objectForKey:@"location"]];
        
    } else {
        
        [self.weatherModel getCurrentWeatherInCity:@"zaporozhye"];
        
    }

    
    [UIView animateWithDuration:0.3 animations:^{
        
     self.weatherView.alpha = 0;
     
     } completion: ^(BOOL finished) {
     
     self.weatherView.hidden = finished;
         
     }];
    
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"udateUINotitfication" object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"udateWeather" object:nil];

}


@end
