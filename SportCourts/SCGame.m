//
//  SCUser.m
//  SportCourtsApi
//
//  Created by Vitaliy Harchenko on 05.01.15.
//  Copyright (c) 2015 Vitaliy Harchenko. All rights reserved.
//

#import "SCGame.h"

@implementation SCGame

+ (SCGame *)parseGameFromDictionary:(NSDictionary *)gameDict {
    
    SCGame *game = [[SCGame alloc] init];
    game.gameDescription = [gameDict objectForKey:@"description"];

    return game;
}

+ (NSMutableArray *)gamesArrayFromDictionary:(NSArray *)games {
    
    NSMutableArray *gamesArray = [[NSMutableArray alloc] init];
    
    NSInteger i;
    for (i=0; i<games.count; i++) {
        NSDictionary *gameDict = [games objectAtIndex:i];
        SCGame *gameRow = [SCGame parseGameFromDictionary:gameDict];
        [gamesArray addObject:gameRow];
    }
    return gamesArray;
}

@end
