//
//  BGMPhysicsCategories.h
//  SpriteKit Test
//
//  Created by 馬 岩 on 14-7-2.
//  Copyright (c) 2014年 馬 岩. All rights reserved.
//

#ifndef SpriteKit_Test_BGMPhysicsCategories_h
#define SpriteKit_Test_BGMPhysicsCategories_h

typedef NS_OPTIONS(uint32_t, BIDPhysicsCategory)
{
    PlayerCategory        =  1 << 1,
    EnemyCategory         =  1 << 2,
    PlayerMissileCategory =  1 << 3
};

#endif
