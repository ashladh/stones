module ApplicationHelper

    def playable_class_labels
        labels = {}
        I18n.t('playable_classes.').each do |key, value|
            labels[value] = key.to_s
        end
        labels
    end

    def primary_professions_labels
        labels = {}
        I18n.t('primary_professions.').each do |key, value|
            labels[value] = key.to_s
        end
        labels
    end

    def secondary_professions_labels
        labels = {}
        I18n.t('secondary_professions.').each do |key, value|
            labels[value] = key.to_s
        end
        labels
    end

    def translated_professions character
        (
            character.primary_professions.map{|p| t('primary_professions.' + p)} +
            character.secondary_professions.map{|p| t('secondary_professions.' + p)}
        ).join(', ')
    end

    def presence_labels
        {
            "Accepté": "accepted",
            "Incertain": "tentative",
            "Absent": "absent"
        }
    end

    def rank_labels user
        labels = {
            "Enregistré": "registered",
            "Membre": "member"
        }
        if user.guild_master?
            labels["Officier"] = "officer"
        end
        labels
    end

    def raid_labels
        {
            "Molten Core": "molten_core",
            "Onyxia's Lair": "onyxia"
        }
    end

end
