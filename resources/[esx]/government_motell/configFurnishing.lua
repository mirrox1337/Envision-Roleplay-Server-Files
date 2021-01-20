Config.MegaMall = {
    ["entrance"] = {
        ["pos"] = vector3(2747.9279785156, 3472.796875, 55.673221588135),
        ["label"] = "Gå in till IKEA lagerhus"
    },
    ["exit"] = {
        ["pos"] = vector3(1087.4390869141, -3099.419921875, -38.99995803833),
        ["label"] = "Gå ut ifrån IKEA"
    },
    ["computer"] = {
        ["pos"] = vector3(1088.4245605469, -3101.2800292969, -38.99995803833),
        ["label"] = "Titta i katalogen"
    },
    ["object"] = {
        ["pos"] = vector3(1095.916015625, -3100.3781738281, -38.99995803833),
        ["rotation"] = vector3(0.0, 0.0, 270.0)
    }
}

Config.FurnishingPurchasables = {
    ["Sängar"] = {
        ["big_double_bed"] = {
            ["label"] = "Dubbelsäng",
            ["description"] = "Dubbelsäng.",
            ["price"] = 1500,
            ["model"] = `apa_mp_h_bed_double_09`
        },
        ["big_black_bed"] = {
            ["label"] = "Stor säng",
            ["description"] = "Stor säng.",
            ["price"] = 1500,
            ["model"] = `apa_mp_h_yacht_bed_02`
        },
        ["big_red_bed"] = {
            ["label"] = "Röd dubbelsäng ikea style",
            ["description"] = "En snygg röd designad trästomme.",
            ["price"] = 1500,
            ["model"] = `apa_mp_h_bed_wide_05`
        },
        ["big_black_doublebed"] = {
            ["label"] = "Svart dubbelsäng",
            ["description"] ="Svart dubbelsäng.",
            ["price"] = 1500,
            ["model"] = `apa_mp_h_bed_double_08`
        },
        ["big_red_doublebed"] = {
            ["label"] = "Röd dubbelsäng",
            ["description"] ="Röd dubbelsäng.",
            ["price"] = 1500,
            ["model"] = `v_res_msonbed_s`
        },
        ["big_beige_double_bed"] = {
            ["label"] = "Brun / beige säng",
            ["description"] = "Brun / beige säng.",
            ["price"] = 1500,
            ["model"] = `apa_mp_h_yacht_bed_01`
        },
        ["double_bed_with_table"] = {
            ["label"] = "Säng med Bord",
            ["description"] = "En stor dubbelsäng med nattduksbord.",
            ["price"] = 1500,
            ["model"] = `apa_mp_h_bed_with_table_02`
        },
        ["big_stokig_bed"] = {
            ["label"] = "Dubbelsäng stökig",
            ["description"] = "En stor dubbelsäng med stökigt",
            ["price"] = 1500,
            ["model"] = `p_lestersbed_s`
        },
        ["big_trakant_bed"] = {
            ["label"] = "Dubbelsäng modern med träkant",
            ["description"] = "En stor dubbelsäng med träkant",
            ["price"] = 1500,
            ["model"] = `p_mbbed_s`
        }
    },

    ["Växter"] = {
        ["high_brown_pot"] = {
            ["label"] = "Lång växt i brun kruka",
            ["description"] = "Lång växt i brun kruka",
            ["price"] = 150,
            ["model"] = `apa_mp_h_acc_plant_tall_01`
        },
        ["short_blue_pot"] = {
            ["label"] = "Kort blå växt",
            ["description"] = "Kort blå växt 15cm",
            ["price"] = 100,
            ["model"] = `apa_mp_h_acc_vase_flowers_04`
        },
        ["palm_white_pot"] = {
            ["label"] = "Palmväxt i vit kruka",
            ["description"] = "Palmväxt i vit kruka",
            ["price"] = 200,
            ["model"] = `apa_mp_h_acc_plant_palm_01`
        },
        ["hole_wase"] = {
            ["label"] = "Planta i en ihålig kruka",
            ["description"] = "Planta i en ihålig kruka.",
            ["price"] = 100,
            ["model"] = `apa_mp_h_acc_vase_flowers_02`
        },
        ["white_flower_vase"] = {
            ["label"] = "Vit bukett i vas",
            ["description"] = "Vit bukett i vas som kan ges bort till en släkting eller 2",
            ["price"] = 200,
            ["model"] = `hei_heist_acc_flowers_01`
        },
        ["long_vase"] = {
            ["label"] = "Lång växt i vas",
            ["description"] = "Lång växt i vas 50cm",
            ["price"] = 150,
            ["model"] = `prop_plant_int_03b`
        },
    },

    ["Förvaring"] = {
        ["large_drawer"] = {
            ["label"] = "Stor Byrå",
            ["description"] = "En stor byrå där du kan lägga in kläder / leksaker med mera.",
            ["price"] = 1200,
            ["model"] = `hei_heist_bed_chestdrawer_04`,
            ["func"] = function(furnishId)
                OpenStorage("motel-" .. furnishId)
            end
        },
        ["chest_drawer"] = {
            ["label"] = "Byrå",
            ["description"] = "En byrå där du kan lägga in kläder / leksaker med mera.",
            ["price"] = 2000,
            ["model"] = `apa_mp_h_bed_chestdrawer_02`,
            ["func"] = function(furnishId)
                OpenStorage("motel-" .. furnishId)
            end
        },
        ["mini_fridge"] = {
            ["label"] = "Minikyl",
            ["description"] = "En minikyl där du kan ha mat / vatten rymmer 24 33cl burkar",
            ["price"] = 2500,
            ["model"] = `prop_bar_fridge_03`,
            ["func"] = function(furnishId)
                OpenStorage("motel-" .. furnishId)
            end
        },
    },
    
    ["Mattor"] = {
        ["white_rug"] = {
            ["label"] = "Vit ull matta",
            ["description"] = "En snygg Vit ull matta .",
            ["price"] = 799,
            ["model"] = `apa_mp_h_acc_rugwooll_03`
        },
		["big_white_rug"] = {
            ["label"] = "Tjock vit ull matta",
            ["description"] = "En snygg tjock vit ull matta.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_acc_rugwooll_04`
        },
		["red_rug"] = {
            ["label"] = "Röd/Vit ombre färgad matta",
            ["description"] = "En snygg matta som ser bra ut med röda detaljer.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_acc_rugwoolm_01`
        },
		["black_rug"] = {
            ["label"] = "Svart/vit med stänk av blå färgad matta",
            ["description"] = "En snygg matta i svart/vit med stänk av blå.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_acc_rugwoolm_02`
        },
		["big_rug"] = {
            ["label"] = "Blå/Vit ombre färgad matta",
            ["description"] = "En snygg matta som ser bra ut med en gradient effekt.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_acc_rugwoolm_03`
        },
		["beige_rug"] = {
            ["label"] = "Vit/Beige färgad matta",
            ["description"] = "En vit/beige mönstrad matta.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_acc_rugwoolm_04`
        },
		["circle_rug"] = {
            ["label"] = "Vit med gråa cirklar matta",
            ["description"] = "En snygg matta som ser bra ut med gråa cirklar.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_acc_rugwools_01`
        },
		["grey_blue_rug"] = {
            ["label"] = "Flerfärgad matta",
            ["description"] = "Matta med rektanglar av olika färger.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_acc_rugwools_03`
        }
    },
    
    ["Lampor"] = {
        ["floorlamp_mp_apa"] = {
            ["label"] = "Golvlampa design",
            ["description"] = "En snygg lampa som ger bra ljus samtidigt som den är snygg.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_floorlamp_b`
        },
		["floor_lamp_int_08"] = {
            ["label"] = "Golvlampa med vit glasskärm",
            ["description"] = "En snygg lampa med vit glasskärm.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_floor_lamp_int_08`
        },
		["floorlamp_a"] = {
            ["label"] = "Golvlampa Rör skärm",
            ["description"] = "En snygg Rör skärm.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_floorlamp_a`
        },
		["floorlamp_c"] = {
            ["label"] = "Golvlampa cylinder skärm",
            ["description"] = "En snygg golvlampa med cylinder skärm.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_floorlamp_c`
        },
		["lampbulb_multiple_a"] = {
            ["label"] = "Taklampa glödlampor",
            ["description"] = "En taklampa bestående av flertalet glödlampor.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lampbulb_multiple_a`
        },
		["floorlamp_01"] = {
            ["label"] = "Golvlampa kontors design",
            ["description"] = "En snygg kontorslampa.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_floorlamp_01`
        },
		["floorlamp_03"] = {
            ["label"] = "Golvlampa gatuljus",
            ["description"] = "En snygg som efterliknar en lyktstolpe.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_floorlamp_03`
        },
		["floorlamp_05"] = {
            ["label"] = "Golvlampa stor overhead lampa",
            ["description"] = "En snygg stor overhead lampa.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_floorlamp_05`
        },
		["floorlamp_06"] = {
            ["label"] = "Golvlampa modern overhead design",
            ["description"] = "En snygg overhead lampa.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_floorlamp_06`
        },
		["floorlamp_10"] = {
            ["label"] = "Golvlampa stavar",
            ["description"] = "En snygg stav golvlampa.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_floorlamp_10`
        },
		["floorlamp_13"] = {
            ["label"] = "Golvlampa rosa stolp design",
            ["description"] = "En snygg rosa stolp lampa.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_floorlamp_13`
        },
		["floorlamp_17"] = {
            ["label"] = "Golvlampa Pyramid",
            ["description"] = "En snygg lampa med pyramid ben.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_floorlamp_17`
        },
		["lamptable_005"] = {
            ["label"] = "Bordslampa Vit med vitskärm",
            ["description"] = "En snygg bordslampa Vit med vitskärm.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lamptable_005`
        },
		["lamptable_02"] = {
            ["label"] = "Bordslampa kontor design",
            ["description"] = "En snygg kontorslampa.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lamptable_02`
        },
		["lamptable_04"] = {
            ["label"] = "Modern bordslampa rektangel skärm",
            ["description"] = "En snygg modern bordslampa rektangel skärm.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lamptable_04`
        },
		["lamptable_09"] = {
            ["label"] = "Modern bordslampa Cylinder skärm",
            ["description"] = "En snygg modern bordslampa med cylinder skärm.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lamptable_09`
        },
		["lamptable_14"] = {
            ["label"] = "Modern bordslampa",
            ["description"] = "En snygg modern bordslampa.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lamptable_14`
        },
		["lamptable_17"] = {
            ["label"] = "Bordslampa med pappersboll",
            ["description"] = "Bordslampa med pappersboll till skärm.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lamptable_17`
        },
		["lamptable_21"] = {
            ["label"] = "Bordslampa vit glas skärm",
            ["description"] = "En snygg bordslampa med vit glas skärm.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lamptable_21`
        },
		["lightpendant_01"] = {
            ["label"] = "Taklampa vit fyrkantig",
            ["description"] = "En snygg taklampa i vit fyrkantig design.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lightpendant_01`
        },
		["lightpendant_05"] = {
            ["label"] = "Taklampa grå",
            ["description"] = "En snygg taklampa i grått porslin.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lightpendant_05`
        },
		["lightpendant_05b"] = {
            ["label"] = "Taklampa trä",
            ["description"] = "En snygg taklampa i trä.",
            ["price"] = 599,
            ["model"] = `apa_mp_h_lit_lightpendant_05b`
        }
    },

    ["Bänkar"] = {
        ["sideboardl_06"] = {
            ["label"] = "Vit/svart bänk lång",
            ["description"] = "En vit/svart bänk lång.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboardl_06`
        },
		["sideboardl_09"] = {
            ["label"] = "Gråbrun bänk",
            ["description"] = "En gråbrun bänk.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboardl_09`
        },
		["sideboardl_11"] = {
            ["label"] = "Trä bänk med hyllor",
            ["description"] = "En trä bänk med hyllor.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboardl_11`
        },
		["gray_white_tv_table"] = {
            ["label"] = "Gråvit tvbänk",
            ["description"] = "En snygg bänk.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboardl_13`
        },
		["sideboardl_14"] = {
            ["label"] = "Brun bänk med gråa bitar",
            ["description"] = "En brun bänk med gråa bitar.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboardl_14`
        },
		["sideboardm_02able"] = {
            ["label"] = "Mahogny bänk",
            ["description"] = "En mahogny bänk.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboardm_02`
        },
		["sideboardm_03"] = {
            ["label"] = "Vit/svart bänk kort",
            ["description"] = "En snygg vit/svart bänk kort.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboardm_03`
        },
		["sideboards_01e"] = {
            ["label"] = "Mintgrön/vit bänk",
            ["description"] = "En snygg mintgrön/vit bänk.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboards_01`
        },
		["sideboards_02e"] = {
            ["label"] = "Glasbänk",
            ["description"] = "En snygg glasbänk.",
            ["price"] = 1100,
            ["model"] = `apa_mp_h_str_sideboards_02`
        }
    },

    ["Bord"] = {
        ["modern_triangle_table"] = {
            ["label"] = "Modernt bord",
            ["description"] = "Snyggt och ett prisvärt bord",
            ["price"] = 799,
            ["model"] = `apa_mp_h_tab_coffee_07`
        },
        ["modern_vit_table"] = {
            ["label"] = "Snyggt vitt lågt bord",
            ["description"] = "Ett snyggt vitt lågt bord.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_tab_coffee_08`
        },
        ["modern_glasstal_table"] = {
            ["label"] = "Glasbord med stålunderrede",
            ["description"] = "Ett snyggt glasbord med stålunderrede.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_tab_sidelrg_01`
        },
		["modern_fyrkant_table"] = {
            ["label"] = "Fyrkantigt glasbord med trä",
            ["description"] = "Ett snyggt bord.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_tab_sidelrg_02`
        },
		["modern_runt_table"] = {
            ["label"] = "Runt svart bord",
            ["description"] = "Ett svart runt bord.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_tab_sidelrg_04`
        },
        ["square_glass_table"] = {
            ["label"] = "Kvadrantbord",
            ["description"] = "Snyggt och ett prisvärt bord",
            ["price"] = 799,
            ["model"] = `apa_mp_h_tab_sidelrg_07`
        },
        ["modern_triptrap_table"] = {
            ["label"] = "3st små triptrap bord glas",
            ["description"] = "3st fina små glasbord.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_tab_sidesml_01`
        },
		["modern_glassmall_table"] = {
            ["label"] = "Modern litet glasbord",
            ["description"] = "Ett snyggt litet glasbord.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_tab_sidesml_02`
        },
		["modern_kaffebord_table"] = {
            ["label"] = "Bord i stål med tre ränder",
            ["description"] = "Ett bord i stål med tre ränder.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_yacht_coffee_table_01`
        },
		["modern_kaffebord2_table"] = {
            ["label"] = "Träbord med glasskiva",
            ["description"] = "Ett snyggt träbord med glasskiva",
            ["price"] = 799,
            ["model"] = `apa_mp_h_yacht_coffee_table_02`
        },
		["modern_yavht_table"] = {
            ["label"] = "Litet fyrkantigt bord med vit fyrkant",
            ["description"] = "Ett snyggt litet fyrkantigt bord med vit fyrkant.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_yacht_side_table_01`
        },
		["modern_yavht2_table"] = {
            ["label"] = "Runt lågt stålbord",
            ["description"] = "Ett runt lågt stålbord.",
            ["price"] = 799,
            ["model"] = `apa_mp_h_yacht_side_table_02`
        }	
    },

    ["Stolar"] = {
        ["chairarm_01"] = {
            ["label"] = "Brun kubliknande fotölj",
            ["description"] = "En brun kubliknande fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_01`
        },
		["chairarm_02"] = {
            ["label"] = "Gammeldags träfotölj",
            ["description"] = "Gammeldags träfotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_02`
        },
		["chairarm_03"] = {
            ["label"] = "Gammeldags träfotölj mörk",
            ["description"] = "Gammeldags träfotölj mörk.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_03`
        },
		["chairarm_09"] = {
            ["label"] = "Gul halvskål stol",
            ["description"] = "En gul halvskål stol.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_09`
        },
		["chairarm_11"] = {
            ["label"] = "Pinstol",
            ["description"] = "En Pinstol.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_11`
        },
		["chairarm_12"] = {
            ["label"] = "Svart modern snurrfotölj",
            ["description"] = "En svart modern snurrfotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_12`
        },
		["chairarm_13"] = {
            ["label"] = "Gul modern snurrfotölj",
            ["description"] = "En gul modern snurrfotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_13`
        },
		["chairarm_14"] = {
            ["label"] = "Vinröd fotölj",
            ["description"] = "En vinröd fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_23`
        },
		["chairarm_24"] = {
            ["label"] = "Svart fotölj",
            ["description"] = "En Svart fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_24`
        },
		["chairarm_25"] = {
            ["label"] = "Layback fotölj",
            ["description"] = "En Layback fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_25`
        },
		["chairarm_26"] = {
            ["label"] = "Månstol",
            ["description"] = "En Månstol.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairarm_26`
        },
        ["chairstrip_01"] = {
            ["label"] = "Orange fotölj",
            ["description"] = "En orange fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairstrip_01`
        },
		["chairstrip_02"] = {
            ["label"] = "orange kubliknande fotölj",
            ["description"] = "En orange kubliknande fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairstrip_02`
        },
		["chairstrip_04"] = {
            ["label"] = "Röd fotölj",
            ["description"] = "En röd fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairstrip_04`
        },
		["chairstrip_05"] = {
            ["label"] = "Vitfotölj",
            ["description"] = "En vit fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairstrip_05`
        },
		["chairstrip_07"] = {
            ["label"] = "Svart kubliknande fotölj",
            ["description"] = "En svart kubliknande fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairstrip_07`
        },
		["chairstrip_08"] = {
            ["label"] = "Ljusblå fotölj",
            ["description"] = "En ljusblå fotölj.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_chairstrip_08`
        },
		["daybed_02"] = {
            ["label"] = "Svart dagsbädd",
            ["description"] = "En svart dagsbädd.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_sofa_daybed_02`
        },
		["daybed_01"] = {
            ["label"] = "Brun dagsbädd",
            ["description"] = "En brun dagsbädd.",
            ["price"] = 699,
            ["model"] = `apa_mp_h_stn_sofa_daybed_01`
        },
        ["modern_white_chair1"] = {
            ["label"] = "Vit Stol",
            ["description"] = "Modern vit stol för ett bra pris",
            ["price"] = 75,
            ["model"] = `apa_mp_h_din_chair_04`
        },
        ["modern_white_chair2"] = {
            ["label"] = "Modern Vit Stol",
            ["description"] = "Modern vit stol för ett bra pris",
            ["price"] = 85,
            ["model"] = `apa_mp_h_din_chair_08`
        },
        ["comfy_chair"] = {
            ["label"] = "Svart fåtölj",
            ["description"] = "En bekväm svart fåtölj",
            ["price"] = 125,
            ["model"] = `xm_lab_chairarm_24`
        },
        ["table_chair"] = {
            ["label"] = "Bordsstol",
            ["description"] = "En basic stol",
            ["price"] = 50,
            ["model"] = `prop_table_02_chr`
        },
        ["stool1"] = {
            ["label"] = "Rund svart pall",
            ["description"] = "Rund svart pall.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_chairstool_12`
        },
		["stool2"] = {
            ["label"] = "Grå/brun fyrkantig pall",
            ["description"] = "Grå/brun fyrkantig pall.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_foot_stool_01`
        },
		["stool3"] = {
            ["label"] = "Vit fyrkantig pall",
            ["description"] = "Vit fyrkantig pall.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_foot_stool_02`
        },
		["stool4"] = {
            ["label"] = "Rund vit pall",
            ["description"] = "Rund vit pall.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_yacht_stool_01`
        }
    },

    ["Prydnader"] = {
        ["three_vases"] = {
            ["label"] = "3 små vaser på en bricka",
            ["description"] = "Snygga vaser, design.",
            ["price"] = 299,
            ["model"] = `hei_heist_acc_tray_01`
        }
    },

    ["Soffor"] = {
        ["chair_glass"] = {
            ["label"] = "Liten svart soffa",
            ["description"] = "En skön liten svart soffa.",
            ["price"] = 699,
            ["model"] = `bkr_prop_clubhouse_armchair_01a`
        },
        ["sofa_2_seat"] = {
            ["label"] = "Liten vit soffa",
            ["description"] = "En vit två sits soffa",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_sofa2seat_02`
        },
        ["sofacorn_01"] = {
            ["label"] = "Hörnsoffa grå",
            ["description"] = "Hörnsoffa grå.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_sofacorn_01`
        },
        ["sofacorn_05"] = {
            ["label"] = "Hörnsoffa grå/blå",
            ["description"] = "Hörnsoffa grå/blå.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_sofacorn_05`
        },
        ["sofacorn_06"] = {
            ["label"] = "Hörnsoffa grön",
            ["description"] = "Hörnsoffa grön.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_sofacorn_06`
        },
        ["sofacorn_07"] = {
            ["label"] = "Hörnsoffa blå/svart",
            ["description"] = "Hörnsoffa blå/svart.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_sofacorn_07`
        },
        ["sofacorn_08"] = {
            ["label"] = "Hörnsoffa grå/brun",
            ["description"] = "Hörnsoffa grå/brun.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_sofacorn_08`
        },
        ["sofacorn_09"] = {
            ["label"] = "Hörnsoffa svart",
            ["description"] = "Hörnsoffa svart.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_sofacorn_09`
        },
        ["sofacorn_010"] = {
            ["label"] = "Hörnsoffa Vit",
            ["description"] = "Hörnsoffa vit.",
            ["price"] = 299,
            ["model"] = `apa_mp_h_stn_sofacorn_10`
        }
    },

    ["Tavlor"] = {
        ["red_painting"] = {
            ["label"] = "S - Röd tavla",
            ["description"] = "Röd tavla med ränder.",
            ["price"] = 399,
            ["model"] = `apa_mp_h_acc_artwalll_01`
        },
		["orange_painting"] = {
            ["label"] = "S - Orange tavla",
            ["description"] = "Orange modern tavla.",
            ["price"] = 399,
            ["model"] = `apa_mp_h_acc_artwalll_02`
        },
		["blue_painting"] = {
            ["label"] = "S - Blå tavla",
            ["description"] = "Blå modern tavla.",
            ["price"] = 399,
            ["model"] = `apa_mp_h_acc_artwalll_03`
        },
		["lightblue_painting"] = {
            ["label"] = "M - Ljusblå tavla",
            ["description"] = "Ljusblå modern tavla.",
            ["price"] = 399,
            ["model"] = `apa_mp_h_acc_artwallm_02`
        },
		["white_painting"] = {
            ["label"] = "M - Vit tavla",
            ["description"] = "Vit modern tavla.",
            ["price"] = 399,
            ["model"] = `apa_mp_h_acc_artwallm_03`
        },
		["redm_painting"] = {
            ["label"] = "M - Röd tavla",
            ["description"] = "Röd modern tavla.",
            ["price"] = 399,
            ["model"] = `apa_mp_h_acc_artwallm_04`
        },
		["artwalll_01_painting"] = {
            ["label"] = "Blå tavla med orange fyrkant",
            ["description"] = "En blå tavla med en udda orange fyrkant.",
            ["price"] = 399,
            ["model"] = `apa_p_h_acc_artwalll_01`
        },
		["artwalll_02_painting"] = {
            ["label"] = "Tavla med olika nyanser av gult",
            ["description"] = "Tavla med olika nyanser.",
            ["price"] = 399,
            ["model"] = `apa_p_h_acc_artwalll_02`
        },
		["artwalll_03_painting"] = {
            ["label"] = "Grå modern art tavla",
            ["description"] = "Grå modern art tavla.",
            ["price"] = 399,
            ["model"] = `apa_p_h_acc_artwalll_03`
        },
		["artwalll_04_painting"] = {
            ["label"] = "Blåa tavla likt den röda med ränder",
            ["description"] = "Blå tavla med ränder.",
            ["price"] = 399,
            ["model"] = `apa_p_h_acc_artwalll_04`
        },
		["artwallm_01_painting"] = {
            ["label"] = "Vit tavla med olika nivåer med klossar",
            ["description"] = "Vit tavla med olika nivåer med klossar.",
            ["price"] = 399,
            ["model"] = `apa_p_h_acc_artwallm_01`
        },
		["artwallm_03_painting"] = {
            ["label"] = "Svarta hålet",
            ["description"] = "Varför målar man såhär?",
            ["price"] = 399,
            ["model"] = `apa_p_h_acc_artwallm_03`
        },
		["artwallm_04_painting"] = {
            ["label"] = "Tavla med olika spotlights ränder",
            ["description"] = "tavlan med olika ränder.",
            ["price"] = 399,
            ["model"] = `apa_p_h_acc_artwallm_04`
        }
    },

    ["Jul"] = {
        ["Gran"] = {
            ["label"] = "Julgran",
            ["description"] = "lite julkänsla!",
            ["price"] = 850,
            ["model"] = `xm_prop_x17_xmas_tree_int`
        },
    },

    ["Elektronik"] = {
        ["big_tv"] = {
            ["label"] = "Stor TV",
            ["description"] = "En stor och bra kvalité TV.",
            ["price"] = 3300,
            ["model"] = `ex_prop_ex_tv_flat_01`
        },
		["big_tv_furniture_1"] = {
            ["label"] = "Brun tvmöbel modell stor",
            ["description"] = "Brun tvmöbel modell stor.",
            ["price"] = 4000,
            ["model"] = `apa_mp_h_str_avunitl_01_b`
        },
		["big_tv_furniture_2"] = {
            ["label"] = "Vit tv möbel med tillhörande hyllor",
            ["description"] = "Vit tv möbel med tillhörande hyllor.",
            ["price"] = 4000,
            ["model"] = `apa_mp_h_str_avunitl_04`
        },
		["big_tv_furniture_3"] = {
            ["label"] = "Modern TV möbel i svart med gula högtalare",
            ["description"] = "Modern TV möbel i svart med högtalare.",
            ["price"] = 4000,
            ["model"] = `apa_mp_h_str_avunitm_01`
        },
		["big_tv_furniture_4"] = {
            ["label"] = "Modern TV möbel i svart med vita högtalare",
            ["description"] = "Modern TV möbel i svart med högtalare.",
            ["price"] = 4000,
            ["model"] = `apa_mp_h_str_avunitm_03`
        },
		["big_tv_furniture_5"] = {
            ["label"] = "Modern TV möbel i svart",
            ["description"] = "Modern TV möbel i svart.",
            ["price"] = 4000,
            ["model"] = `apa_mp_h_str_avunits_01`
        },
		["big_tv_furniture_6"] = {
            ["label"] = "Modern TV möbel i grått",
            ["description"] = "Modern TV möbel i grått.",
            ["price"] = 4000,
            ["model"] = `apa_mp_h_str_avunits_04`
        },
        ["i_mac_keyboard"] = {
            ["label"] = "iMac med tagentbord",
            ["description"] = "En dator ifrån apple.",
            ["price"] = 250,
            ["model"] = `ex_prop_trailer_monitor_01`
        },
        ["black_laptop"] = {
            ["label"] = "Lenovo laptop",
            ["description"] = "En bra kvalite på datorn!",
            ["price"] = 450,
            ["model"] = `p_amb_lap_top_02`
        },
        ["i_max_keyboard"] = {
            ["label"] = "iMax med tagenbord",
            ["description"] = "En bra kvalite på datorn!",
            ["price"] = 350,
            ["model"] = `xm_prop_x17_computer_01`
        },
        ["big_tv_2"] = {
            ["label"] = "Samsung wide Tv",
            ["description"] = "En bred bio tv!",
            ["price"] = 4000,
            ["model"] = `ba_prop_battle_club_screen_02`
        },
        ["tv_1"] = {
            ["label"] = "Liten Tv",
            ["description"] = "en liten tv!",
            ["price"] = 1500,
            ["model"] = `ba_prop_battle_club_screen_03`
        },
        ["tv_with_table_01"] = {
            ["label"] = "Tv med träfärgad tv-bänk",
            ["description"] = "Tv med träfärgad tv-bänk",
            ["price"] = 2500,
            ["model"] = `apa_mp_h_str_avunitl_01_b`
        },
        ["tv_with_table_02"] = {
            ["label"] = "Tv med vit tv-bänk",
            ["description"] = "Tv med vit tv-bänk",
            ["price"] = 2600,
            ["model"] = `apa_mp_h_str_avunitl_04`
        },
        ["tv_with_table_04"] = {
            ["label"] = "Tv med svart tv-bänk",
            ["description"] = "Tv med svart tv-bänk och stereo högtalare",
            ["price"] = 3000,
            ["model"] = `apa_mp_h_str_avunitl_04`
        },
    },

    ["Fritid"] = {
        ["water_can"] = {
            ["label"] = "Vatten grej",
            ["description"] = "En vatten grej som du kan ta vatten ur.",
            ["price"] = 599,
            ["model"] = `prop_watercooler`,
            ["func"] = function(furnishId)
                UseWaterCan(furnishId)
            end
        }
    },

    ["Högtalere"] = {
        ["speaker_01"] = {
            ["label"] = "Pionolackade golvhögtalare",
            ["description"] = "En pionolackad golvhögtalare",
            ["price"] = 1250,
            ["model"] = `prop_speaker_01`
        },
        ["speaker_02"] = {
            ["label"] = "Modern golvhögtalare",
            ["description"] = "En modern golvhögtalare",
            ["price"] = 850,
            ["model"] = `prop_speaker_02`
        },
        ["speaker_03"] = {
            ["label"] = "Modern högtalare",
            ["description"] = "En modern högtalare",
            ["price"] = 650,
            ["model"] = `prop_speaker_03`
        },
        ["speaker_center"] = {
            ["label"] = "Modern center högtalare",
            ["description"] = "En modern center högtalare",
            ["price"] = 550,
            ["model"] = `prop_speaker_08`
        },
    },
}
