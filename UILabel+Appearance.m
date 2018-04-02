//
//  UILabel+Appearance.m
//  UILabel+Appearance
//
//  Created by Ryder Mackay on 2013-06-04.
//  Copyright (c) 2013 Ryder Mackay. All rights reserved.
//

#import "UILabel+Appearance.h"

@implementation UILabel (FontAppearance)

-(void)setAppearanceAlignment:(NSTextAlignment)alignment {
    [self setTextAlignment:alignment];
}

-(NSTextAlignment)appearanceAlignment {
    return self.textAlignment;
}

@end