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
		 menu: [
			{ id: 1, text: 'Select Item', icon: 'fa-star' },
			{ id: 2, text: 'View Item', icon: 'fa-camera' }, 
			{ id: 4, text: 'Delete Item', icon: 'fa-minus' }
		],
		onMenuClick: left_grid_menu_click,

        show: { 
            toolbar: true,            
			toolbarAdd:true
        },
        
        columns: [                
                    { field: 'objnme', caption: 'Nombre', size: '25%' },
                    { field: 'objdsc', caption: 'Descripción', size:'75%'}
                ],
		searches: [                
            { field: 'objnme', caption: 'Nombre', type: 'text' },
            { field: 'objdsc', caption: 'Descripción', type: 'text' }
        ],
		records: [
		    { recid: 1, objnme: 'DSDB01.SRC', objdsc: 'Librería de fuentes de SIDEBA' , 
				w2ui:{
					children:[
								{recid: 2, objnme: 'QRPGSRC', objdsc: 'Fuentes RPG'  ,
									w2ui:{
											children:[
												{recid: 3, objnme: 'BAAÑ00MM', objdsc: 'Personas Fisicas MM'  }
										]
									}								
								}
							 ]
					}
			},
		],
    };

    def.top_toolbar={
        name: 'top_toolbar',
					items: [
						{ type: 'menu-radio', id: 'item2', icon: 'fa-star' ,
							text: function (item) {
								var text = item.selected;
								var el   = this.get('item2:' + item.selected);
								return el.text;
							},
							selected: 'id1',
							items: [
								{ id: 'id1', text: 'Espacio de Trabajo: SIDEBA' },
								{ id: 'id2', text: 'Espacio de Trabajo: PRUEBALINK' },
								{ id: 'id3', text: 'Espacio de Trabajo: DESA00525' },
								{ type: 'break' },
								{ id: 'id4', text: 'Crear nuevo espacio de trabajo' },
							]
                        },
                        { type: 'button', id: 'load', text: 'Cargar', icon: 'fa-table'},
						{ type: 'spacer' },
						{ type: 'menu', id: 'item1', text: '{{session["user_name"]}}', icon: 'fa-table', 
							items: [
										{ text: 'Preferencias', icon: 'fa-wrench' },
										{ text: 'Item 2', icon: 'fa-picture', disabled: true },
										{ type: 'spacer' },
										{ text: 'Cerrar sesión', icon: 'w2ui-icon-cross' }
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
        if (event.target == 'app_exit')
        {
			alert(event.target)
            //window.location.replace('logout');
        }
        if (event.target == 'cargar')
        {
            alert(event.target)
            //window.location.replace('logout');
        }
    }

	function left_grid_menu_click(event)
	{
		alert(event.target);
	}
</script>