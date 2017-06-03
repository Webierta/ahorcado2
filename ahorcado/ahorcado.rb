#encoding: utf-8
#!/usr/bin/ruby

require 'gtk3'

class RubyApp < Gtk::Window

def salir  # OPCIÓN DE OTRA PARTIDA O SALIR CUANDO SE GANA O SE PIERDE

  @titulo3.hide       
  @etiqueta_letra.hide    
  @entrada_letra.hide  
    
  @titulo_texto3 = "¿Otra partida?"
  @titulo3 = Gtk::Label.new(@titulo_texto3)
  font_desc = Pango::FontDescription.new("Sans 20")
  @titulo3.override_font(font_desc)
  @titulo3.override_color :normal, Gdk::RGBA::new(1, 1, 1, 1)
  @contenedor.put @titulo3, 150, 50
  
  @b_inicio = Gtk::Button.new :label =>'SÍ'
  @b_inicio.can_focus=true
  @b_inicio.set_size_request 80, 35      
  @b_inicio.set_tooltip_text "Otra partida"
  @b_inicio.signal_connect "clicked" do      
    introducir    
  end  
  @contenedor.put @b_inicio, 100, 425       
    
  @b_salir = Gtk::Button.new(:label => "NO")
  @b_salir.set_size_request 80, 35
  @b_salir.set_tooltip_text "Cerrar aplicación"    
  @b_salir.signal_connect ("clicked") do
    Gtk.main_quit    
    exit 
  end  
  @contenedor.put @b_salir, 350, 425
  
  @titulo3.show
  @b_inicio.show
  @b_salir.show
  Gtk.main
end

def comparar(parole, leter, bien, pista, mal, fallos)  # COMPARAR LETRA EN PALABRA
  
  if parole.include?(leter)       # Si la letra está en la palabra secreta  
    parole.each_index do |index|  # Compara la letra con cada letra de la palabra
      if parole[index] == leter       
        bien += 1               
        pista[index] = parole[index]        
      end
    end   
  else                            # Si la letra no está en la palabra secreta
    if fallos.include?(leter)     # Fallo repetido      
      md = Gtk::MessageDialog.new :parent => self, 
      :flags => :destroy_with_parent, :type =>  :warning, 
      :buttons_type => :close, :message => "¿Otra vez la letra #{leter}?"
      md.run
      md.destroy      
    else
      fallos<< leter
      mal +=1
      if mal == 1        
        horca_texto = %{Tu primer error: #{fallos.join(" ")}.
El verdugo te coloca la soga
alrededor del cuello.}
        md = Gtk::MessageDialog.new :parent => self, 
        :flags => :destroy_with_parent, :type =>  :warning, 
        :buttons_type => :close, :message => horca_texto
        md.run
        md.destroy
              
        @imagen_h.destroy                    
        @imagen_h = Gtk::Image.new(:file => "2.png")  
        @contenedor.put @imagen_h, 100, 110        
        @imagen_h.show
        
      elsif mal == 2        
        horca_texto = %{Piensa un poco.
Llevas #{mal} errores: #{fallos.join(" ")}.
La presión de la soga
te impide respirar.}
        md = Gtk::MessageDialog.new :parent => self, 
        :flags => :destroy_with_parent, :type =>  :warning, 
        :buttons_type => :close, :message => horca_texto
        md.run
        md.destroy

        @imagen_h.destroy                  
        @imagen_h = Gtk::Image.new(:file => "3.png")  
        @contenedor.put @imagen_h, 100, 110               
        @imagen_h.show                
      
      elsif mal == 3        
        horca_texto = %{Cuidadín. Llevas #{mal} errores: #{fallos.join(" ")}.
Empiezan los temblores por
por un brazo hasta la mano.}
        md = Gtk::MessageDialog.new :parent => self, 
        :flags => :destroy_with_parent, :type =>  :warning, 
        :buttons_type => :close, :message => horca_texto
        md.run
        md.destroy
                
        @imagen_h.destroy                 
        @imagen_h = Gtk::Image.new(:file => "4.png")  
        @contenedor.put @imagen_h, 100, 110                
        @imagen_h.show        
        
      elsif mal == 4        
        horca_texto =%{Parece difícil.
Llevas #{mal} errores: #{fallos.join(" ")}.
Has dejado de sentir el otro brazo.}
        md = Gtk::MessageDialog.new :parent => self, 
        :flags => :destroy_with_parent, :type =>  :warning, 
        :buttons_type => :close, :message => horca_texto
        md.run
        md.destroy         

        @imagen_h.destroy                 
        @imagen_h = Gtk::Image.new(:file => "5.png")  
        @contenedor.put @imagen_h, 100, 110         
        @imagen_h.show      
                    
      elsif mal == 5        
        horca_texto = %{Cuidadín, cuidadín,
un error más y pierdes.
Errores: #{fallos.join(" ")}.
Tampoco sientes ya una pierna.}
        md = Gtk::MessageDialog.new :parent => self, 
        :flags => :destroy_with_parent, :type =>  :warning, 
        :buttons_type => :close, :message => horca_texto
        md.run
        md.destroy
                
        @imagen_h.destroy               
        @imagen_h = Gtk::Image.new(:file => "6.png")  
        @contenedor.put @imagen_h, 100, 110                
        @imagen_h.show               
               
      elsif mal == 6        
        horca_texto = %{Lo siento, has perdido.
La palabra era #{parole.join("")}.
Has muerto estrangulado en la horca.}        
        md = Gtk::MessageDialog.new :parent => self, 
        :flags => :destroy_with_parent, :type =>  :warning, 
        :buttons_type => :close, :message => horca_texto
        md.run
        md.destroy
        
        @imagen_h.destroy                    
        @imagen_h = Gtk::Image.new(:file => "7.png")  
        @contenedor.put @imagen_h, 100, 110         
        @imagen_h.show        
                        
        salir   # REVISAR: ¿PRIMERO IMAGEN y LUEGO DIALOGO?        
      end      
    end
  end  
     
  return [pista, bien, mal]  
    
  @imagen_h.show
  Gtk.main  #Gtk.main  ??????????????????????????????
