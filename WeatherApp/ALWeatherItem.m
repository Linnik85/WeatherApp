//
//  ALWeathrItem.m
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALWeatherItem.h"

@implementation ALWeatherItem

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super init];
    
    if (self) {
        
        if ([responseObject objectForKey:@"name"]) {
            
            self.cityName =[responseObject objectForKey:@"name"];
        }
        
        if ([responseObject objectForKey:@"sys"]) {
            
            NSDictionary* sys =[responseObject objectForKey:@"sys"];
            
            if ([sys objectForKey:@"country"]) {
                
                self.country = [sys objectForKey:@"country"];
            }
        }
        
        if ([responseObject objectForKey:@"main"]) {
            
            NSDictionary* main = [responseObject objectForKey:@"main"];
            
            if ([main objectForKey:@"temp"]) {
                self.temperature = [main objectForKey:@"temp"];
            }
            
            if ([main objectForKey:@"humidity"]) {
                
                self.humidity = [main objectForKey:@"humidity"];
            }
            
            if ([main objectForKey:@"pressure"]) {
                
                self.pressure = [main objectForKey:@"pressure"];
            }

        }
        
        if ([responseObject objectForKey:@"wind"]) {
            
            NSDictionary* wind =[responseObject objectForKey:@"wind"];
            
            if ([wind objectForKey:@"speed"]) {
                
                self.wind = [wind objectForKey:@"speed"];
            }
        }
        
        if ([responseObject objectForKey:@"weather"]) {
            
            NSArray* weather = [responseObject objectForKey:@"weather"];
            
            for (NSDictionary* dict in weather) {
                
                if ([dict objectForKey:@"description"]) {
                    
                    self.weatherDescription = [dict objectForKey:@"description"];
                }
                
                if ([dict objectForKey:@"icon"]) {
                    
                    self.imagID = [dict objectForKey:@"icon"];
                }
            }
        }
        
        
        
    }
    
    return self;
}

@end
