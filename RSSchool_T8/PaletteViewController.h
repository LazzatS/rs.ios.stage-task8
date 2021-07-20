//
//  PaletteViewController.h
//  RSSchool_T8
//
//  Created by Lazzat Seiilova on 20.07.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ColorSelectionDelegate <NSObject>
-(void) didChooseColor:(NSString *)colorName;
@end

@interface PaletteViewController : UIViewController
@property (nonatomic, weak) id <ColorSelectionDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
