//
//  ViewController.m
//  MB
//
//  Created by Jesus Antonio Hernandez Mendez on 31/03/15.
//  Copyright (c) 2015 BTICs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnReto:(id)sender {
    [self performSegueWithIdentifier:@"Reto" sender:self];
}
@end
