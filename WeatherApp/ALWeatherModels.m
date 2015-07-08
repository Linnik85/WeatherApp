//
//  ALWeatherModels.m
//  WeatherApp
//
//  Created by Линник Александр on 04.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALWeatherModels.h"
#import "ALServerManager.h"
#import "ALWeatherItem.h"


@interface ALWeatherModels ()


@property(strong,nonatomic) ALServerManager* serverManager;

@property(strong,nonatomic) NSArray *paths;

@property(strong,nonatomic) NSString *documentsDirectory;

@property(strong,nonatomic) NSString *path;

@property(strong,nonatomic) NSFileManager *fileManager;

@end


@implementation ALWeatherModels

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.serverManager = [ALServerManager sharedManager];
        
    }
    
    return self;
}


-(void)getCurrentWeatherInCity:(NSString*)city{
    
    [self.serverManager getCurrentWeather:city
                                OnSuccess:^(NSDictionary *respondsValue) {
                                 
                                    ALWeatherItem* weather = [[ALWeatherItem alloc]initWithServerResponse:respondsValue];
                                    
                                    if ([self.delegate respondsToSelector:@selector(getCurrentWeatherResponds:)]) {
                                        
                                        [self.delegate getCurrentWeatherResponds:weather];
                                        
                                    }
                                    
                                }
                                onFailure:^(NSError *error, NSInteger statusCode) {
                                    
                                    NSString* errorDescription = [NSString stringWithFormat:@"%@", [error localizedDescription]];
                                    
                                    if ([self.delegate respondsToSelector:@selector(errorRespondse:)]) {
                                        
                                        [self.delegate errorRespondse:errorDescription];
                                        
                                    }
                                    
                                }];
    
}


-(void)getImageWeatherByID:(NSString*)ID{
    
    [self.serverManager imageDownload:ID
                            onSuccess:^(id imgData) {
                                
                                if ([self.delegate respondsToSelector:@selector(getImageWeatherByIDResponds:)]){
                                    
                                    [self.delegate getImageWeatherByIDResponds:imgData];
                                }
                                
                            }
                            onFailure:^(NSError *error, NSInteger statusCode) {
                                
                                NSString* errorDescription = [NSString stringWithFormat:@"%@", [error localizedDescription]];
                                
                                if ([self.delegate respondsToSelector:@selector(errorRespondse:)]) {
                                    
                                    [self.delegate errorRespondse:errorDescription];
                                    
                                }

                            }];
}


@end
