//
//  APPViewController.m
//  PageApp
//
//  Created by Rafael Garcia Leiva on 10/06/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "APPViewController.h"
#import "FIrstOverlayViewController.h"
#import "SecondOverlayViewController.h"

@interface APPViewController ()

@end

@implementation APPViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view setAlpha:0.4f];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.view.backgroundColor = [UIColor clearColor];
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:CGRectMake(20, 40, self.view.frame.size.width-40, self.view.frame.size.height-60)];
    
    FIrstOverlayViewController *initialViewController = [[FIrstOverlayViewController alloc] init];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-35, 10, 25, 25)];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f];
    label.text = @"X";
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = YES;
    [self.view addSubview:label];
    
UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOnTapClose:)];
    [label addGestureRecognizer:tapClose];
    
    
}

- (void)handleOnTapClose:(UITapGestureRecognizer *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
//
//- (APPChildViewController *)viewControllerAtIndex:(NSUInteger)index {
//    APPChildViewController *childViewController = [[APPChildViewController alloc] init];
//    childViewController.view.backgroundColor = [UIColor whiteColor];
//    [childViewController.view setAlpha:0.9f];
//    childViewController.position = index;
//    return childViewController;
//    
//}


-(FIrstOverlayViewController *)createFirst{
    FIrstOverlayViewController *firstOverlay = [[FIrstOverlayViewController alloc] init];
    return firstOverlay;
}

-(SecondOverlayViewController *)createSecond{
    SecondOverlayViewController *secondOverlay = [[SecondOverlayViewController alloc] init];
    return secondOverlay;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    if ([viewController isKindOfClass:[FIrstOverlayViewController class]]) {
        return nil;
    }else{
        return [self createFirst];
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[SecondOverlayViewController class]]) {
        return nil;
    }else{
        return [self createSecond];
    }
    return nil;
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

@end