end

def adivinar(secreta)
  
  @titulo2.hide  
  @etiqueta2.hide      
  @entrada.hide    
  @b_ayuda.hide   
  
  @titulo_texto3 = "TURNO JUGADOR 2"
  @titulo3 = Gtk::Label.new(@titulo_texto3)  
  @titulo3.override_color :normal, Gdk::RGBA::new(1, 1, 1, 0.8)
  @contenedor.put @titulo3, 150, 50
    
  @imagen_h = Gtk::Image.new(:file => "1.png")  
  @contenedor.put @imagen_h, 100, 110
    
  aciertos = 0
  errores = 0
  intentos = []  
    
  n_letras = secreta.length  # Dibujar una raya por letra de la palabra secreta
  adivinado = "_" * n_letras 
  adivinado = adivinado.split("")
     
  @texto_adi = adivinado.join(" ")  
  @etiqueta_adi = Gtk::Label.new @texto_adi
  @font_raya = Pango::FontDescription.new("Sans 30")
  @etiqueta_adi.override_font(@font_raya)
  @etiqueta_adi.override_color :normal, Gdk::RGBA::new(1, 1, 1, 1)
  @contenedor.put @etiqueta_adi, 100, 350 
  
  secreta = secreta.split("")
    
  @texto_letra = "Una letra:"  
  @etiqueta_letra = Gtk::Label.new @texto_letra
  @font = Pango::FontDescription.new("Sans 14")
  @etiqueta_letra.override_font(@font)
  @etiqueta_letra.override_color :normal, Gdk::RGBA::new(1, 1, 1, 0.5)
  @contenedor.put @etiqueta_letra, 100, 425  
  
  @entrada_letra = Gtk::Entry.new
  @entrada_letra.set_max_length( 1 )
  @entrada_letra.set_activates_default( true )    
  @entrada_letra.set_width_chars( 3 )     
  @entrada_letra.signal_connect "activate" do 
    letra_in = @entrada_letra.text                
    letra_in = letra_in.upcase    
    if letra_in == "ñ"
      letra_in = "Ñ"
    end
    patron = /[A-Z]/   # patron = /[[:alpha:]]/
    m = patron.match(letra_in)    
       
    if (m && letra_in.length == 1) or letra_in == "Ñ"  # Valida la letra
      if adivinado.include?(letra_in)                  # La letra YA está adivinada        
        md = Gtk::MessageDialog.new :parent => self, 
        :flags => :destroy_with_parent, :type =>  :warning, 
        :buttons_type => :close, :message => "No insistas, la letra '#{letra_in}' ya la has adivinado."
        md.run
        md.destroy        
        @entrada_letra.text =""
      else   
        resultado = comparar(secreta, letra_in, aciertos, adivinado, errores, intentos)
        adivinado = resultado[0]
        aciertos = resultado[1]
        errores = resultado[2]               
         
        @entrada_letra.text = ""        
        
        @etiqueta_adi.destroy        
        @texto_adi = adivinado.join(" ")
        @etiqueta_adi = Gtk::Label.new @texto_adi
        @font_raya = Pango::FontDescription.new("Sans 30")
        @etiqueta_adi.override_font(@font_raya)
        @etiqueta_adi.override_color :normal, Gdk::RGBA::new(1, 1, 1, 1)           
        @contenedor.put @etiqueta_adi, 100, 350           
        
        @etiqueta_adi.show
        
        if aciertos == n_letras      # Si acierta todas
          md = Gtk::MessageDialog.new :parent => self, 
          :flags => :destroy_with_parent, :type =>  :info, 
          :buttons_type => :close, :message => "¡FELICIDADES!"
          md.run
          md.destroy          

          salir     # REVISAR   ¿PRIMERO LA IMAGEN Y LUEGO EL DIALOGO?
        end
      end  # Fin IF
    else  # No valida la letra      
      md = Gtk::MessageDialog.new :parent => self, 
      :flags => :destroy_with_parent, :type =>  :warning, 
      :buttons_type => :close, :message => "¿Eso es una letra? Inténtalo de nuevo."
      md.run
      md.destroy        
      @entrada_letra.text =""      
    end  # Fin IF
    
  end # Fin de entrada_letra    
  @contenedor.put @entrada_letra, 225, 415         

  @titulo3.show
  @imagen_h.show
  @etiqueta_adi.show
  @etiqueta_letra.show
  @entrada_letra.show  
  
  Gtk.main  #Gtk.main   ??????????????????????????      
