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
    initParticipationForm()
    initParticipationStatusHandler()



    function initCalendar () {
        var calendarEl = document.getElementById('calendar')

        if ($('#calendar').length === 0) {
            return
        }


        $.get('/member/calendar_events.json', function (events) {
            initFullCalendar(calendarEl, events)
        })
    }


    function initFullCalendar (calendarEl, events) {
        var calendar = new FullCalendar.Calendar(calendarEl, {
            timeZone: 'UTC',
            locale: 'fr',
            plugins: ['interaction', 'dayGrid'],
            editable: true,
            eventLimit: true, // allow "more" link when too many events
            events: events,
            dateClick (info) {
                //window.location.replace('/member/calendar_events/new?date=' + info.dateStr)
            },
            eventRender: initTippyForCalendarEvent,
            buttonText: {
                today:    "aujourd'hui",
                month:    'mois',
                week:     'semaine',
                day:      'jour',
                list:     'liste'
            }
        })
        calendar.render()
    }



    function initTippyForCalendarEvent ({el, event}) {
        tippy(el, {
            theme: 'dark',
            interactive: true,
            content: 'Loading...',
            animateFill: false,
            animation: 'fade',
            flipOnUpdate: true,
            maxWidth: 600,
            delay: [0, 0],
            onShow (instance) {
                $.get('/member/calendar_events/' + event.id + '/preview', function (html) {
                    instance.setContent(html)
                })
            }
        })
    }


    function initCharacterTable () {
        $('#characters').DataTable({
            paging: false,
            language: {
                sEmptyTable:     'Aucune donnée disponible dans le tableau',
                sInfo:           "Affichage de l'élément _START_ à _END_ sur _TOTAL_ éléments",
                sInfoEmpty:      "Affichage de l'élément 0 à 0 sur 0 élément",
                sInfoFiltered:   '(filtré à partir de _MAX_ éléments au total)',
                sInfoPostFix:    '',
                sInfoThousands:  ',',
                sLengthMenu:     'Afficher _MENU_ éléments',
                sLoadingRecords: 'Chargement...',
                sProcessing:     'Traitement...',
                sSearch:         'Rechercher :',
                sZeroRecords:    'Aucun élément correspondant trouvé',
                oPaginate: {
                    sFirst:    'Premier',
                    sLast:     'Dernier',
                    sNext:     'Suivant',
                    sPrevious: 'Précédent'
                },
                oAria: {
                    sSortAscending:  ': activer pour trier la colonne par ordre croissant',
                    sSortDescending: ': activer pour trier la colonne par ordre décroissant'
                },
                select: {
                    rows: {
                        _: '%d lignes sélectionnées',
                        0: 'Aucune ligne sélectionnée',
                        1: '1 ligne sélectionnée'
                    }
                }
            },
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
            locale: 'fr'
        })
    }


    function initParticipationForm () {
        if ($('.your-participation').length === 0) {
            return
        }

        $('.your-participation-toggle a').on('click', function (e) {
            e.preventDefault()
            $('.your-participation-form').show()
            $('.your-participation-toggle').hide()
        })
    }


    function initParticipationStatusHandler () {
        if ($('.edit-participation-status').length === 0) {
            return
        }

        $('.edit-participation-status').each(function () {
            var $tooltip = $(this)
            var content = $tooltip.parent('.event-participation').find('.participation-status-links').html()
            tippy(this, {
                theme: 'dark',
                interactive: true,
                content: content,
                animateFill: false,
                animation: 'fade',
                flipOnUpdate: true,
                maxWidth: 600,
                delay: [0, 0]
            })

            $tooltip.on('click', function (e) {
                e.preventDefault()
            })
        })
    }

    $(document).ready(function () {
        $('.professions-select').select2()
    })

})
