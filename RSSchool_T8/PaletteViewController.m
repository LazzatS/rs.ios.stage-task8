//
//  PaletteViewController.m
//  RSSchool_T8
//
//  Created by Lazzat Seiilova on 20.07.2021.
//

#import "PaletteViewController.h"

@class MainViewController;

@interface PaletteViewController ()
@property (nonatomic, strong) MainViewController *mainVC;
@property (nonatomic, strong) PaletteViewController *paletteVC;
@property (nonatomic, strong) NSArray *palette;
@property (nonatomic, strong) NSMutableArray *paletteChosen;
@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self chooseColors];
    
    [self createSaveButton];
    
}

- (UIButton *) createPaletteButton:(NSString *)buttonColor atX:(CGFloat)x Y:(CGFloat)y withWidth:(CGFloat)width withHeight:(CGFloat)height {
    UIButton *buttonStyle = [[UIButton alloc] initWithFrame:CGRectMake(x, y, width, height)];
    [buttonStyle setTitle:buttonColor forState:UIControlStateNormal];
    [buttonStyle setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
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

- (NSArray *) createPalette {
    
    UIButton *paletteRed = [self createPaletteButton:@"PaletteRed" atX:25 Y:433 withWidth:24 withHeight:24];
    UIButton *paletteDarkPurple = [self createPaletteButton:@"PaletteDarkPurple" atX:85 Y:433 withWidth:24 withHeight:24];
    UIButton *paletteGreen = [self createPaletteButton:@"PaletteGreen" atX:145 Y:433 withWidth:24 withHeight:24];
    UIButton *paletteGray = [self createPaletteButton:@"PaletteGray" atX:205 Y:433 withWidth:24 withHeight:24];
    UIButton *paletteLightPurple = [self createPaletteButton:@"PaletteLightPurple" atX:265 Y:433 withWidth:24 withHeight:24];
    UIButton *palettePeach = [self createPaletteButton:@"PalettePeach" atX:325 Y:433 withWidth:24 withHeight:24];
    UIButton *paletteOrange = [self createPaletteButton:@"PaletteOrange" atX:25 Y:493 withWidth:24 withHeight:24];
    UIButton *paletteBlue = [self createPaletteButton:@"PaletteBlue" atX:85 Y:493 withWidth:24 withHeight:24];
    UIButton *palettePink = [self createPaletteButton:@"PalettePink" atX:145 Y:493 withWidth:24 withHeight:24];
    UIButton *paletteDark = [self createPaletteButton:@"PaletteDark" atX:205 Y:493 withWidth:24 withHeight:24];
    UIButton *paletteDarkGreen = [self createPaletteButton:@"PaletteDarkGreen" atX:265 Y:493 withWidth:24 withHeight:24];
    UIButton *paletteCherry = [self createPaletteButton:@"PaletteCherry" atX:325 Y:493 withWidth:24 withHeight:24];
    
    NSArray *paletteButtons = [[NSArray alloc] initWithObjects:paletteRed,paletteDarkPurple,paletteGreen,paletteGray,paletteLightPurple,palettePeach,paletteOrange,paletteBlue,palettePink,paletteDark,paletteDarkGreen,paletteCherry, nil];
    
    return paletteButtons;
}

- (void) chooseColors {
    _palette = [self createPalette];
    
    for (int color = 0; color < _palette.count; color++) {
        [_palette[color] addTarget:self action:@selector(appendColor:) forControlEvents:UIControlEventTouchUpInside];
    }
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
    NSLog(@"save button palette tapped %@", _paletteChosen);
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)appendColor:(UIButton *)sender {
    UIButton *btn = [[UIButton alloc] init];
    NSString *str = [[NSString alloc] init];
    btn = sender;
    str = btn.titleLabel.text;
    [_paletteChosen addObject:str];
    NSLog(@"chosen color is %@", str);
    
    [self.delegate didChooseColor:str];
}

@end