end  # FIN ADIVINAR

def validar(palabro)  # Validar palabra secreta
  
  palabro = palabro.gsub(/[áéíóú]/, "á" => "a", "é" => "e", "í" => "i", "ó" => "o", "ú" => "u")
  palabro = palabro.gsub(/[àèìòù]/, "à" => "a", "è" => "e", "ì" => "i", "ò" => "o", "ù" => "u")
  palabro = palabro.gsub(/[äëïöü]/, "ä" => "a", "ë" => "e", "ï" => "i", "ö" => "o", "ü" => "u")
  
  palabro = palabro.gsub(/\d/, "")  # Elimina dígitos
  palabro = palabro.gsub(/\s/, "")  # Elimina espacios

  palabro = palabro.gsub(/[ñ]/, "3")
  palabro = palabro.gsub(/[Ñ]/, "3")
  palabro = palabro.gsub(/\W/, "")   # Elimina otros caracteres
  palabro = palabro.gsub(/[3]/, "Ñ")

  return palabro  
end  # FIN VALIDAR

def introducir 
    
  if @titulo.visible? == true   # POR SI EJECUTA NUEVO DESDE PANTALLA 1
    @titulo.hide     
  end  
  if @imagen.visible? == true
    @imagen.hide  
  end
  if @etiqueta.visible? == true 
    @etiqueta.hide     
  end  
  if @b_inicio.visible? == true
    @b_inicio.hide  
  end  
   if @b_salir.visible? == true
    @b_salir.hide  
  end 
 
  if @titulo2               # POR SI EJECUTA NUEVO DESDE PANTALLA 2
    if @titulo2.visible? == true 
      @titulo2.destroy     
    end
  end
  if @etiqueta2
    if @etiqueta2.visible? == true
      @etiqueta2.destroy  
    end
  end
  if @entrada
    if @entrada.visible? == true 
      @entrada.destroy     
    end
  end
  if @b_ayuda
    if @b_ayuda.visible? == true 
      @b_ayuda.destroy     
    end
  end         
  
  if @titulo3              # POR SI EJECUTA NUEVO DESDE PANTALLA 3
    if @titulo3.visible? == true 
      @titulo3.hide     
    end
  end
  if @imagen_h
    if @imagen_h.visible? == true
      @imagen_h.hide  
    end
  end
  if @etiqueta_adi
    if @etiqueta_adi.visible? == true 
      @etiqueta_adi.hide     
    end
  end
  if @etiqueta_letra
    if @etiqueta_letra.visible? == true 
      @etiqueta_letra.hide     
    end
  end      
  if @entrada_letra
    if @entrada_letra.visible? == true 
      @entrada_letra.hide     
    end
  end    
     
  @titulo_texto2 = "TURNO JUGADOR 1"
  @titulo2 = Gtk::Label.new(@titulo_texto2)
  #font_desc = Pango::FontDescription.new("Sans 18")
  #@titulo2.override_font(font_desc)
  @titulo2.override_color :normal, Gdk::RGBA::new(1, 1, 1, 0.8)
  @contenedor.put @titulo2, 150, 50
  
  @etiqueta_texto2 = %{Escribe tu palabra secreta:}
  @etiqueta2 = Gtk::Label.new @etiqueta_texto2
  font_desc = Pango::FontDescription.new("Sans 14")
  @etiqueta2.override_font(font_desc)
  @etiqueta2.override_color :normal, Gdk::RGBA::new(1, 1, 1, 0.5)
  @contenedor.put @etiqueta2, 100, 200  
 
  @entrada = Gtk::Entry.new
  @entrada.set_max_length( 12 )
  @entrada.set_visibility (false)    
  @entrada.signal_connect "activate" do
    palabra_secreta = @entrada.text    
    comprobar = validar(palabra_secreta)
    palabra_secreta = comprobar    
    if palabra_secreta.length == 0    
      md = Gtk::MessageDialog.new :parent => self, 
      :flags => :destroy_with_parent, :type =>  :warning, 
      :buttons_type => :close, :message => "No entiendo. Inténtalo con otra palabra."
      md.run
      md.destroy
      @entrada.text =""
    elsif palabra_secreta.length > 0  && palabra_secreta.length < 4
      md = Gtk::MessageDialog.new :parent => self, 
      :flags => :destroy_with_parent, :type =>  :warning, 
      :buttons_type => :close, :message => "Al menos cuatro letras, por favor."
      md.run
      md.destroy
      @entrada.text =""
    else
      palabra_secreta = palabra_secreta.upcase
      adivinar(palabra_secreta)
    end  
  end    
  @contenedor.put @entrada, 150, 250
  
  @b_ayuda = Gtk::Button.new :label =>'Ayuda'  
  @b_ayuda.set_size_request 80, 35      
  @b_ayuda.set_tooltip_text "Palabras admitidas"
  @b_ayuda.signal_connect "clicked" do
    ayuda_texto = %{
Solo se aceptan letras (así de caprichosas son las palabras).
Se admiten mayúsculas y minúsculas indistintamente, y aunque las vocales pueden ir acentuadas, es preferible no usar acentos.
El juego admite palabras compuestas por un mínimo de 4 letras y un máximo de 12.
La aplicación elimina cualquier otro caracter que no sea reconocido como una letra: números, símbolos, signos de puntuación, espacios...
El resto de normas respecto a las palabrás válidas serán acordadas entre los jugadores: nombres propios, conjugaciones verbales, plural, categorías (por ejemplo, animales), etc.}    
    md = Gtk::MessageDialog.new :parent => self, 
    :flags => :destroy_with_parent, :type => :info, 
    :buttons_type => :close, :message => ayuda_texto
    md.run
    md.destroy    
  end  
  @contenedor.put @b_ayuda, 350, 400          
  
  @titulo2.show
  @etiqueta2.show
  @entrada.show
  @b_ayuda.show  
  Gtk.main  #Gtk.main  ??????????????????????

