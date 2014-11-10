//
//  Constants.h
//  CoinVortex
//
//  Created by Andrew Erickson on 2014-11-09.
//  Copyright (c) 2014 Andrew Erickson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS (NSUInteger, GameSpriteCategory) {
	GameSpriteCategoryAll,
	GameSpriteCategoryGravityField,
	GameSpriteCategoryCoin,
	GameSpriteCategoryCollector,
	GameSpriteCategoryBounds
};

@interface Constants : NSObject

@end
