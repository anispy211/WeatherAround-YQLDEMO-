//
//  WeatherForecastDataFetcher.m
//  WeatherAround
//
//  Created by Aniruddha  on 25/01/14.
//  Copyright (c) 2014 @nispy. All rights reserved.
//

#import "WeatherForecastDataFetcher.h"



@implementation WeatherForecastDataFetcher



// Request API Method
- (void)getWeatherHistoryForCity:(NSString *)cityName
{

    NSString * statement = [NSString stringWithFormat:@"SELECT * FROM weather.bylocation WHERE location='%@'",cityName];
    
    NSString *query = [NSString stringWithFormat:@"%@%@%@", YQLQUERY_PREFIX, [statement stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], YQLQUERY_SUFFIX];

    self.responseData = [NSMutableData data];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:query]];
    id connec= [[NSURLConnection alloc] initWithRequest:request delegate:self];
    connec = nil;

}


#pragma - mark  NSURl Connection Delegates

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (_isDownloading) {
        [_responseData appendData:data];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:@"Network Failed To Respond" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    [alertView show];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if (_isDownloading) {
        @try {
        NSArray *JsonArray = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableContainers error:nil];
            
            CityModel * cityM = [[CityModel alloc] init];
            
                  
            NSDictionary * queeryDict = [JsonArray valueForKey:@"query"];
            NSDictionary * resultsDict = [queeryDict valueForKey:@"results"];
            NSDictionary * weatherDict = [resultsDict valueForKey:@"weather"];

            NSDictionary * rssDict = [weatherDict valueForKey:@"rss"];
            NSDictionary * channelDict = [rssDict valueForKey:@"channel"];
            NSDictionary * itemDict = [channelDict valueForKey:@"item"];

            
            cityM.items_Title = [itemDict valueForKey:@"title"];
            cityM.cityName = [[channelDict valueForKey:@"location"] valueForKey:@"city"];
            cityM.mainDict = [itemDict valueForKey:@"condition"];
            cityM.itemsDict = [itemDict valueForKey:@"lat"];
            cityM.items_Lat = [itemDict valueForKey:@"item"];
            cityM.items_Long = [itemDict valueForKey:@"long"];
            cityM.items_pubDate = [itemDict valueForKey:@"pubDate"];
            cityM.items_Condition_Dict = [itemDict valueForKey:@"condition"];
            cityM.items_Forecast_Array = [itemDict valueForKey:@"forecast"];


            
            if (cityM) {
                
                if ([_delegate respondsToSelector:@selector(setCityWeatherInfo:)]) {
                    
                    [_delegate setCityWeatherInfo:cityM];
                }
                
            }

            
        }
            @catch (NSException* e) {
                
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error!" message:@"Network Failed To Respond" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alertView show];
//                if ([cartDelegate respondsToSelector:@selector(cartEmptyErroMsg:)]) {
//                    [cartDelegate cartEmptyErroMsg:@"error"];
//                }
            }
            
        }
}


@end
