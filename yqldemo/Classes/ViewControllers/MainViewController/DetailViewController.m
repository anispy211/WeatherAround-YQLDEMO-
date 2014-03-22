//
//  DetailViewController.m
//  YqlDemo
//
//  Created by Aniruddha  on 12/03/14.
//  Copyright (c) 2014 aniruddha. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (_dataArr) {
        
            [detailTableView reloadData];
    }
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    
    
    if (_dataArr) {
  
    
    CityModel * cityM = (CityModel *) _dataArr;
        
        if (indexPath.row == 0)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Title:"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",cityM.items_Title];
        }
  
        if (indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Date:"];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",cityM.items_pubDate];
        }
        
        if (indexPath.row == 2)
            cell.textLabel.text = [NSString stringWithFormat:@"Temperature: %@",[cityM.items_Condition_Dict valueForKey:@"temp"]];
        
        if (indexPath.row == 3)
            cell.textLabel.text = [NSString stringWithFormat:@"Desc: %@",[cityM.items_Condition_Dict valueForKey:@"text"]];
        
        
        if (indexPath.row == 4)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"Forecast"];
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:19]];
        }
        
        
        if (indexPath.row == 5)
        {
            
            NSDictionary * forecast  = [cityM.items_Forecast_Array objectAtIndex:0];
            
            NSDate * date = [forecast valueForKey:@"date"];
            
            cell.textLabel.text = [NSString stringWithFormat:@"  Date: %@ ",date];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"  Desc: %@",[forecast valueForKey:@"text"]];

        }
        
        if (indexPath.row == 6)
        {
            
        
            NSDictionary * forecast  = [cityM.items_Forecast_Array objectAtIndex:1];
            
            NSDate * date = [forecast valueForKey:@"date"];
            
            cell.textLabel.text = [NSString stringWithFormat:@"  Date: %@ ",date];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"  Desc: %@",[forecast valueForKey:@"text"]];
        }
        
        if (indexPath.row == 7)
        {
            NSDictionary * forecast  = [cityM.items_Forecast_Array objectAtIndex:2];
            
            NSDate * date = [forecast valueForKey:@"date"];
            
            cell.textLabel.text = [NSString stringWithFormat:@"  Date: %@ ",date];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"  Desc: %@",[forecast valueForKey:@"text"]];
        }
   
    
    }
    
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 50;
    }
    
    return 35;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
