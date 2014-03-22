//
//  CityModel.h
//  WeatherAround
//
//  Created by Aniruddha  on 27/01/14.
//  Copyright (c) 2014 @nispy. All rights reserved.
//

#import <Foundation/Foundation.h>
//"item":{
//    "title":"Conditions for Johannesburg, ZA at 2:00 am SAST",
//    "lat":"-26.2",
//    "long":"28.04",
//    "link":"http://us.rd.yahoo.com/dailynews/rss/weather/Johannesburg__ZA/*http://weather.yahoo.com/forecast/SFXX0023_f.html",
//    "pubDate":"Wed, 12 Mar 2014 2:00 am SAST",
//    "condition":{
//        "code":"11",
//        "date":"Wed, 12 Mar 2014 2:00 am SAST",
//        "temp":"61",
//        "text":"Light Rain"
//    },
//    "description":"<img src=\"http://l.yimg.com/a/i/us/we/52/11.gif\"/><br />\n<b>Current Conditions:</b><br />\nLight Rain, 61 F<BR />\n<BR /><b>Forecast:</b><BR />\nTue - Showers. High: 69 Low: 62<br />\nWed - Showers. High: 72 Low: 57<br />\nThu - Showers. High: 64 Low: 56<br />\nFri - AM Showers. High: 68 Low: 57<br />\nSat - Scattered Showers. High: 74 Low: 60<br />\n<br />\n<a href=\"http://us.rd.yahoo.com/dailynews/rss/weather/Johannesburg__ZA/*http://weather.yahoo.com/forecast/SFXX0023_f.html\">Full Forecast at Yahoo! Weather</a><BR/><BR/>\n(provided by <a href=\"http://www.weather.com\" >The Weather Channel</a>)<br/>",
//    "forecast":[
//    {
//        "code":"11",
//        "date":"11 Mar 2014",
//        "day":"Tue",
//        "high":"69",
//        "low":"62",
//        "text":"Showers"
//    },
//    {
//        "code":"11",
//        "date":"12 Mar 2014",
//        "day":"Wed",
//        "high":"72",
//        "low":"57",
//        "text":"Showers"
//    },
//    {
//        "code":"11",
//        "date":"13 Mar 2014",
//        "day":"Thu",
//        "high":"64",
//        "low":"56",
//        "text":"Showers"
//    },
//    {
//        "code":"39",
//        "date":"14 Mar 2014",
//        "day":"Fri",
//        "high":"68",
//        "low":"57",
//        "text":"AM Showers"
//    },
//    {
//        "code":"39",
//        "date":"15 Mar 2014",
//        "day":"Sat",
//        "high":"74",
//        "low":"60",
//        "text":"Scattered Showers"
//    }
//                ],



@interface CityModel : NSObject
@property (nonatomic, strong) NSString* cityName;

@property (nonatomic, strong) NSDictionary * mainDict;
@property (nonatomic, strong) NSDictionary * itemsDict;
@property (nonatomic, strong) NSString * items_Title;

@property (nonatomic, strong) NSString * items_Lat;
@property (nonatomic, strong) NSString * items_Long;
@property (nonatomic, strong) NSString * items_pubDate;
@property (nonatomic, strong) NSDictionary * items_Condition_Dict;


@property (nonatomic, strong) NSArray * items_Forecast_Array;


//@property (nonatomic, assign) NSArray * weatherArr;


@end
