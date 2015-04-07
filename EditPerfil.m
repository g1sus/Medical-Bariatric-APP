//
//  EditPerfil.m
//  MB
//
//  Created by Jesus Antonio Hernandez Mendez on 02/04/15.
//  Copyright (c) 2015 BTICs. All rights reserved.
//

#import "EditPerfil.h"
#import <Parse/Parse.h>
#import "VariablesGlobales.h"

UIImage *chosenImage;
UIAlertView *alert;

@interface EditPerfil ()

@end

@implementation EditPerfil

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Parse
    //PFObject *testObject = [PFObject objectWithClassName:@"MedicalBariatric"];
    //testObject[@"Nombre"] = @"bar";
    //[testObject saveInBackground];
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

- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)btnGuardar:(id)sender {
    //Agregar datos en parse desde Editar Perfil
    
    if ([self.txtNombre.text isEqualToString:@""] || [self.txtFechaNac.text isEqualToString:@""] || [self.txtPeso.text isEqualToString:@""] || [self.txtEstatura.text isEqualToString:@""]|| [self.txtMovil.text isEqualToString:@""] || [self.txtMail.text isEqualToString:@""])
    {
        
        NSLog(@"Campos Obligatorios");
        
    }else{
        //Formateador para crear numeros desde un NSString
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        
        //Crear variables y asignar valor desde el formateador (f)
        NSNumber *Peso = [f numberFromString:self.txtPeso.text];
        NSNumber *Estatura = [f numberFromString:self.txtEstatura.text];
        
        float IMC = 10000 * (Peso.floatValue / (Estatura.floatValue * Estatura.floatValue));
        float PesoI = (0.75 * (Estatura.floatValue - 150))+50;
        
        
        PFObject *objTemp = [PFObject objectWithClassName:@"MedicalBariatric"];
        objTemp[@"Nombre"] = self.txtNombre.text;
        objTemp[@"FechaNacimiento"] = self.txtFechaNac.text;
        objTemp[@"Peso"] = Peso;
        objTemp[@"Estatura"] = Estatura;
        objTemp[@"IMC"] = [NSNumber numberWithFloat:IMC];
        objTemp[@"Movil"] = self.txtMovil.text;
        objTemp[@"Mail"] = self.txtMail.text;
        objTemp[@"PesoIdeal"] = [NSNumber numberWithFloat:PesoI];
        
        NSData *imageData = UIImagePNGRepresentation(chosenImage);
        PFFile *imageFile = [PFFile fileWithName:@"imageMB.png" data:imageData];
        objTemp[@"imgPicture"] = imageFile;
        
        
        
        [objTemp saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
         {
             NSLog(@"id Parse %@", objTemp.objectId);
             iniciado = 1;
             id_parse_com = objTemp.objectId;
             
             alert = [[UIAlertView alloc] initWithTitle:@"!!!Gracias!!!"
                                                message:@"No Olvides Actualizar Tus Datos Cada Semana!!!"
                                               delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles: nil];
             [alert show];
             
             self.txtNombre.text = nil;
             self.txtFechaNac.text = nil;
             self.txtPeso.text = nil;
             self.txtEstatura.text = nil;
             self.txtMovil.text = nil;
             self.txtMail.text = nil;
             self.imgPicture = nil;
             
             [self performSegueWithIdentifier:@"EditToMenu" sender:self];
         }];
        
    }
    
}

- (IBAction)btnCamara:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fotografia"
                                                    message:@"Elegir fotografía de"
                                                   delegate:self
                                          cancelButtonTitle:@"Cancelar"
                                          otherButtonTitles:@"Camara", @"Carrete", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if(buttonIndex == 0)
    {
        NSLog(@"Cancelar");
    }
    else if(buttonIndex == 1)
    {
        NSLog(@"Camara");
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if(buttonIndex == 2)
    {
        NSLog(@"Carrete");
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    chosenImage = info[UIImagePickerControllerEditedImage];
    self.imgPicture.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

@end
