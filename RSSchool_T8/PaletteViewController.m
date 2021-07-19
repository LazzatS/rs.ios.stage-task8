//
//  PaletteViewController.m
//  RSSchool_T8
//
//  Created by Lazzat Seiilova on 20.07.2021.
//

#import "PaletteViewController.h"

@interface PaletteViewController ()
@property (nonatomic,strong) PaletteViewController *paletteVC;
@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createPaletteButton:@"PaletteRed" atX:25 Y:433 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PaletteDarkPurple" atX:85 Y:433 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PaletteGreen" atX:145 Y:433 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PaletteGray" atX:205 Y:433 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PaletteLightPurple" atX:265 Y:433 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PalettePeach" atX:325 Y:433 withWidth:24 withHeight:24];
    
    [self createPaletteButton:@"PaletteOrange" atX:25 Y:493 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PaletteBlue" atX:85 Y:493 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PalettePink" atX:145 Y:493 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PaletteDark" atX:205 Y:493 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PaletteDarkGreen" atX:265 Y:493 withWidth:24 withHeight:24];
    [self createPaletteButton:@"PaletteCherry" atX:325 Y:493 withWidth:24 withHeight:24];
    
    [self createSaveButton];
    
}

- (UIButton *) createPaletteButton:(NSString *)buttonColor atX:(CGFloat)x Y:(CGFloat)y withWidth:(CGFloat)width withHeight:(CGFloat)height {
    UIButton *buttonStyle = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    buttonStyle.layer.borderWidth = 1;
    buttonStyle.layer.borderColor = [[UIColor whiteColor] CGColor];
    buttonStyle.layer.cornerRadius = 10;
    buttonStyle.layer.shadowRadius = 2;
    buttonStyle.layer.shadowPath = [UIBezierPath bezierPathWithRect:buttonStyle.bounds].CGPath;
    buttonStyle.layer.shadowColor = [[UIColor colorNamed:@"BlackOpaque"] CGColor];
    buttonStyle.backgroundColor = [UIColor colorNamed:buttonColor];
    
    [self.view addSubview:buttonStyle];
    return buttonStyle;
}

- (UIButton *) createSaveButton {
    UIButton *saveButton = [[UIButton alloc] init];
    [saveButton setTitle:@"Save" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorNamed:@"CustomGreenish"] forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:18];
    saveButton.frame = CGRectMake(250, 370, 85, 32);
    saveButton.layer.cornerRadius = 10;
    saveButton.layer.borderWidth = 1;
    saveButton.layer.shadowRadius = 2;
    saveButton.layer.shadowColor = [UIColor colorNamed:@"BlackOpaque"].CGColor;
    saveButton.layer.borderColor = [UIColor colorNamed:@"BlackOpaque"].CGColor;
    [saveButton addTarget:self action:@selector(saveButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
    return saveButton;
}

- (IBAction)saveButtonTapped:(id)sender {
    NSLog(@"save button palette tapped");
}

@end
