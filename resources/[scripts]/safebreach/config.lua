Config = {}

Config.SafeCooldown = 600 -- This is the cooldown to be able to breach the same again, this will also close the door if still open.

Config.RandomCashReward = { 2500, 4500 } -- This is the reward for each cashpile, will be randomized { value1 | value2 }

Config.TotalLocks = math.random(3, 6) -- This is how many locks you will need to break before opening.

Config.PoliceRequired = 2 -- This is how many policemen there needs to be online to be able to breach any safe available.

Config.Debug = false -- This will enable auto complete safe and skip police requirement.