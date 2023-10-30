/// Copyright ⓒ 2023 Bithead LLC. All rights reserved.

/**
 Environment represents the stage `Creature`s play in.

 # Movement & Position

 Walking, running, jumping, climbing, and swimming. You can move up to your max speed. Your speed is deducted as you move.

 A Creature can have a walk and flying speed. A creature may switch between the two speeds.
 1 Speed = 1 Foot

 If one of these movement types is 0, the cost of movement is a rate of 2 speed for one foot (movement is halved) 2 Speed = 1 Foot
 - Climbing
 - Crawling
 - Swimming

 If a flying creature is restrained, and does not have the ability to hover, it will "fall." This may incur fall damage.

 Difficult terrain costs 3 speed for one foot. (? the rules aren't quite clear) In other contexts it says difficult terrain costs 1 extra foot.
 
 Difficult terrain can be considered:
 - Vines
 - Foes
 - Furniture
 - Etc.

 ## Jumping

 Long jump (horizontal) is feet equal to your Strength score
 High jump (vertical) 3+ your Strength modifier (not score)
 You must move at least 10ft before these distances can be jumped. If performing standing jump, these distances are halved.

 Jumping is deducted similarly to other movement types such as climbing, swimming, etc.

 Samples:
 - A harpy has a walking speed of 20, flying speed of 40
   Fly 10, Walk 10, Fly 20 more
   Walk 15, Fly 25 more
 - A badger has walking speed of 30, burrow of 10
   Walk 10, it can no longer burrow
   Burrow 10, Walk 20
 - A human has walking speed of 30, strength of 10
   Jump 10, Walk 20
   Walk 25, Jump 5

 Some surfaces may require a successful Strength (Athletics) check. For example, slippery surfaces or one with few handholds. A Cube should hold this information along with DC.
 
 Landing in difficult terrain, or jumping over a low wall (no taller than 1/4 of jump's distance), requires Strength (Athletics) check w/ DC 10. If difficult terrain, you land prone. If wall, you hit it.
 
 ## Being Prone
 
 You may drop prone without using any of your speed. Standing up costs an amount of movement equal to half your speed. e.g. If you have 30 speed, it will take 15 feet to stand up. You can't stand up if you less than half of your speed. You stay prone.
 
 ## Moving Around Creatures
 
 Creatures are considered difficult terrain if you attempt to move through them. You may only move through an enemy's space if they are twice as large or twice as small as you.
 
 You can't end your turn on a friend or foe's space.
 
 If you leave an enemy's reach, you provoke an opportunity attack.
 
 ## Flying
 
 If flying Creature is knocked prone, has its speed reduced to 0, or is otherwise deprived of the ability to move, the Creature falls unless it has the ability to hover or held aloft by magic. A Creature will take fall damage at this point, if any.
 
 ## Grappled
 
 If you are moving, while grappling a Creature, your movement is halved, unless Creature is 2 or more sizes smaller than you.
 */

import Foundation

/// Determines whether a space is obscured or not
enum Obscured {
    case no
    case lightly // Dim light, patchy fog, etc.
    case heavily // Darkness, opaque fog, dense foilage - Blocks vision within
}

/// The presence or absence of light
enum Light {
    case bright
    case dim
    case dark
}

// MARK: - Map

/**
 Below are very early ideas on how worlds/dungeons/rooms will be modeled. These will most likely change (drastically). This is to help support the idea of movement within the game.
 */

/// Represents an environmental "fixture" that a `Room.Cube` represents. Each type can have additional attributes. For example, a `floor` type may have water, blood, acid, etc. on it.
/// How to model moving bodies of water with depth? There could be a layer of cubes under the ground, and the body of water is carved from that ground. My guess is this is going to be modeled similar to something like Minecraft.
enum CubeType {
    /// This represents a "fixed" object on the ground. This can be a wall, ground (dirt under floor), boulder, etc. These can not be traversed unless the type of wall allows it to be scaled / burrowed / etc.
    case fill
    /// Any surface type. Wood, dirt, tile, rock, etc. Any surface that can be traversed by walking. This `case` _may_ be removed as the top of a `fill`ed cube could be considered a surface. However, it may be easier to designate which `fill`ed cubes are a surface. This would help identify the traversable boundaries of a map.
    /// A surface may designate if it can be burrowed under. Or, burrowing could be determined by the depth of the cube. Such that, if there is no "ground" (`fill`) under a `surface`, it can not be burrowed under.
    /// A surface may have a "thing" on it. e.g. Furniture, plants, trap, etc. that prevent movement or trigger events.
    case surface
    /// Represents any type of liquid including water, lava, etc.
    case liquid
    /// An empty space. Space can still have a poison cloud or "thing" within it that _may_ prevent movement.
    case empty
}

/// A "thing" may also be placed in a `Room.Cube`. Such as a treasure chest, furniture, painting (on wall), etc.

/// Represents a block of space within the wider world of a campaign. `Room`s will most likely be inside `Dungeon`s, `Dungeon`s inside a `WorldMap`. It's too early to tell. Again, this `Room` is a very simple, very incomplete, model of what a `Creature` can move through.
struct Room {
    /// Represents all properties that can be associated to a 3D cube within a map.
    /// A Cube represents a 1x1x1 ft cubed space.
    /// TBD `Thing`s may be placed on top or on any side of the `Cube`
    struct Cube {
        let obscured: Obscured
        let light: Light
        let type: CubeType
    }

    let width: Int // x
    let depth: Int // y
    let height: Int // z

    // The number of cubes is determined by x * y * z
    let cubes: [Cube]
}
