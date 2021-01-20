Config = {}

Config.BottleRecieve = { 1, 2 } -- This is the math random ex. math.random(1, 6) this will give you 1 - 6 bottles when searching a bin.
Config.BottleReward = { 1, 5 } -- This is the math random ex. math.random(1, 4) this will give a random payout between 1 - 4

-- Here you add all the bins you are going to search.
Config.BinsAvailable = {
	"prop_bin_01a",
    "prop_bin_03a",
    "prop_bin_05a"
}

-- This is where you add the locations where you sell the bottles.
Config.SellBottleLocations = {
    vector3(434.40316772461, -654.205078125, 28.756423950195),
    vector3(1966.4473876953, 3748.1887207031, 32.343742370605),
    vector3(356.88809204102, 173.42010498047, 103.06829071045)
}