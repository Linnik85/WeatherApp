//
//  ALWeatherModels.h
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ALWeatherItem;


@protocol ALWeatherModelsDelegate <NSObject>

@optional


-(void) getCurrentWeatherResponds:(ALWeatherItem*) weather;

-(void) getImageWeatherByIDResponds:(NSData*) weatherData;

-(void) errorRespondse:(NSString*) errorDescription;


@end



@interface ALWeatherModels : NSObject

@property (nonatomic, weak) id < ALWeatherModelsDelegate > delegate;


-(void)getCurrentWeatherInCity:(NSString*)city;

-(void)getImageWeatherByID:(NSString*)ID;

@end
