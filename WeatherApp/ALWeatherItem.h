//
//  ALWeathrItem.h
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALWeatherItem : NSObject

@property(strong, nonatomic) NSString* cityName;

@property(strong, nonatomic) NSString* country;

@property(strong, nonatomic) NSNumber* temperature;

@property(strong, nonatomic) NSString* weatherDescription;

@property(strong, nonatomic) NSNumber* humidity;

@property(strong, nonatomic) NSNumber* wind;

@property(strong, nonatomic) NSNumber* pressure;

@property(strong, nonatomic) NSString* imagID;


- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
