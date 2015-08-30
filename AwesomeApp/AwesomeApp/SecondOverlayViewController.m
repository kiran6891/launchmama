//
//  SecondOverlayViewController.m
//  AwesomeApp
//
//  Created by Kiran Ruth on 29/08/15.
//  Copyright (c) 2015 Kiran Ruth. All rights reserved.
//

#import "SecondOverlayViewController.h"

@interface SecondOverlayViewController ()

@end

@implementation SecondOverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.layer.cornerRadius = 20.0f;
    UILabel *desc  = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width/2, 30)];
    desc.text = @"Terms & conditions";
    desc.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25.0f];
    desc.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:desc];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width/2+35, 3)];
    line.backgroundColor = [UIColor greenColor];
    [self.view addSubview:line];
    
    UILabel *tos  = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, self.view.frame.size.width/2, 430)];
    tos.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit.Curabitur laoreet, arcu vel feugiat hendrerit, leo diam scelerisque arcu, eget lobortis dolor dui quis tellus. Nam vestibulum lacus ut felis tincidunt efficitur. Vivamus fringilla risus et massa lobortis, eget efficitur massa luctus. \n\n\n  Maecenas posuere, magna eu feugiat varius, metus magna suscipit felis, quis placerat tortor urna a augue. Donec posuere felis tortor, id venenatis lorem facilisis id. Integer rhoncus, massa vitae blandit condimentum, quam felis tempus nulla, sollicitudin convallis ligula orci sit amet enim. Aenean suscipit bibendum urna quis fermentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. \n\n  Cras tincidunt at nunc sed mattis. Donec mattis, diam quis tristique tempor, erat nibh euismod est, sit amet iaculis mi lacus at enim. Nulla faucibus turpis commodo felis dapibus, sed tempor neque pellentesque. Sed at orci at velit tempus suscipit vitae in mi. \n\n  Pellentesque fermentum pulvinar tortor, rhoncus varius nunc sagittis ut. \n\n  Nullam auctor efficitur tortor, eu ornare ipsum dignissim vel.";
    tos.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    tos.numberOfLines = 0;
    [self.view addSubview:tos];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
