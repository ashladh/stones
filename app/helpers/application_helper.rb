module ApplicationHelper

    def playable_class_labels
        {
            "Chasseur": "hunter",
            "Druide": "druid",
            "Démoniste": "warlock",
            "Mage": "mage",
            "Guerrier": "warrior",
            "Prêtre": "priest",
            "Chaman": "shaman",
            "Voleur": "rogue",
        }
    end

    def primary_professions_labels
        {
            "Alchimie": "alchemy",
            "Couture": "tailoring",
            "Dépeçage": "skinning",
            "Enchantement": "enchanting",
            "Forge": "blacksmithing",
            "Herboristerie": "herbalism",
            "Ingénierie": "engineering",
            "Minage": "mining",
            "Travail du cuir": "leatherworking"
        }
    end

    def secondary_professions_labels
        {
            "Cuisine": "cooking",
            "Pêche": "fishing",
            "Secourisme": "firstaid"
        }
    end
end
