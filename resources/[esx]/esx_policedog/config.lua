-- TriggerEvent('esx_policedog:openMenu') to open menu

Config = {
    Job = 'police',
    Command = 'polishund', -- sätt false ifall det ej ska va via command
    Model = 351016938,
    TpDistance = 50,
    Sit = {
        dict = 'creatures@rottweiler@amb@world_dog_sitting@base',
        anim = 'base'
    },
    Drugs = {'weed', 'coke', 'meth'}, -- lägg till alla drogitems som finns i databasen
}

Strings = {
    ['not_police'] = 'Du är inte en poliskonstapel!',
    ['menu_title'] = 'Polishund',
    ['take_out_remove'] = 'Ta ut/lämna in polishund',
    ['deleted_dog'] = 'Du tog bort polishunden',
    ['spawned_dog'] = 'Du tog ut polishunden',
    ['sit_stand'] = 'Gör så att hunden sitter/står upp',
    ['no_dog'] = "Du har ingen hund!",
    ['dog_dead'] = 'Hunden har dött!',
    ['search_drugs'] = 'Sök närmsta person efter droginnehav',
    ['no_drugs'] = 'Hunden kände inte någon lukt av droger!', 
    ['drugs_found'] = 'Hunden markerade på att individen hade droger!',
    ['dog_too_far'] = 'Hunden är för långt bort',
    ['attack_closest'] = 'Attackera närmaste person'
}