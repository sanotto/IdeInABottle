% rebase('layout.tpl',  title='Home Page')
<div id="main" style=" position: absolute;    width: 99%;    height: 97%;"></div>
<script type="text/javascript">

    def={};
    def.main_layout={
        name: 'main_layout',
        panels: [
                    {type: 'top',  size: 30 },
                    { type: 'left', size:'25%', resizable: true },
                    { type: 'main', resizable: true ,
                            tabs: [
                                    { id: 'tab1', text: 'Bienvenido ...', contents:'asd' }
                                  ]
                    }
                ]
    };

    def.left_grid={
        name: 'left_grid', 
        show: { 
            toolbar: true,            
        },
        searches: [                
            { field: 'objnme', caption: 'Nombre', type: 'text' },
            { field: 'objdsc', caption: 'Descripción', type: 'text' }
        ],
        columns: [                
                    { field: 'objnme', caption: 'Nombre', size: '25%' },
                    { field: 'objdsc', caption: 'Descripción', size:'75%'}
                ]
    };

    def.top_toolbar={
        name: 'top_toolbar',
            items: [
                    { type: 'menu', id: 'file_menu', text: 'Archivos', icon: 'fa-table',
                        items: [
                                { text: 'Salir'}
                               ]
                    }
                   ]
    };

    $().w2layout(def.main_layout);
    $().w2grid(def.left_grid);
    $().w2tabs(def.main_tab);
    $().w2toolbar(def.top_toolbar);
    w2ui.main_layout.content('left', w2ui.left_grid);
    w2ui.main_layout.content('top', w2ui.top_toolbar);
    w2ui.top_toolbar.on('*', toolbar_events );
    w2ui['main_layout'].tabs=w2ui.main_tab;
    w2ui['main_layout'].load('main', '/static/content/welcome.html')
    //Renderizado del objeto en una div
    $('#main').w2render('main_layout');

    function toolbar_events(event)
    {        
        if (event.target == 'file_menu:Salir')
        {
            window.location.replace('logout');
        }
    }
</script>