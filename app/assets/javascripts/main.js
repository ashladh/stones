$(function () {



    var classesSpecs = {
        hunter: {
            'Précision': 'marksmanship',
            'Survie': 'survival',
            'Maîtrise des bêtes': 'beastmastery'
        },
        druid: {
            'Equilibre': 'balance',
            'Restauration': 'druidrestoration',
            'Farouche': 'feral',
            'Guardien': 'guardian'
        },
        warlock: {
            'Destruction': 'destruction',
            'Démonologie': 'demonology',
            'Affliction': 'affliction'
        },
        warrior: {
            'Armes': 'arms',
            'Fureur': 'fury',
            'Protection': 'protection'
        },
        shaman: {
            'Amélioration': 'enhancement',
            'Elémental': 'elemental',
            'Restauration': 'shamanrestoration'
        },
        priest: {
            'Discipline': 'discipline',
            'Ombre': 'shadow',
            'Sacré': 'holy'
        },
        rogue: {
            'Assassinat': 'assassination',
            'Combat': 'combat',
            'Finesse': 'subtelty'
        },
        mage: {
            'Arcane': 'arcane',
            'Feu': 'fire',
            'Givre': 'frost'
        }
    }



    initCalendar()
    initCharacterTable()
    initSpecSelect()



    function initCalendar () {
        var calendarEl = document.getElementById('calendar')

        if ($('#calendar').length === 0) {
            return
        }

        var calendar = new FullCalendar.Calendar(calendarEl, {
            locale: 'fr',
            plugins: ['interaction', 'dayGrid'],
            defaultDate: '2019-08-12',
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: [
                {
                    title: 'All Day Event',
                    start: '2019-08-01'
                },
                {
                    groupId: 999,
                    title: 'Repeating Event',
                    start: '2019-08-09T16:00:00'
                },
                {
                    groupId: 999,
                    title: 'Repeating Event',
                    start: '2019-08-16T16:00:00'
                },
                {
                    title: 'Meeting',
                    start: '2019-08-12T10:30:00',
                    end: '2019-08-12T12:30:00'
                },
                {
                    title: 'Lunch',
                    start: '2019-08-12T12:00:00'
                },
                {
                    title: 'Meeting',
                    start: '2019-08-12T14:30:00'
                },
                {
                    title: 'Happy Hour',
                    start: '2019-08-12T17:30:00'
                },
                {
                    title: 'Dinner',
                    start: '2019-08-12T20:00:00'
                },
                {
                    title: 'Birthday Party',
                    start: '2019-08-13T07:00:00'
                },
                {
                    title: 'Click for Google',
                    url: 'http://google.com/',
                    start: '2019-08-28'
                }
            ]
        })

        calendar.render()
    }


    function initCharacterTable () {
        $('#characters').DataTable({
            paging: false
        })
    }


    function initSpecSelect () {
        var $characterSpecSelect = $('.character-spec .select')
        var $classSelect = $('.character-class .select')
        if ($characterSpecSelect.length === 0) {
            return
        }

        $classSelect.on('change', selectClass)


        function selectClass () {
            var playableClass = $classSelect.val()
            if (playableClass && playableClass in classesSpecs) {
                var classSpecs = classesSpecs[playableClass]
                $characterSpecSelect.parent().show()
                $characterSpecSelect.empty()
                for (var label in classSpecs) {
                    var $option = createSelectOption(classSpecs[label], label)
                    $characterSpecSelect.append($option)
                }
            } else {
                $characterSpecSelect.parent().hide()
            }
        }

        selectClass()

        var currentSpec = $characterSpecSelect.parent().attr('data-spec')
        if (currentSpec) {
            $characterSpecSelect.val(currentSpec)
        }
    }



    function createSelectOption (value, label) {
        return $('<option>').attr({value: value}).text(label)
    }

    $(document).ready(function() {
        $('.professions-select').select2()
    })

})
