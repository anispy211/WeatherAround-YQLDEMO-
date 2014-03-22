//
//  ForecastModel.h
//  YqlDemo
//
//  Created by Aniruddha  on 12/03/14.
//  Copyright (c) 2014 aniruddha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForecastModel : NSObject
//"forecast":[
//            //    {
//            //        "code":"11",
//            //        "date":"11 Mar 2014",
//            //        "day":"Tue",
//            //        "high":"69",
//            //        "low":"62",
//            //        "text":"Showers"
//

@property (nonatomic, strong) NSString * code;
@property (nonatomic, strong) NSDictionary * date;
@property (nonatomic, strong) NSDictionary * day;
@property (nonatomic, strong) NSString * high;
@property (nonatomic, strong) NSString * low;
@property (nonatomic, strong) NSDictionary * text;



@end
