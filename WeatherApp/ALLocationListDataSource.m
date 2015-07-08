//
//  ALLocationListDataSource.m
//  WeatherApp
//
//  Created by Линник Александр on 05.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import "ALLocationListDataSource.h"

#define kCountriesFileName @"city.list.json"

@interface ALLocationListDataSource () {
    
    NSArray *locationList;
}

@end

@implementation ALLocationListDataSource


- (id)init {
    
    self = [super init];
    
    if (self) {
        
        [self parseJSON];
    }
    
    return self;
}

- (void)parseJSON {
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"]];
    
    NSError *localError = nil;
    
    NSArray *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        
        NSLog(@"%@", [localError userInfo]);
        
    }
    
    locationList = (NSArray *)parsedObject;
}

- (NSArray *)locations{
    
    return locationList;
}

@end
