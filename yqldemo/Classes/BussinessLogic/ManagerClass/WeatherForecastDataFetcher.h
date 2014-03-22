//
//  WeatherForecastDataFetcher.h
//  WeatherAround
//
//  Created by Aniruddha  on 25/01/14.
//  Copyright (c) 2014 @nispy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@protocol WeatherForecastDataFetcherDelegate <NSObject>

- (void) setCityWeatherInfo:(CityModel *) cityM;
- (void) errorNotification:(NSString*)errorMsg;

@end

@interface WeatherForecastDataFetcher : NSObject<NSURLConnectionDelegate>
{
    NSURLConnection * connection;
    
}
@property (strong, nonatomic) NSMutableData *responseData;
@property (nonatomic, assign) BOOL isDownloading;
@property (nonatomic, unsafe_unretained) id <WeatherForecastDataFetcherDelegate> delegate;

- (void)getWeatherHistoryForCity:(NSString *)cityName;
@end
