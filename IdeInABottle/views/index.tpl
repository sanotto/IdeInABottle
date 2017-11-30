% rebase('layout.tpl')

<div id="main" style="width: 30%; height:30%; margin: 0px auto;" > </div>

<script type="text/javascript">

    //Configuracción del objeto
    def={
	    name: 'form_login',
        url:'login',
        header:"{{title}}",
        fields: [
					{ name: 'user_name',  type: 'text', required: true, html: { caption: 'Usuario', attr: 'style="width: 300px"' }  },
					{ name: 'user_pass',  type: 'pass', required: true, html: { caption: 'Contraseña', attr: 'style="width: 300px"' }  },
        ],
        actions:{					
            "Login": Login_click
        }
	};
    //Creación del objeto desde la configuración
    $().w2form(def);

    //Renderizado del objeto en una div
	$('#main').w2render('form_login');

    //Atención de eventos y callbacks
	function Login_click(event)
	{	
		this.save(save_callback); 		

        function save_callback(data)
	    {
	        if (data.status == 'success') 
            {                            
                window.location.replace(data.redirect_to);
            }
	    };
	};
	
</script>