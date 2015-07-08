//
//  ALLocationListDataSource.h
//  WeatherApp
//
//  Created by Линник Александр on 05.07.15.
//  Copyright (c) 2015 Alex Linnik. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCountryName        @"name"
#define kCountryCallingCode @"country"

@interface ALLocationListDataSource : NSObject

- (NSArray *)locations;


@end
