//
//  Home.m
//  MB
//
//  Created by Jesus Antonio Hernandez Mendez on 01/04/15.
//  Copyright (c) 2015 BTICs. All rights reserved.
//

#import "Home.h"
#import "SWRevealViewController.h"
#import "VariablesGlobales.h"
#import <Parse/Parse.h>


@interface Home ()

@end

@implementation Home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.btnMenu setTarget: self.revealViewController];
        [self.btnMenu setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    

    
    
    PFQuery *query = [PFQuery queryWithClassName:@"MedicalBariatric"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *persona, NSError *error) {
        // code
        
        NSNumber *estatura = [persona objectForKey:@"Estatura"];
        NSNumber *peso = [persona objectForKey:@"Peso"];
        NSNumber *pi = [persona objectForKey:@"PesoIdeal"];
        NSNumber *imc = [persona objectForKey:@"IMC"];
        
        
        self.lblNombre.text = persona[@"Nombre"];
        self.lblEstatura.text = [estatura stringValue];
        self.lblPeso.text = [peso stringValue];
        self.lblPesoIdeal.text = [pi stringValue];
        self.lblIMC.text = [imc stringValue];
    }];
    
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnEdit:(id)sender {
    [self performSegueWithIdentifier:@"sw_Edit" sender:self];
}
@end
