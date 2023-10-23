import Foundation

enum Skill {
    // Strength
    case athletics // Jump farther, stay afloat in water, break something

    // Dexterity
    case acrobatics // Balance, perform stunt
    case sleightOfHand // Pickpocket, conceal handheld object, perform legerdemain
    case stealth // Escape notice by moving silently and hiding

    // Intelligence
    case arcana // Recall spell lore, magic items, and planes of existence
    case history // Recall historical events, people, nations, and cultures
    case investigation // Find obscure info in books, deduce how something works
    case nature // Recall lore about terrain, plans, animals, and weather
    case religion // Recall lore of gods, rituals, and symbols

    // Wisdom
    case animalHandling // Intuit an animal's intuition, calm or train animal
    case insight // Discern a person's mood or intentions
    case medicine // Diagnose an illness, determine what killed recently slain
    case perception // Using combo of senses, notice something that's easy to miss
    case survival // Follow tracks, forage, navigate wilderness, or avoid natural hazards

    // Charisma
    case deception // Tell convincing lie or wear disguise convincingly
    case intimidation // Awe or threaten someone to do what you want
    case performance // Perform music, dance, acting, or storytelling
    case persuasion /// Honestly and graciously convince someone of something
}

func abilityForSkill(_ skill: Skill) -> Ability {
    switch skill {
    case .athletics:
        return .strength
    case .acrobatics,
         .sleightOfHand,
         .stealth:
        return .dexterity
    case .arcana,
         .history,
         .investigation,
         .nature,
         .religion:
        return .intelligence
    case .animalHandling,
         .insight,
         .medicine,
         .perception,
         .survival:
        return .wisdom
    case .deception,
         .intimidation,
         .performance,
         .persuasion:
        return .charisma
    }
}

// TODO: Saving throws appear as a value associated to a character for a specific Ability

// TODO: Equipment proficiency