end  # FIN INTRODUCIR

def initialize
  super
  init_ui
end

def init_ui  
  
  override_background_color :normal, Gdk::RGBA::new(0, 0.6, 0, 0.2)
  
  set_title "Juego del Ahorcado"
  signal_connect "destroy" do 
    Gtk.main_quit
    exit 
  end  
  set_default_size 500, 500
  set_border_width 10
  set_window_position :center  

  @contenedor = Gtk::Fixed.new  
  add @contenedor  
  
  @barra = Gtk::MenuBar.new  
  
  @menu = Gtk::Menu.new        
  #@item = Gtk::MenuItem.new(:label => "Juego")   # No valido en Ruby v 2.3.1
  @item = {}    
  @item = Gtk::MenuItem.new "Juego"
  @item.override_color :normal, Gdk::RGBA::new(1, 1, 1, 0.8)  
  @item.set_submenu @menu  
   
  #@nuevo =  Gtk::MenuItem.new(:label => "Nuevo")  # No valido en Ruby v 2.3.1
  @nuevo =  Gtk::MenuItem.new "Nuevo"
  @nuevo.signal_connect "activate" do
    introducir    
  end
  @menu.append @nuevo   
  
  #@exit = Gtk::MenuItem.new(:label => "Salir")   # No valido en Ruby v 2.3.1
  @exit = Gtk::MenuItem.new "Salir"  
  @exit.signal_connect "activate" do
    Gtk.main_quit    
    exit
  end        
  @menu.append @exit
  
  @menu2 = Gtk::Menu.new
  #@item2 = Gtk::MenuItem.new(:label => "Info")  # No valido en Ruby v 2.3.1
  @item2 = Gtk::MenuItem.new "Info"
  @item2.override_color :normal, Gdk::RGBA::new(1, 1, 1, 0.8)
  @item2.set_submenu @menu2
  
  #@ayuda =  Gtk::MenuItem.new(:label => "Ayuda") # No valido en Ruby v 2.3.1
  @ayuda =  Gtk::MenuItem.new "Ayuda"
  @ayuda.signal_connect "activate" do
    @mensaje_ayuda = %{Juego por turnos para dos jugadores.

Esta aplicación revive el clásico juego de lápiz y papel "El Ahorcado". El objetivo del juego es descubrir una palabra oculta.

Turno 1
El jugador 1 propone una palabra secreta y se dibuja una raya por cada letra.

Turno 2
El jugador 2 deberá acertar las letras que componen esa palabra.

Si la palabra oculta contiene esa letra, aparecerá en su lugar correspondiente (tantas veces como se repita).

En caso contrario, por cada error se dibuja una parte de la figura del ahorcado (cabeza, tronco y extremidades) y cada vez se está un poquito más cerca de 'morir' en la horca. La repetición del mismo error no penaliza. 

Se gana el juego si se completa la palabra antes de dibujar completamente el monigote del ahorcado, y se pierde si 'mueres' en la horca (al sexto error).}
    @md = Gtk::MessageDialog.new :parent => self, 
      :flags => :destroy_with_parent, :type => :info, 
      :buttons_type => :close, :message => @mensaje_ayuda
    @md.run
    @md.destroy
  end
  @menu2.append @ayuda

  #@about = Gtk::MenuItem.new(:label => "Créditos") # No valido en Ruby v 2.3.1
  @about_item = Gtk::MenuItem.new "Créditos" 
  @about_item.signal_connect "activate" do      
    
    @licencia = %{
    Licencia de Creative Commons CC BY_NC_SA 3.0 ES.
    Esta obra esta sujeta a la Licencia Reconocimiento-
    NoComercial-CompartirIgual 3.0 España de Creative Commons.
    Para ver una copia de esta licencia, visite
    http://creativecommons.org/licenses/by-nc-sa/3.0/es/.}
    @comentario = %{Revive el clásico juego de lápiz y papel 'El Ahorcado'.}    
    # @logo = GdkPixbuf::Pixbuf.new :file => "ahorcado.png"     # No valido en Ruby v 2.3.1
    @logo = Gdk::Pixbuf.new("ahorcado.png")
    @about = Gtk::AboutDialog.show(self, {
      :program_name => "Juego del Ahorcado",
      :version => "1.0 (2016)",
			:copyright => "(c) Jesús Cuerda Villanueva",
			:license => @licencia,
			:website => "https://misapp.wordpress.com",
			:website_label => "Web",
			:comments => @comentario,
			:authors => [
			  "Jesús Cuerda Villanueva.",
			  "Aplicación gratuita y sin publicidad.",
			  "Colabora con un donativo vía <a href='https://goo.gl/SukJub'>PayPal</a>.",
			  "Desarrollo con lenguaje de programación <a href='https://www.ruby-lang.org/es/'>Ruby</a>,",
			  "  e interfaz gráfica <a href='https://www.gtk.org/'>Gtk3</a>."],
      :logo => @logo
      })
    #@about.run      # No valido en Ruby v 2.3.1
    #@about.destroy  # No valido en Ruby v 2.3.1    
  end     
  
  @menu2.append @about_item
  
  @barra.append @item
  @barra.append @item2  
  @contenedor.put @barra, 0, 0
  
  @titulo_texto = "JUEGO DEL AHORCADO"
  @titulo = Gtk::Label.new(@titulo_texto)
  @titulo.override_color :normal, Gdk::RGBA::new(1, 1, 1, 0.8)
  @contenedor.put @titulo, 150, 50

  @imagen = Gtk::Image.new :file => "ahorcado.png"
  @contenedor.put @imagen, 150, 100
  
  @etiqueta_texto = %{Bienvenido al clásico juego de lápiz y papel 'El Ahorcado'.
Juego por turnos para dos jugadores.
  
Autor: Jesús Cuerda Villanueva. Versión: 1.0.
Licencia CC BY-NC-SA 3.0 ES.}
  @etiqueta = Gtk::Label.new @etiqueta_texto
  @etiqueta.override_color :normal, Gdk::RGBA::new(1, 1, 1, 0.5)
  @contenedor.put @etiqueta, 100, 250

  @b_inicio = Gtk::Button.new :label =>'Inicio'
  @b_inicio.can_focus=true
  @b_inicio.set_size_request 80, 35      
  @b_inicio.set_tooltip_text "Empieza a jugar"
  @b_inicio.signal_connect "clicked" do    
    introducir    
  end  
  @contenedor.put @b_inicio, 100, 400       
    
  @b_salir = Gtk::Button.new(:label => "Salir")
  @b_salir.set_size_request 80, 35     
  @b_salir.signal_connect ("clicked") do
    Gtk.main_quit   
    exit 
  end  
  @contenedor.put @b_salir, 350, 400
    
  show
  @contenedor.show
  @barra.show_all  
  @titulo.show
  @imagen.show
  @etiqueta.show
  @b_inicio.show
  @b_salir.show
  Gtk.main

end  # end init_ui

end  # end Clase

# Gtk.init
  window = RubyApp.new
Gtk.main
