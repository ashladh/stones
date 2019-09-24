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
    initDatePicker()



    function initCalendar () {
        var calendarEl = document.getElementById('calendar')

        if ($('#calendar').length === 0) {
            return
        }


        $.get('/member/calendar_events.json', function (events) {
            var calendar = new FullCalendar.Calendar(calendarEl, {
                timeZone: 'UTC',
                locale: 'fr',
                plugins: ['interaction', 'dayGrid'],
                editable: true,
                eventLimit: true, // allow "more" link when too many events
                events: events,
                eventClick: function (info) {
                    console.log(info)
                }
            })
            calendar.render()
        })




    }


    function initCharacterTable () {
        $('#characters').DataTable({
            paging: false,
            searching: false,
            info: false,
            columns: [
                null,
                null,
                null,
                {orderable: false},
                {orderable: false}
            ]
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

    function  initDatePicker () {
        flatpickr('.datepicker', {
            enableTime: true,
            //dateFormat: 'd-m-Y H:i',
            locale: 'fr'
        })
    }

    $(document).ready(function() {
        $('.professions-select').select2()
    })

})
